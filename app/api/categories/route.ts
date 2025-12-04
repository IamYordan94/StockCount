import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function GET(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    // Get all unique categories from items
    const { data: items, error } = await supabase
      .from('items')
      .select('category')
      .not('category', 'is', null)

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    // Extract unique categories
    const categories = [...new Set((items || []).map(item => item.category).filter(Boolean))]
      .sort()

    // Add common categories if they don't exist
    const commonCategories = ['IJSJES', 'DRANK', 'ETEN', 'Cheese', 'Stromma goods', 'Uncategorized']
    commonCategories.forEach(cat => {
      if (!categories.includes(cat)) {
        categories.push(cat)
      }
    })

    return NextResponse.json({ categories: categories.sort() })
  } catch (error) {
    console.error('Error fetching categories:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

