import { createClient } from '@/lib/supabase/server'
import { getUserRole } from '@/lib/utils/roles'

export default async function DebugPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    return <div>Not logged in</div>
  }

  const role = await getUserRole(user.id)

  // Get user_roles entry
  const { data: userRoleData, error: roleError } = await supabase
    .from('user_roles')
    .select('*')
    .eq('id', user.id)
    .single()

  // Get shops count
  const { data: shops, error: shopsError, count: shopsCount } = await supabase
    .from('shops')
    .select('id, name', { count: 'exact' })

  // Get items count
  const { data: items, error: itemsError, count: itemsCount } = await supabase
    .from('items')
    .select('id', { count: 'exact' })

  return (
    <div className="max-w-4xl mx-auto p-6">
      <h1 className="text-2xl font-bold mb-4">Debug: User Role Information</h1>
      
      <div className="bg-white shadow rounded-lg p-6 space-y-4">
        <div>
          <h2 className="font-semibold">User Info</h2>
          <p>Email: {user.email}</p>
          <p>User ID: {user.id}</p>
        </div>

        <div>
          <h2 className="font-semibold">Role Check Result</h2>
          <p>getUserRole() returned: <strong>{role || 'null'}</strong></p>
          <p>Is Admin: <strong>{role === 'admin' ? 'YES' : 'NO'}</strong></p>
        </div>

        <div>
          <h2 className="font-semibold">Database user_roles Entry</h2>
          {roleError ? (
            <p className="text-red-600">Error: {roleError.message}</p>
          ) : userRoleData ? (
            <pre className="bg-gray-100 p-4 rounded overflow-auto">
              {JSON.stringify(userRoleData, null, 2)}
            </pre>
          ) : (
            <p className="text-yellow-600">No user_roles entry found!</p>
          )}
        </div>

        <div>
          <h2 className="font-semibold">Database Status</h2>
          <p>Shops in database: <strong>{shopsCount ?? shops?.length ?? 0}</strong></p>
          {shopsError && (
            <div className="mt-2 p-3 bg-red-50 rounded">
              <p className="text-red-600 font-semibold">Error loading shops:</p>
              <p className="text-red-600 text-sm">{shopsError.message}</p>
              <p className="text-red-600 text-xs mt-1">Code: {shopsError.code}</p>
              <p className="text-red-600 text-xs">Details: {shopsError.details}</p>
            </div>
          )}
          {shops && shops.length > 0 && (
            <div className="mt-2 p-2 bg-gray-50 rounded text-xs">
              <p className="font-semibold">First 5 shops:</p>
              <ul className="list-disc list-inside ml-2">
                {shops.slice(0, 5).map(shop => (
                  <li key={shop.id}>{shop.name} ({shop.id.substring(0, 8)}...)</li>
                ))}
              </ul>
            </div>
          )}
          <p className="mt-4">Items in database: <strong>{itemsCount ?? items?.length ?? 0}</strong></p>
          {itemsError && (
            <div className="mt-2 p-3 bg-red-50 rounded">
              <p className="text-red-600 font-semibold">Error loading items:</p>
              <p className="text-red-600 text-sm">{itemsError.message}</p>
            </div>
          )}
        </div>

        <div className="mt-6 p-4 bg-blue-50 rounded">
          <h3 className="font-semibold mb-2">To Fix Role:</h3>
          <p className="text-sm">
            If your role is not 'admin', run this SQL in Supabase SQL Editor:
          </p>
          <pre className="bg-white p-3 rounded mt-2 text-xs overflow-auto">
{`UPDATE user_roles 
SET role = 'admin' 
WHERE id = '${user.id}';`}
          </pre>
        </div>

        {shops && shops.length === 0 && (
          <div className="mt-6 p-4 bg-yellow-50 rounded">
            <h3 className="font-semibold mb-2">No Shops Found!</h3>
            <p className="text-sm">
              You need to run the seed SQL file to create shops. Run this in Supabase SQL Editor:
            </p>
            <pre className="bg-white p-3 rounded mt-2 text-xs overflow-auto">
{`-- Run the seed file: supabase/seeds/001_initial_shops_and_items.sql
-- Or manually create shops`}
            </pre>
          </div>
        )}
      </div>
    </div>
  )
}

