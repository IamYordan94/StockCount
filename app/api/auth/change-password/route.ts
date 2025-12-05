import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { createAdminClient } from '@/lib/supabase/admin'

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const { newPassword } = body

    if (!newPassword || newPassword.length < 6) {
      return NextResponse.json({ error: 'Password must be at least 6 characters' }, { status: 400 })
    }

    // Update password
    const { error: updateError } = await supabase.auth.updateUser({
      password: newPassword,
    })

    if (updateError) {
      return NextResponse.json({ error: updateError.message }, { status: 400 })
    }

    // Clear must_change_password flag
    // Try with regular client first, fallback to admin client if RLS blocks it
    const { error: updateRoleError } = await supabase
      .from('user_roles')
      .update({ must_change_password: false })
      .eq('id', user.id)

    // If RLS blocks the update, use admin client
    if (updateRoleError) {
      console.warn('RLS blocked user_roles update, using admin client:', updateRoleError)
      const adminClient = createAdminClient()
      const { error: adminUpdateError } = await adminClient
        .from('user_roles')
        .update({ must_change_password: false })
        .eq('id', user.id)

      if (adminUpdateError) {
        console.error('Failed to update must_change_password even with admin client:', adminUpdateError)
        // Don't fail the password change - password was already updated
        // Just log the error
      }
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error changing password:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}
