import { createClient } from '@supabase/supabase-js'
import { NextRequest, NextResponse } from 'next/server'

// Helper to get user from request (same as users route)
async function getUserFromRequest(request: NextRequest) {
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  
  if (!serviceRoleKey || !supabaseUrl || !supabaseAnonKey) {
    return { user: null, adminClient: null, error: 'Supabase configuration missing' }
  }

  const adminClient = createClient(supabaseUrl, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  })

  // Try Bearer token first - decode JWT to get user ID
  const authHeader = request.headers.get('authorization')
  if (authHeader?.startsWith('Bearer ')) {
    const token = authHeader.substring(7)
    
    try {
      // Decode JWT to get user ID (without verification, we'll verify by fetching)
      const parts = token.split('.')
      if (parts.length === 3) {
        // Decode the payload (second part)
        const payload = JSON.parse(Buffer.from(parts[1], 'base64').toString())
        const userId = payload.sub
        
        if (userId) {
          // Use admin client to get user by ID (this bypasses token verification)
          const { data: { user }, error } = await adminClient.auth.admin.getUserById(userId)
          if (user && !error) {
            return { user, adminClient, error: null }
          }
        }
      }
    } catch (e: any) {
      // Token decode failed, continue to other methods
    }
  }

  return { user: null, adminClient, error: 'No valid authentication found. Please log in again.' }
}

export async function GET(request: NextRequest) {
  try {
    const { user, adminClient, error: authError } = await getUserFromRequest(request)
    
    if (authError || !user || !adminClient) {
      return NextResponse.json({ error: authError || 'Unauthorized' }, { status: 401 })
    }

    // Check if user is manager
    const { data: roleData } = await adminClient
      .from('user_roles')
      .select('role')
      .eq('user_id', user.id)
      .single()

    if (roleData?.role !== 'manager') {
      return NextResponse.json({ error: 'Forbidden - Manager role required' }, { status: 403 })
    }

    // Fetch all statistics in parallel
    const [
      productsRes,
      shopsRes,
      usersRes,
      activeSessionsRes,
      completedSessionsRes,
      stockCountsRes,
    ] = await Promise.all([
      adminClient.from('items').select('id', { count: 'exact', head: true }),
      adminClient.from('shops').select('id', { count: 'exact', head: true }),
      adminClient.from('user_roles').select('id', { count: 'exact', head: true }),
      adminClient
        .from('stock_count_sessions')
        .select('id')
        .eq('status', 'active'),
      adminClient
        .from('stock_count_sessions')
        .select('id, completed_at')
        .eq('status', 'completed')
        .gte('completed_at', new Date(new Date().setDate(1)).toISOString()), // This month
      adminClient
        .from('stock_counts')
        .select('item_id, boxes, singles')
        .limit(1000), // Limit for performance
    ])

    // Calculate statistics
    const totalProducts = productsRes.count || 0
    const totalShops = shopsRes.count || 0
    const totalUsers = usersRes.count || 0
    const activeSessionsCount = activeSessionsRes.data?.length || 0
    const completedSessionsThisMonth = completedSessionsRes.data?.length || 0

    // Calculate most counted items
    const itemCounts: Record<string, { name: string; totalCount: number }> = {}
    
    if (stockCountsRes.data) {
      for (const count of stockCountsRes.data) {
        if (!itemCounts[count.item_id]) {
          itemCounts[count.item_id] = { name: '', totalCount: 0 }
        }
        itemCounts[count.item_id].totalCount += (count.boxes || 0) + (count.singles || 0)
      }
    }

    // Get item names for top counted items
    const topItemIds = Object.entries(itemCounts)
      .sort(([, a], [, b]) => b.totalCount - a.totalCount)
      .slice(0, 10)
      .map(([id]) => id)

    let topItems: { name: string; count: number }[] = []
    if (topItemIds.length > 0) {
      const { data: itemsData } = await adminClient
        .from('items')
        .select('id, name')
        .in('id', topItemIds)

      if (itemsData) {
        topItems = itemsData
          .map((item) => ({
            name: item.name,
            count: itemCounts[item.id]?.totalCount || 0,
          }))
          .sort((a, b) => b.count - a.count)
      }
    }

    // Get shop activity (sessions per shop)
    const { data: shopSessionsData } = await adminClient
      .from('stock_counts')
      .select('shop_id')
      .limit(1000)

    const shopActivity: Record<string, number> = {}
    if (shopSessionsData) {
      for (const count of shopSessionsData) {
        shopActivity[count.shop_id] = (shopActivity[count.shop_id] || 0) + 1
      }
    }

    // Get shop names
    const shopIds = Object.keys(shopActivity)
    let shopActivityList: { name: string; count: number }[] = []
    if (shopIds.length > 0) {
      const { data: shopsData } = await adminClient
        .from('shops')
        .select('id, name')
        .in('id', shopIds)

      if (shopsData) {
        shopActivityList = shopsData
          .map((shop) => ({
            name: shop.name,
            count: shopActivity[shop.id] || 0,
          }))
          .sort((a, b) => b.count - a.count)
      }
    }

    return NextResponse.json({
      totalProducts,
      totalShops,
      totalUsers,
      activeSessionsCount,
      completedSessionsThisMonth,
      topItems: topItems.slice(0, 5),
      shopActivity: shopActivityList.slice(0, 5),
    })
  } catch (error: any) {
    console.error('Analytics error:', error)
    return NextResponse.json({ error: error.message || 'Internal server error' }, { status: 500 })
  }
}

