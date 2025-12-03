import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { canManageUsers } from '@/lib/utils/roles'
import UserList from '@/components/users/UserList'

export default async function UsersPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  const canManage = await canManageUsers(user.id)
  if (!canManage) {
    redirect('/dashboard')
  }

  return <UserList />
}
