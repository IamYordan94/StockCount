import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { createAdminClient } from '@/lib/supabase/admin'
import { canManageUsers } from '@/lib/utils/roles'

export async function GET(
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

    // Use admin client to get user details
    const adminClient = createAdminClient()
    const { data: authUser, error: authError } = await adminClient.auth.admin.getUserById(params.id)
    if (authError) {
      return NextResponse.json({ error: 'User not found' }, { status: 404 })
    }

    // Get role
    const { data: role } = await supabase
      .from('user_roles')
      .select('*')
      .eq('id', params.id)
      .single()

    // Get shop assignments
    const { data: assignments } = await supabase
      .from('shop_assignments')
      .select('shop_id, shops(name)')
      .eq('user_id', params.id)
      .eq('active', true)

    return NextResponse.json({
      id: authUser.user.id,
      email: authUser.user.email,
      role: role?.role || null,
      shop_id: role?.shop_id || null,
      must_change_password: role?.must_change_password || false,
      assigned_shops: assignments?.map(a => ({
        shop_id: a.shop_id,
        shop_name: (a.shops as any)?.name
      })) || []
    })
  } catch (error) {
    console.error('Error fetching user:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

export async function DELETE(
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

    // Prevent deleting yourself
    if (params.id === user.id) {
      return NextResponse.json({ error: 'Cannot delete your own account' }, { status: 400 })
    }

    // Use admin client to delete user (this will cascade delete user_roles and shop_assignments)
    const adminClient = createAdminClient()
    const { error } = await adminClient.auth.admin.deleteUser(params.id)

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error deleting user:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
