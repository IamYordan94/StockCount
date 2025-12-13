import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs'
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

// Helper to add timeout to async operations
function withTimeout<T>(promise: Promise<T>, timeoutMs: number): Promise<T> {
  return Promise.race([
    promise,
    new Promise<T>((_, reject) =>
      setTimeout(() => reject(new Error('Operation timed out')), timeoutMs)
    ),
  ])
}

export async function middleware(req: NextRequest) {
  const res = NextResponse.next()
  
  try {
    const supabase = createMiddlewareClient({ req, res })

    // Add timeout to session check (5 seconds max)
    const sessionResult = await withTimeout(
      supabase.auth.getSession(),
      5000
    ).catch(() => ({ data: { session: null }, error: { message: 'Timeout' } }))

    const session = sessionResult?.data?.session || null

    // Protect dashboard routes
    if (req.nextUrl.pathname.startsWith('/dashboard')) {
      if (!session) {
        return NextResponse.redirect(new URL('/login', req.url))
      }
    }

    // Protect login route - redirect to dashboard if already logged in
    if (req.nextUrl.pathname === '/login' && session) {
      return NextResponse.redirect(new URL('/dashboard', req.url))
    }
  } catch (error) {
    // If middleware fails, allow request through - page will handle auth
    // This prevents blocking all requests if Supabase is slow
    console.error('Middleware error:', error)
    
    // Only redirect dashboard if we're certain there's no auth cookie
    if (req.nextUrl.pathname.startsWith('/dashboard')) {
      const authCookie = req.cookies.get('sb-access-token') || req.cookies.get('sb-refresh-token')
      if (!authCookie) {
        return NextResponse.redirect(new URL('/login', req.url))
      }
      // If cookie exists, allow through - page will verify
    }
  }

  return res
}

export const config = {
  matcher: ['/dashboard/:path*', '/login'],
}

