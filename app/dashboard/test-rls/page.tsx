'use client'

import { useEffect, useState } from 'react'
import { useAuth } from '../../auth-provider'
import { createClient } from '@/lib/supabase'
import Link from 'next/link'
import { ArrowLeft } from 'lucide-react'

export default function TestRLSPage() {
  const { user, role } = useAuth()
  const supabase = createClient()
  const [testResults, setTestResults] = useState<any[]>([])
  const [loading, setLoading] = useState(false)

  async function runTests() {
    setLoading(true)
    const results: any[] = []

    try {
      // Test 1: Check if user is authenticated
      results.push({
        test: 'User Authentication',
        status: user ? 'PASS' : 'FAIL',
        details: user ? `User ID: ${user.id}, Email: ${user.email}` : 'No user found',
      })

      // Test 2: Check role
      results.push({
        test: 'User Role',
        status: role ? 'PASS' : 'FAIL',
        details: role ? `Role: ${role}` : 'No role assigned',
      })

      // Test 3: Try to read shops
      const { data: shopsData, error: shopsError } = await supabase
        .from('shops')
        .select('*')
        .limit(1)

      results.push({
        test: 'Read Shops (SELECT)',
        status: shopsError ? 'FAIL' : 'PASS',
        details: shopsError
          ? `Error: ${shopsError.message} (Code: ${shopsError.code})`
          : `Success: Found ${shopsData?.length || 0} shops`,
      })

      // Test 4: Try to insert a shop
      const testShopName = `Test Shop ${Date.now()}`
      const { data: insertData, error: insertError } = await supabase
        .from('shops')
        .insert({ name: testShopName })
        .select()

      if (!insertError && insertData && insertData[0]) {
        // Clean up - delete the test shop
        await supabase.from('shops').delete().eq('id', insertData[0].id)
        results.push({
          test: 'Create Shop (INSERT)',
          status: 'PASS',
          details: `Successfully created and deleted test shop`,
        })
      } else {
        results.push({
          test: 'Create Shop (INSERT)',
          status: 'FAIL',
          details: insertError
            ? `Error: ${insertError.message} (Code: ${insertError.code}, Details: ${insertError.details || 'None'})`
            : 'Unknown error',
        })
      }

      // Test 5: Try to read items
      const { data: itemsData, error: itemsError } = await supabase
        .from('items')
        .select('*')
        .limit(1)

      results.push({
        test: 'Read Items (SELECT)',
        status: itemsError ? 'FAIL' : 'PASS',
        details: itemsError
          ? `Error: ${itemsError.message} (Code: ${itemsError.code})`
          : `Success: Found ${itemsData?.length || 0} items`,
      })

      // Test 6: Try to insert an item (if categories exist)
      const { data: categories } = await supabase.from('categories').select('*').limit(1)
      if (categories && categories.length > 0) {
        const testItemName = `Test Item ${Date.now()}`
        const { data: itemInsertData, error: itemInsertError } = await supabase
          .from('items')
          .insert({
            name: testItemName,
            pack_size: '1 per test',
            category_id: categories[0].id,
          })
          .select()

        if (!itemInsertError && itemInsertData && itemInsertData[0]) {
          // Clean up
          await supabase.from('items').delete().eq('id', itemInsertData[0].id)
          results.push({
            test: 'Create Item (INSERT)',
            status: 'PASS',
            details: `Successfully created and deleted test item`,
          })
        } else {
          results.push({
            test: 'Create Item (INSERT)',
            status: 'FAIL',
            details: itemInsertError
              ? `Error: ${itemInsertError.message} (Code: ${itemInsertError.code}, Details: ${itemInsertError.details || 'None'})`
              : 'Unknown error',
          })
        }
      } else {
        results.push({
          test: 'Create Item (INSERT)',
          status: 'SKIP',
          details: 'No categories found to test with',
        })
      }

      // Test 7: Check if is_manager() function exists (via a query)
      const { data: functionCheck, error: functionError } = await supabase.rpc('is_manager')

      results.push({
        test: 'is_manager() Function',
        status: functionError ? 'FAIL' : 'PASS',
        details: functionError
          ? `Error: ${functionError.message} (Code: ${functionError.code})`
          : `Function returned: ${functionCheck}`,
      })
    } catch (err: any) {
      results.push({
        test: 'Test Execution',
        status: 'ERROR',
        details: `Unexpected error: ${err.message}`,
      })
    }

    setTestResults(results)
    setLoading(false)
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="bg-white shadow-sm border-b">
        <div className="container-mobile py-4">
          <div className="flex items-center gap-4">
            <Link href="/dashboard" className="text-gray-600 hover:text-gray-900">
              <ArrowLeft size={24} />
            </Link>
            <h1 className="text-xl font-bold text-gray-900">RLS Test Page</h1>
          </div>
        </div>
      </div>

      <div className="container-mobile py-6">
        <div className="bg-white p-6 rounded-lg shadow-sm border mb-4">
          <p className="text-sm text-gray-600 mb-4">
            This page tests your RLS policies and manager permissions. Click the button below to run all tests.
          </p>
          <button
            onClick={runTests}
            disabled={loading}
            className="bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 disabled:opacity-50"
          >
            {loading ? 'Running Tests...' : 'Run Tests'}
          </button>
        </div>

        {testResults.length > 0 && (
          <div className="space-y-3">
            {testResults.map((result, index) => (
              <div
                key={index}
                className={`p-4 rounded-lg border ${
                  result.status === 'PASS'
                    ? 'bg-green-50 border-green-200'
                    : result.status === 'FAIL'
                    ? 'bg-red-50 border-red-200'
                    : result.status === 'SKIP'
                    ? 'bg-yellow-50 border-yellow-200'
                    : 'bg-gray-50 border-gray-200'
                }`}
              >
                <div className="flex items-start justify-between mb-2">
                  <h3 className="font-semibold text-gray-900">{result.test}</h3>
                  <span
                    className={`px-2 py-1 rounded text-xs font-semibold ${
                      result.status === 'PASS'
                        ? 'bg-green-200 text-green-800'
                        : result.status === 'FAIL'
                        ? 'bg-red-200 text-red-800'
                        : result.status === 'SKIP'
                        ? 'bg-yellow-200 text-yellow-800'
                        : 'bg-gray-200 text-gray-800'
                    }`}
                  >
                    {result.status}
                  </span>
                </div>
                <p className="text-sm text-gray-600">{result.details}</p>
              </div>
            ))}
          </div>
        )}

        {testResults.length > 0 && (
          <div className="mt-6 bg-blue-50 border border-blue-200 p-4 rounded-lg">
            <h3 className="font-semibold text-blue-900 mb-2">What to do if tests fail:</h3>
            <ul className="text-sm text-blue-800 space-y-1 list-disc list-inside">
              <li>If "Create Shop" or "Create Item" fails, make sure you ran migration 012_fix_all_rls_policies.sql</li>
              <li>If "is_manager() Function" fails, the function might not exist - check migration 012</li>
              <li>If role is null, set your role: INSERT INTO user_roles (user_id, role) VALUES ('YOUR_USER_ID', 'manager')</li>
              <li>Check the browser console (F12) for detailed error messages</li>
            </ul>
          </div>
        )}
      </div>
    </div>
  )
}

