import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function PUT(request: NextRequest) {
  try {
    const supabase = await createClient()
    const { data: { user } } = await supabase.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }

    const body = await request.json()
    const { stockId, packagingUnits, loosePieces } = body

    if (!stockId || packagingUnits === undefined || loosePieces === undefined) {
      return NextResponse.json(
        { error: 'Missing required fields' },
        { status: 400 }
      )
    }

    // Get current stock values for history
    const { data: currentStock, error: fetchError } = await supabase
      .from('shop_stock')
      .select('*')
      .eq('id', stockId)
      .single()

    if (fetchError || !currentStock) {
      return NextResponse.json(
        { error: 'Stock record not found' },
        { status: 404 }
      )
    }

    // Update stock
    const { data: updatedStock, error: updateError } = await supabase
      .from('shop_stock')
      .update({
        packaging_units: packagingUnits,
        loose_pieces: loosePieces,
        last_counted_by: user.id,
        last_counted_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      })
      .eq('id', stockId)
      .select()
      .single()

    if (updateError) {
      return NextResponse.json(
        { error: 'Failed to update stock', details: updateError.message },
        { status: 500 }
      )
    }

    // Create history record
    await supabase.from('stock_history').insert({
      shop_id: currentStock.shop_id,
      item_id: currentStock.item_id,
      user_id: user.id,
      old_packaging_units: currentStock.packaging_units,
      new_packaging_units: packagingUnits,
      old_loose_pieces: currentStock.loose_pieces,
      new_loose_pieces: loosePieces,
      change_type: 'count',
    })

    return NextResponse.json({
      success: true,
      data: updatedStock,
    })
  } catch (error) {
    console.error('Stock update error:', error)
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
