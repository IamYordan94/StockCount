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

  // Check shop assignments first
  const supabase = await createClient()
  const { data: assignment } = await supabase
    .from('shop_assignments')
    .select('id')
    .eq('user_id', userId)
    .eq('shop_id', shopId)
    .eq('active', true)
    .single()

  if (assignment) return true

  // Fallback to old shop_id in user_roles (for backward compatibility)
  const userShopId = await getUserShopId(userId)
  return userShopId === shopId
}

export async function getUserAssignedShops(userId: string): Promise<string[]> {
  const role = await getUserRole(userId)
  if (role === 'admin') {
    // Admins see all shops
    const supabase = await createClient()
    const { data: shops } = await supabase
      .from('shops')
      .select('id')
    return shops?.map(s => s.id) || []
  }

  const supabase = await createClient()
  const { data: assignments } = await supabase
    .from('shop_assignments')
    .select('shop_id')
    .eq('user_id', userId)
    .eq('active', true)

  return assignments?.map(a => a.shop_id) || []
}

export async function mustChangePassword(userId: string): Promise<boolean> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('user_roles')
    .select('must_change_password')
    .eq('id', userId)
    .single()

  if (error || !data) return false
  return data.must_change_password === true
}

export async function canManageUsers(userId: string): Promise<boolean> {
  const role = await getUserRole(userId)
  return role === 'admin'
}

