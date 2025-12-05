import { createClient } from '@/lib/supabase/server'
import { getUserRole, getUserAssignedShops } from '@/lib/utils/roles'
import Link from 'next/link'
import { Store, Package, FileText, History } from 'lucide-react'

export default async function DashboardPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  const role = user ? await getUserRole(user.id) : null
  const isAdmin = role === 'admin'

  // Get stats based on role
  let shopsCount = 0
  if (isAdmin) {
    const { count } = await supabase
      .from('shops')
      .select('*', { count: 'exact', head: true })
    shopsCount = count || 0
  } else if (user) {
    // For staff, count assigned shops
    const assignedShopIds = await getUserAssignedShops(user.id)
    shopsCount = assignedShopIds.length
  }

  const { count: itemsCount } = await supabase
    .from('items')
    .select('*', { count: 'exact', head: true })

  const stats = [
    { name: 'Shops', value: shopsCount, icon: Store, href: '/dashboard/shops' },
    ...(isAdmin ? [
      { name: 'Items', value: itemsCount || 0, icon: Package, href: '/dashboard/inventory' },
    ] : []),
    { name: 'Reports', value: 'View', icon: FileText, href: '/dashboard/reports' },
    { name: 'History', value: 'View', icon: History, href: '/dashboard/history' },
  ]

  return (
    <div>
      <h1 className="text-3xl font-bold text-gray-900 mb-6">Dashboard</h1>
      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {stats.map((stat) => (
          <Link
            key={stat.name}
            href={stat.href}
            className="bg-white overflow-hidden shadow rounded-lg hover:shadow-md transition-shadow"
          >
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <stat.icon className="h-6 w-6 text-gray-400" />
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">
                      {stat.name}
                    </dt>
                    <dd className="text-lg font-medium text-gray-900">
                      {stat.value}
                    </dd>
                  </dl>
                </div>
              </div>
            </div>
          </Link>
        ))}
      </div>

      <div className="mt-8">
        <h2 className="text-xl font-semibold text-gray-900 mb-4">Quick Actions</h2>
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          <Link
            href="/dashboard/shops"
            className="bg-white p-6 rounded-lg shadow hover:shadow-md transition-shadow"
          >
            <h3 className="text-lg font-medium text-gray-900 mb-2">
              {isAdmin ? 'View All Shops' : 'My Shops'}
            </h3>
            <p className="text-sm text-gray-500">
              {isAdmin 
                ? 'Browse and manage all shops'
                : 'View and count stock in your assigned shops'}
            </p>
          </Link>
          <Link
            href="/dashboard/reports"
            className="bg-white p-6 rounded-lg shadow hover:shadow-md transition-shadow"
          >
            <h3 className="text-lg font-medium text-gray-900 mb-2">View Reports</h3>
            <p className="text-sm text-gray-500">
              {isAdmin 
                ? 'Analyze stock levels and trends'
                : 'View reports for your assigned shops'}
            </p>
          </Link>
          {isAdmin && (
            <Link
              href="/dashboard/inventory"
              className="bg-white p-6 rounded-lg shadow hover:shadow-md transition-shadow"
            >
              <h3 className="text-lg font-medium text-gray-900 mb-2">Manage Inventory</h3>
              <p className="text-sm text-gray-500">
                Add, edit, and manage products
              </p>
            </Link>
          )}
        </div>
      </div>
      
      {!isAdmin && shopsCount === 0 && (
        <div className="mt-8 bg-blue-50 border border-blue-200 rounded-lg p-6">
          <h3 className="text-lg font-semibold text-blue-900 mb-2">No Shops Assigned</h3>
          <p className="text-sm text-blue-800">
            You don&apos;t have any shops assigned to you yet. Please contact your administrator to assign shops for the current stock count period.
          </p>
          <p className="text-xs text-blue-700 mt-2">
            Shops are assigned through Stock Count Periods by administrators.
          </p>
        </div>
      )}
    </div>
  )
}


