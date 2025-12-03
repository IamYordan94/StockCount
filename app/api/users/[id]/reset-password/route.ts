import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { createAdminClient } from '@/lib/supabase/admin'
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

    // Generate a random temporary password
    const tempPassword = Math.random().toString(36).slice(-12) + Math.random().toString(36).slice(-12).toUpperCase() + '!1'

    // Use admin client to update user password
    const adminClient = createAdminClient()
    const { error: updateError } = await adminClient.auth.admin.updateUserById(
      params.id,
      { password: tempPassword }
    )

    if (updateError) {
      return NextResponse.json({ error: updateError.message }, { status: 500 })
    }

    // Set must_change_password flag
    await supabase
      .from('user_roles')
      .update({ must_change_password: true })
      .eq('id', params.id)

    return NextResponse.json({
      success: true,
      temporary_password: tempPassword, // Return so admin can share it
    })
  } catch (error) {
    console.error('Error resetting password:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
