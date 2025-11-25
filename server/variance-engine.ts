import { db } from "./db";
import { movements, costs, varianceThresholds, items, countLines, counts } from "@shared/schema";
import { eq, and, lte, gte, sql, desc, or, isNull, lt } from "drizzle-orm";

export interface VarianceResult {
  itemId: number;
  countedQty: number; // total in UOM (boxes * unitsPerBox + singles / unitsPerBox)
  expectedQty: number;
  varianceQty: number;
  varianceCost: number;
  varianceSeverity: 'INFO' | 'WARN' | 'CRITICAL';
}

/**
 * Compute expected stock for an item at a shop within a period
 * Expected = Opening + Purchases - Sales - Transfers_Out + Transfers_In - Wastage
 */
async function computeExpectedStock(
  shopId: number,
  itemId: number,
  periodStart: Date,
  periodEnd: Date
): Promise<number> {
  // Get opening balance from last approved count or OPENING movement before period start
  let opening = 0;
  
  // First try to get from OPENING movement right before period start
  const openingMovement = await db
    .select()
    .from(movements)
    .where(
      and(
        eq(movements.shopId, shopId),
        eq(movements.itemId, itemId),
        eq(movements.type, 'OPENING'),
        lte(movements.occurredAt, periodStart)
      )
    )
    .orderBy(desc(movements.occurredAt))
    .limit(1);
  
  if (openingMovement.length > 0) {
    opening = parseFloat(openingMovement[0].quantity);
  } else {
    // Fallback: get last approved count before period start
    const lastApprovedCount = await db
      .select({
        countId: counts.id,
        countedAt: counts.countedAt
      })
      .from(counts)
      .where(
        and(
          eq(counts.shopId, shopId),
          eq(counts.status, 'APPROVED'),
          lt(counts.countedAt, periodStart)
        )
      )
      .orderBy(desc(counts.countedAt))
      .limit(1);
    
    if (lastApprovedCount.length > 0) {
      // Get the actual quantity from count_lines for this item
      const line = await db
        .select()
        .from(countLines)
        .where(
          and(
            eq(countLines.countId, lastApprovedCount[0].countId),
            eq(countLines.itemId, itemId)
          )
        )
        .limit(1);
      
      if (line.length > 0) {
        opening = parseFloat(line[0].actualQty);
      }
    }
  }
  
  // Get all movements for this shop/item within the period
  const movementData = await db
    .select()
    .from(movements)
    .where(
      and(
        eq(movements.shopId, shopId),
        eq(movements.itemId, itemId),
        gte(movements.occurredAt, periodStart),
        lte(movements.occurredAt, periodEnd)
      )
    );

  // Calculate expected based on movement types
  let expected = opening;

  for (const movement of movementData) {
    const qty = parseFloat(movement.quantity);
    
    switch (movement.type) {
      case 'OPENING':
        expected = qty; // Opening within period replaces the starting balance
        break;
      case 'PURCHASE':
      case 'TRANSFER_IN':
        expected += qty;
        break;
      case 'SALE':
      case 'TRANSFER_OUT':
      case 'WASTAGE':
        expected -= qty;
        break;
    }
  }

  return expected; // Return actual expected value (can be negative if oversold)
}

/**
 * Get the effective cost for an item at a specific date
 */
async function getEffectiveCost(itemId: number, asOfDate: Date): Promise<number> {
  const cost = await db
    .select()
    .from(costs)
    .where(
      and(
        eq(costs.itemId, itemId),
        lte(costs.effectiveFrom, asOfDate)
      )
    )
    .orderBy(desc(costs.effectiveFrom))
    .limit(1);

  return cost.length > 0 ? parseFloat(cost[0].costPerUom) : 0;
}

/**
 * Get variance threshold for shop/item (or global default)
 */
async function getVarianceThreshold(
  shopId: number,
  itemId: number,
  asOfDate: Date
) {
  // Try shop+item specific threshold first
  let threshold = await db
    .select()
    .from(varianceThresholds)
    .where(
      and(
        eq(varianceThresholds.shopId, shopId),
        eq(varianceThresholds.itemId, itemId),
        lte(varianceThresholds.effectiveFrom, asOfDate)
      )
    )
    .orderBy(desc(varianceThresholds.effectiveFrom))
    .limit(1);

  // Fall back to shop-wide threshold
  if (threshold.length === 0) {
    threshold = await db
      .select()
      .from(varianceThresholds)
      .where(
        and(
          eq(varianceThresholds.shopId, shopId),
          isNull(varianceThresholds.itemId),
          lte(varianceThresholds.effectiveFrom, asOfDate)
        )
      )
      .orderBy(desc(varianceThresholds.effectiveFrom))
      .limit(1);
  }

  // Fall back to global default
  if (threshold.length === 0) {
    threshold = await db
      .select()
      .from(varianceThresholds)
      .where(
        and(
          isNull(varianceThresholds.shopId),
          isNull(varianceThresholds.itemId),
          lte(varianceThresholds.effectiveFrom, asOfDate)
        )
      )
      .orderBy(desc(varianceThresholds.effectiveFrom))
      .limit(1);
  }

  // Ultimate fallback: hardcoded defaults
  if (threshold.length === 0) {
    return {
      warnPercentage: 3,
      criticalPercentage: 10,
      warnAbsolute: 0.5,
      criticalAbsolute: 2
    };
  }

  const t = threshold[0];
  return {
    warnPercentage: parseFloat(t.warnPercentage),
    criticalPercentage: parseFloat(t.criticalPercentage),
    warnAbsolute: parseFloat(t.warnAbsolute),
    criticalAbsolute: parseFloat(t.criticalAbsolute)
  };
}

/**
 * Determine variance severity based on thresholds
 */
function calculateSeverity(
  varianceQty: number,
  expectedQty: number,
  thresholds: {
    warnPercentage: number;
    criticalPercentage: number;
    warnAbsolute: number;
    criticalAbsolute: number;
  }
): 'INFO' | 'WARN' | 'CRITICAL' {
  const absVariance = Math.abs(varianceQty);
  
  // Calculate percentage variance (avoid division by zero)
  const percentageVariance = expectedQty > 0 
    ? (absVariance / expectedQty) * 100 
    : 0;

  // Check critical thresholds
  if (
    percentageVariance >= thresholds.criticalPercentage ||
    absVariance >= thresholds.criticalAbsolute
  ) {
    return 'CRITICAL';
  }

  // Check warning thresholds
  if (
    percentageVariance >= thresholds.warnPercentage ||
    absVariance >= thresholds.warnAbsolute
  ) {
    return 'WARN';
  }

  return 'INFO';
}

/**
 * Compute variance for a single count line
 */
export async function computeVarianceForLine(
  shopId: number,
  itemId: number,
  boxes: number,
  singles: number,
  periodStart: Date,
  periodEnd: Date
): Promise<VarianceResult> {
  // Get item details for UOM conversion
  const item = await db
    .select()
    .from(items)
    .where(eq(items.id, itemId))
    .limit(1);

  if (item.length === 0) {
    throw new Error(`Item ${itemId} not found`);
  }

  const unitsPerBox = item[0].unitsPerBox;
  
  // Convert counted quantity to UOM
  // countedQty = boxes + (singles / unitsPerBox)
  const countedQty = boxes + (singles / unitsPerBox);

  // Compute expected stock
  const expectedQty = await computeExpectedStock(
    shopId,
    itemId,
    periodStart,
    periodEnd
  );

  // Calculate variance
  const varianceQty = countedQty - expectedQty;

  // Get cost and calculate financial impact
  const costPerUom = await getEffectiveCost(itemId, periodEnd);
  const varianceCost = varianceQty * costPerUom;

  // Get thresholds and determine severity
  const thresholds = await getVarianceThreshold(shopId, itemId, periodEnd);
  const varianceSeverity = calculateSeverity(
    varianceQty,
    expectedQty,
    thresholds
  );

  return {
    itemId,
    countedQty,
    expectedQty,
    varianceQty,
    varianceCost,
    varianceSeverity
  };
}

/**
 * Compute variances for all lines in a count
 */
export async function computeVariancesForCount(
  countId: string,
  shopId: number,
  periodStart: Date,
  periodEnd: Date,
  lines: Array<{ itemId: number; boxes: number; singles: number }>
): Promise<VarianceResult[]> {
  const results: VarianceResult[] = [];

  for (const line of lines) {
    const variance = await computeVarianceForLine(
      shopId,
      line.itemId,
      line.boxes,
      line.singles,
      periodStart,
      periodEnd
    );
    results.push(variance);
  }

  return results;
}

/**
 * Persist variance results to count_lines table
 */
export async function persistVarianceResults(
  countId: string,
  variances: VarianceResult[]
): Promise<void> {
  for (const variance of variances) {
    await db
      .update(countLines)
      .set({
        expectedQty: variance.expectedQty.toString(),
        varianceQty: variance.varianceQty.toString(),
        varianceCost: variance.varianceCost.toString(),
        varianceSeverity: variance.varianceSeverity,
        computedAt: new Date()
      })
      .where(
        and(
          eq(countLines.countId, countId),
          eq(countLines.itemId, variance.itemId)
        )
      );
  }
}
