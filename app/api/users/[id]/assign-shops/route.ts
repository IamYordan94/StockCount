import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { canManageUsers } from '@/lib/utils/roles'

export async function POST(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const canManage = await canManageUsers(user.id)
    if (!canManage) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const body = await request.json()
    const { shop_ids } = body

    if (!Array.isArray(shop_ids)) {
      return NextResponse.json({ error: 'shop_ids must be an array' }, { status: 400 })
    }

    // Deactivate all current assignments
    await supabase
      .from('shop_assignments')
      .update({ active: false })
      .eq('user_id', params.id)

    // Create new assignments
    if (shop_ids.length > 0) {
      const assignments = shop_ids.map((shopId: string) => ({
        user_id: params.id,
        shop_id: shopId,
        assigned_by: user.id,
        active: true,
      }))

      const { error: insertError } = await supabase
        .from('shop_assignments')
        .insert(assignments)

      if (insertError) {
        return NextResponse.json({ error: insertError.message }, { status: 500 })
      }
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error assigning shops:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
