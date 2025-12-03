import { createClient } from '@/lib/supabase/server'
import { Database } from '@/lib/types/database'

type Role = 'admin' | 'manager' | 'staff'

export async function getUserRole(userId: string): Promise<Role | null> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('user_roles')
    .select('role')
    .eq('id', userId)
    .single()

  if (error || !data) return null
  return data.role
}

export async function getUserShopId(userId: string): Promise<string | null> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('user_roles')
    .select('shop_id')
    .eq('id', userId)
    .single()

  if (error || !data) return null
  return data.shop_id
}

export async function canAccessShop(userId: string, shopId: string): Promise<boolean> {
  const role = await getUserRole(userId)
  if (role === 'admin') return true

  const userShopId = await getUserShopId(userId)
  return userShopId === shopId
}

export async function canManageUsers(userId: string): Promise<boolean> {
  const role = await getUserRole(userId)
  return role === 'admin'
}

