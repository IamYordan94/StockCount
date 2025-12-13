// Shared types for the application

export interface User {
  id: string
  email: string
  role: 'manager' | 'employee' | null
  shops?: Shop[]
}

export interface Shop {
  id: string
  name: string
  created_at?: string
  updated_at?: string
}

export interface Category {
  id: string
  name: string
  created_at?: string
  updated_at?: string
}

export interface Item {
  id: string
  name: string
  pack_size: string
  category_id: string
  categories?: Category
  created_at?: string
  updated_at?: string
}

export interface ShopItem {
  id: string
  shop_id: string
  item_id: string
  shops?: Shop
  items?: Item
  created_at?: string
}

export interface StockCountSession {
  id: string
  name: string
  status: 'active' | 'completed' | 'archived'
  created_by?: string
  created_at: string
  completed_at?: string | null
}

export interface StockCount {
  id?: string
  session_id: string
  shop_id: string
  item_id: string
  boxes: number
  singles: number
  counted_by?: string
  created_at?: string
  updated_at?: string
  items?: Item
  shops?: Shop
}

export interface UserRole {
  id: string
  user_id: string
  role: 'manager' | 'employee'
  created_at?: string
  updated_at?: string
}

export interface UserShopAssignment {
  id: string
  user_id: string
  shop_id: string
  shops?: Shop
  created_at?: string
}

