'use client'

import StockTable from './StockTable'

interface StockItem {
  id: string
  item_id: string
  item_name: string
  category: string
  packaging_unit_description: string | null
  packaging_units: number
  loose_pieces: number
  last_counted_at: string | null
  last_counted_by: string | null
}

interface StockTableClientProps {
  items: StockItem[]
}

export default function StockTableClient({ items }: StockTableClientProps) {
  const handleUpdate = async (
    stockId: string,
    packagingUnits: number,
    loosePieces: number
  ) => {
    const response = await fetch('/api/stock', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        stockId,
        packagingUnits,
        loosePieces,
      }),
    })

    if (!response.ok) {
      const error = await response.json()
      throw new Error(error.error || 'Failed to update stock')
    }

    return response.json()
  }

  return <StockTable items={items} onUpdate={handleUpdate} />
}

