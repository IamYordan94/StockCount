export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      categories: {
        Row: {
          id: string
          name: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          created_at?: string
          updated_at?: string
        }
      }
      shops: {
        Row: {
          id: string
          name: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          created_at?: string
          updated_at?: string
        }
      }
      items: {
        Row: {
          id: string
          name: string
          category_id: string
          pack_size: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          category_id: string
          pack_size: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          category_id?: string
          pack_size?: string
          created_at?: string
          updated_at?: string
        }
      }
      shop_items: {
        Row: {
          id: string
          shop_id: string
          item_id: string
          created_at: string
        }
        Insert: {
          id?: string
          shop_id: string
          item_id: string
          created_at?: string
        }
        Update: {
          id?: string
          shop_id?: string
          item_id?: string
          created_at?: string
        }
      }
      stock_count_sessions: {
        Row: {
          id: string
          name: string
          status: string
          created_by: string | null
          created_at: string
          completed_at: string | null
        }
        Insert: {
          id?: string
          name: string
          status?: string
          created_by?: string | null
          created_at?: string
          completed_at?: string | null
        }
        Update: {
          id?: string
          name?: string
          status?: string
          created_by?: string | null
          created_at?: string
          completed_at?: string | null
        }
      }
      stock_counts: {
        Row: {
          id: string
          session_id: string
          shop_id: string
          item_id: string
          boxes: number
          singles: number
          counted_by: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          session_id: string
          shop_id: string
          item_id: string
          boxes?: number
          singles?: number
          counted_by?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          session_id?: string
          shop_id?: string
          item_id?: string
          boxes?: number
          singles?: number
          counted_by?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      user_roles: {
        Row: {
          id: string
          user_id: string
          role: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          role?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          role?: string
          created_at?: string
          updated_at?: string
        }
      }
      user_shop_assignments: {
        Row: {
          id: string
          user_id: string
          shop_id: string
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          shop_id: string
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          shop_id?: string
          created_at?: string
        }
      }
    }
  }
}

