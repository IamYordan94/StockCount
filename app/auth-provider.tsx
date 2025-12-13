'use client'

import { createContext, useContext, useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase'
import { User } from '@supabase/supabase-js'

interface AuthContextType {
  user: User | null
  loading: boolean
  role: 'manager' | 'employee' | null
  userName: string | null
}

const AuthContext = createContext<AuthContextType>({
  user: null,
  loading: true,
  role: null,
  userName: null,
})

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const [role, setRole] = useState<'manager' | 'employee' | null>(null)
  const [userName, setUserName] = useState<string | null>(null)
  const supabase = createClient()

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null)
      if (session?.user) {
        fetchUserRole(session.user.id)
      } else {
        setLoading(false)
      }
    })

    // Listen for auth changes
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null)
      if (session?.user) {
        fetchUserRole(session.user.id)
      } else {
        setRole(null)
        setLoading(false)
      }
    })

    return () => subscription.unsubscribe()
  }, [])

  async function fetchUserRole(userId: string) {
    try {
      console.log('Fetching role for user:', userId)
      // Use maybeSingle to avoid errors when no role exists
      const { data, error } = await supabase
        .from('user_roles')
        .select('role, name')
        .eq('user_id', userId)
        .maybeSingle()

      console.log('Role query result:', { data, error })

      if (error) {
        console.error('Error fetching user role:', error)
        // Check for infinite recursion error specifically
        if (error.message?.includes('infinite recursion')) {
          console.error('RLS policy recursion detected! Run migration 011_fix_user_roles_rls.sql in Supabase')
        }
        setRole(null)
        setUserName(null)
      } else if (data) {
        // Type assertion to fix TypeScript inference issue with Supabase query
        const roleData = data as { role: string; name: string | null } | null
        if (roleData && roleData.role) {
          console.log('Role found:', roleData.role)
          setRole((roleData.role as 'manager' | 'employee') || null)
          setUserName(roleData.name || null)
        } else {
          setRole(null)
          setUserName(null)
        }
      } else {
        console.log('No role data returned - role not set in database')
        setRole(null)
        setUserName(null)
      }
    } catch (err) {
      console.error('Error in fetchUserRole:', err)
      setRole(null)
      setUserName(null)
    } finally {
      setLoading(false)
    }
  }

  return (
    <AuthContext.Provider value={{ user, loading, role, userName }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  return useContext(AuthContext)
}

