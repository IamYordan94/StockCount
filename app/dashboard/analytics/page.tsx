'use client'

import { useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import { useAuth } from '../../auth-provider'
import { createClient } from '@/lib/supabase'
import Link from 'next/link'
import { ArrowLeft, Package, Store, Users, FileSpreadsheet, TrendingUp, BarChart3 } from 'lucide-react'
import LoadingSpinner from '@/components/ui/LoadingSpinner'
import HelpButton from '@/components/ui/HelpButton'
import UserManual from '@/components/ui/UserManual'

interface AnalyticsData {
  totalProducts: number
  totalShops: number
  totalUsers: number
  activeSessionsCount: number
  completedSessionsThisMonth: number
  topItems: { name: string; count: number }[]
  shopActivity: { name: string; count: number }[]
}

export default function AnalyticsPage() {
  const { user, loading, role } = useAuth()
  const router = useRouter()
  const supabase = createClient()
  const [analyticsData, setAnalyticsData] = useState<AnalyticsData | null>(null)
  const [loadingData, setLoadingData] = useState(true)
  const [showManual, setShowManual] = useState(false)

  useEffect(() => {
    if (!loading && (!user || role !== 'manager')) {
      router.push('/dashboard')
      return
    }
    if (user && role === 'manager') {
      fetchAnalytics()
    }
  }, [user, loading, role, router])

  async function fetchAnalytics() {
    try {
      setLoadingData(true)
      const { data: { session } } = await supabase.auth.getSession()

      if (!session) {
        return
      }

      const response = await fetch('/api/analytics', {
        credentials: 'include',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${session.access_token}`,
        },
      })

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}))
        throw new Error(errorData.error || `Error fetching analytics: ${response.status}`)
      }

      const data = await response.json()
      setAnalyticsData(data)
    } catch (err: any) {
      console.error('Error fetching analytics:', err)
    } finally {
      setLoadingData(false)
    }
  }

  if (loading || loadingData) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <LoadingSpinner size="lg" />
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50">
      <div className="bg-white/80 backdrop-blur-md shadow-medium border-b border-white/20 sticky top-0 z-50">
        <div className="container-mobile py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Link href="/dashboard" className="text-gray-600 hover:text-gray-900 hover:bg-gray-100 p-2 rounded-xl transition-all">
                <ArrowLeft size={20} />
              </Link>
              <h1 className="text-2xl font-bold bg-gradient-to-r from-primary-600 to-indigo-600 bg-clip-text text-transparent">Analytics</h1>
            </div>
            <HelpButton onClick={() => setShowManual(true)} />
          </div>
        </div>
      </div>

      <div className="container-mobile py-6">
        {analyticsData ? (
          <div className="space-y-6">
            {/* Overview Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-2">
                  <div className="p-2 bg-gradient-to-br from-primary-500 to-indigo-600 rounded-lg">
                    <Package className="text-white" size={20} />
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Total Products</p>
                    <p className="text-2xl font-bold text-gray-900">{analyticsData.totalProducts}</p>
                  </div>
                </div>
              </div>

              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-2">
                  <div className="p-2 bg-gradient-to-br from-amber-500 to-orange-600 rounded-lg">
                    <Store className="text-white" size={20} />
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Total Shops</p>
                    <p className="text-2xl font-bold text-gray-900">{analyticsData.totalShops}</p>
                  </div>
                </div>
              </div>

              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-2">
                  <div className="p-2 bg-gradient-to-br from-emerald-500 to-teal-600 rounded-lg">
                    <Users className="text-white" size={20} />
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Total Users</p>
                    <p className="text-2xl font-bold text-gray-900">{analyticsData.totalUsers}</p>
                  </div>
                </div>
              </div>

              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-2">
                  <div className="p-2 bg-gradient-to-br from-purple-500 to-pink-600 rounded-lg">
                    <FileSpreadsheet className="text-white" size={20} />
                  </div>
                  <div>
                    <p className="text-sm text-gray-600">Active Sessions</p>
                    <p className="text-2xl font-bold text-gray-900">{analyticsData.activeSessionsCount}</p>
                  </div>
                </div>
              </div>
            </div>

            {/* Additional Stats */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-4">
                  <TrendingUp className="text-primary-600" size={24} />
                  <h2 className="text-lg font-bold text-gray-900">This Month</h2>
                </div>
                <div className="space-y-3">
                  <div className="flex justify-between items-center">
                    <span className="text-gray-600">Completed Sessions</span>
                    <span className="text-2xl font-bold text-gray-900">{analyticsData.completedSessionsThisMonth}</span>
                  </div>
                </div>
              </div>

              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-4">
                  <BarChart3 className="text-primary-600" size={24} />
                  <h2 className="text-lg font-bold text-gray-900">Most Counted Items</h2>
                </div>
                <div className="space-y-2">
                  {analyticsData.topItems.length > 0 ? (
                    analyticsData.topItems.map((item, index) => (
                      <div key={index} className="flex justify-between items-center py-2 border-b border-gray-100 last:border-0">
                        <span className="text-gray-700">{item.name}</span>
                        <span className="font-semibold text-primary-600">{item.count}</span>
                      </div>
                    ))
                  ) : (
                    <p className="text-sm text-gray-500">No counting data yet</p>
                  )}
                </div>
              </div>
            </div>

            {/* Shop Activity */}
            {analyticsData.shopActivity.length > 0 && (
              <div className="bg-white/80 backdrop-blur-md p-6 rounded-2xl shadow-medium border border-white/20">
                <div className="flex items-center gap-3 mb-4">
                  <Store className="text-primary-600" size={24} />
                  <h2 className="text-lg font-bold text-gray-900">Shop Activity</h2>
                </div>
                <div className="space-y-2">
                  {analyticsData.shopActivity.map((shop, index) => (
                    <div key={index} className="flex justify-between items-center py-2 border-b border-gray-100 last:border-0">
                      <span className="text-gray-700">{shop.name}</span>
                      <span className="font-semibold text-primary-600">{shop.count} counts</span>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        ) : (
          <div className="bg-white/80 backdrop-blur-md p-8 rounded-2xl shadow-medium border border-white/20 text-center">
            <p className="text-gray-600">Unable to load analytics data</p>
          </div>
        )}
      </div>

      <UserManual isOpen={showManual} onClose={() => setShowManual(false)} />
    </div>
  )
}

