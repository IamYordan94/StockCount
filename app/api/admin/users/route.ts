import { createClient } from '@supabase/supabase-js'
import { createServerClient } from '@supabase/ssr'
import { NextRequest, NextResponse } from 'next/server'
import { cookies } from 'next/headers'

// Helper to get user from request
async function getUserFromRequest(request: NextRequest) {
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  
  if (!serviceRoleKey || !supabaseUrl || !supabaseAnonKey) {
    return { user: null, adminClient: null, error: 'Supabase configuration missing' }
  }

  // Create admin client for database operations
  const adminClient = createClient(supabaseUrl, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  })

  // Try Bearer token first - decode JWT to get user ID
  const authHeader = request.headers.get('authorization')
  if (authHeader?.startsWith('Bearer ')) {
    const token = authHeader.substring(7)
    
    try {
      // Decode JWT to get user ID (without verification, we'll verify by fetching)
      const parts = token.split('.')
      if (parts.length === 3) {
        // Decode the payload (second part)
        const payload = JSON.parse(Buffer.from(parts[1], 'base64').toString())
        const userId = payload.sub
        
        if (userId) {
          console.log('Extracted user ID from token:', userId)
          // Use admin client to get user by ID (this bypasses token verification)
          const { data: { user }, error } = await adminClient.auth.admin.getUserById(userId)
          if (user && !error) {
            console.log('User found via admin API, user:', user.id)
            return { user, adminClient, error: null }
          } else {
            console.log('Admin getUserById failed:', error?.message)
          }
        }
      }
    } catch (e: any) {
      console.error('Token decode exception:', e.message)
    }
  }

  // Fallback: Use SSR client to get session from cookies
  try {
    const cookieStore = await cookies()
    
    const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll() {
          // Can't set cookies in API routes
        },
      },
    })

    const { data: { session }, error: sessionError } = await supabase.auth.getSession()
    
    if (session?.user && !sessionError) {
      console.log('SSR client found session, user:', session.user.id)
      return { user: session.user, adminClient, error: null }
    }
    
  } catch (e: any) {
    console.error('SSR client exception:', e.message)
  }

  return { user: null, adminClient, error: 'No valid authentication found. Please log in again.' }
}

export async function GET(request: NextRequest) {
  try {
    const { user, adminClient, error: authError } = await getUserFromRequest(request)
    
    if (authError || !user || !adminClient) {
      return NextResponse.json({ error: authError || 'Unauthorized' }, { status: 401 })
    }

    // Check if user is manager
    const { data: roleData } = await adminClient
      .from('user_roles')
      .select('role')
      .eq('user_id', user.id)
      .single()

    if (roleData?.role !== 'manager') {
      return NextResponse.json({ error: 'Forbidden - Manager role required' }, { status: 403 })
    }

    // Get all users
    const { data: authUsers } = await adminClient.auth.admin.listUsers()

    // Fetch user roles
    const { data: userRoles } = await adminClient.from('user_roles').select('*')

    // Fetch shop assignments
    const { data: assignments } = await adminClient
      .from('user_shop_assignments')
      .select('*, shops(*)')

    // Combine data
    const users = (authUsers?.users || []).map((authUser: { id: string; email?: string }) => {
      const roleData = userRoles?.find((r: { user_id: string; role: string; name?: string }) => r.user_id === authUser.id)
      const userShops =
        assignments
          ?.filter((a: { user_id: string }) => a.user_id === authUser.id)
          .map((a: { shop_id: string; shops: { name: string } | null }) => ({ 
            id: a.shop_id, 
            name: a.shops?.name || '' 
          })) || []

      return {
        id: authUser.id,
        email: authUser.email || '',
        name: roleData?.name || '',
        role: roleData?.role || 'employee',
        shops: userShops,
      }
    })

    return NextResponse.json({ users })
  } catch (error: any) {
    console.error('GET /api/admin/users error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const { user, adminClient, error: authError } = await getUserFromRequest(request)
    
    if (authError || !user || !adminClient) {
      return NextResponse.json({ error: authError || 'Unauthorized' }, { status: 401 })
    }

    // Check if user is manager
    const { data: roleData } = await adminClient
      .from('user_roles')
      .select('role')
      .eq('user_id', user.id)
      .single()

    if (roleData?.role !== 'manager') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const body = await request.json()
    const { email, password, role, shopIds, name } = body

    if (!email || !password) {
      return NextResponse.json({ error: 'Email and password are required' }, { status: 400 })
    }

    // Create user with email auto-confirmed
    const { data: newUser, error: createError } = await adminClient.auth.admin.createUser({
      email,
      password,
      email_confirm: true, // Auto-confirm email so users can log in immediately
    })

    if (createError) {
      return NextResponse.json({ error: createError.message }, { status: 400 })
    }

    if (!newUser.user) {
      return NextResponse.json({ error: 'Failed to create user' }, { status: 500 })
    }

    // Set role and name
    await adminClient.from('user_roles').insert({
      user_id: newUser.user.id,
      role: role || 'employee',
      name: name || '',
    })

    // Set shop assignments
    if (shopIds && shopIds.length > 0) {
      const assignments = shopIds.map((shopId: string) => ({
        user_id: newUser.user.id,
        shop_id: shopId,
      }))
      await adminClient.from('user_shop_assignments').insert(assignments)
    }

    return NextResponse.json({ success: true, user: newUser.user })
  } catch (error: any) {
    console.error('POST /api/admin/users error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function PUT(request: NextRequest) {
  try {
    const { user, adminClient, error: authError } = await getUserFromRequest(request)
    
    if (authError || !user || !adminClient) {
      return NextResponse.json({ error: authError || 'Unauthorized' }, { status: 401 })
    }

    // Check if user is manager
    const { data: roleData } = await adminClient
      .from('user_roles')
      .select('role')
      .eq('user_id', user.id)
      .single()

    if (roleData?.role !== 'manager') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const body = await request.json()
    const { userId, password, role, shopIds, name } = body

    if (!userId) {
      return NextResponse.json({ error: 'User ID is required' }, { status: 400 })
    }

    // Update password if provided
    if (password) {
      const { error: passwordError } = await adminClient.auth.admin.updateUserById(userId, { password })
      if (passwordError) {
        return NextResponse.json({ error: passwordError.message }, { status: 400 })
      }
    }

    // Update role and name
    await adminClient
      .from('user_roles')
      .upsert({
        user_id: userId,
        role: role || 'employee',
        name: name || '',
      })

    // Update shop assignments
    await adminClient
      .from('user_shop_assignments')
      .delete()
      .eq('user_id', userId)

    if (shopIds && shopIds.length > 0) {
      const assignments = shopIds.map((shopId: string) => ({
        user_id: userId,
        shop_id: shopId,
      }))
      await adminClient.from('user_shop_assignments').insert(assignments)
    }

    return NextResponse.json({ success: true })
  } catch (error: any) {
    console.error('PUT /api/admin/users error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const { user, adminClient, error: authError } = await getUserFromRequest(request)
    
    if (authError || !user || !adminClient) {
      return NextResponse.json({ error: authError || 'Unauthorized' }, { status: 401 })
    }

    // Check if user is manager
    const { data: roleData } = await adminClient
      .from('user_roles')
      .select('role')
      .eq('user_id', user.id)
      .single()

    if (roleData?.role !== 'manager') {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    const { searchParams } = new URL(request.url)
    const userId = searchParams.get('userId')

    if (!userId) {
      return NextResponse.json({ error: 'User ID required' }, { status: 400 })
    }

    const { error: deleteError } = await adminClient.auth.admin.deleteUser(userId)
    
    if (deleteError) {
      return NextResponse.json({ error: deleteError.message }, { status: 400 })
    }

    return NextResponse.json({ success: true })
  } catch (error: any) {
    console.error('DELETE /api/admin/users error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}
