import { createClient } from './supabase'
import { User } from '@supabase/supabase-js'

export async function getUser(): Promise<User | null> {
  const supabase = createClient()
  const { data: { user } } = await supabase.auth.getUser()
  return user
}

export async function getUserRole(): Promise<'manager' | 'employee' | null> {
  const user = await getUser()
  if (!user) return null

  const supabase = createClient()
  const { data } = await supabase
    .from('user_roles')
    .select('role')
    .eq('user_id', user.id)
    .single()

  const roleData = data as { role: string } | null
  return (roleData?.role as 'manager' | 'employee') || null
}

export async function isManager(): Promise<boolean> {
  const role = await getUserRole()
  return role === 'manager'
}

