import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { canAccessShop } from '@/lib/utils/roles'

export async function GET(
  request: NextRequest,
  { params }: { params: { shopId: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Check access
    const hasAccess = await canAccessShop(user.id, params.shopId)
    if (!hasAccess) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    // Get stock for this shop
    const { data: stock, error: stockError } = await supabase
      .from('shop_stock')
      .select(`
        *,
        items (
          id,
          name,
          category,
          packaging_unit_description
        )
      `)
      .eq('shop_id', params.shopId)
      .order('items(category)', { ascending: true })
      .order('items(name)', { ascending: true })

    if (stockError) {
      return NextResponse.json({ error: stockError.message }, { status: 500 })
    }

    // Transform data
    const items = (stock || []).map((s: any) => ({
      id: s.id,
      item_id: s.item_id,
      item_name: s.items.name,
      category: s.items.category,
      packaging_unit_description: s.items.packaging_unit_description,
      packaging_units: s.packaging_units,
      loose_pieces: s.loose_pieces,
      last_counted_at: s.last_counted_at,
      last_counted_by: s.last_counted_by,
    }))

    return NextResponse.json({ items })
  } catch (error) {
    console.error('Error fetching stock:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

