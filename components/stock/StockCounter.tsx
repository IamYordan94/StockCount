'use client'

import { useState } from 'react'
import QuantityInput from './QuantityInput'

interface StockCounterProps {
  itemName: string
  packagingUnitDescription: string | null
  initialPackagingUnits: number
  initialLoosePieces: number
  onSave: (packagingUnits: number, loosePieces: number) => Promise<void>
}

export default function StockCounter({
  itemName,
  packagingUnitDescription,
  initialPackagingUnits,
  initialLoosePieces,
  onSave,
}: StockCounterProps) {
  const [packagingUnits, setPackagingUnits] = useState(initialPackagingUnits)
  const [loosePieces, setLoosePieces] = useState(initialLoosePieces)
  const [saving, setSaving] = useState(false)

  const handleSave = async () => {
    setSaving(true)
    try {
      await onSave(packagingUnits, loosePieces)
    } catch (error) {
      console.error('Failed to save:', error)
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="bg-white p-4 rounded-lg shadow">
      <h3 className="text-lg font-medium text-gray-900 mb-4">{itemName}</h3>
      {packagingUnitDescription && (
        <p className="text-sm text-gray-500 mb-4">{packagingUnitDescription}</p>
      )}
      <div className="space-y-4">
        <QuantityInput
          label="Aantal"
          value={packagingUnits}
          onChange={setPackagingUnits}
        />
        <QuantityInput
          label="Losse Stuks"
          value={loosePieces}
          onChange={setLoosePieces}
        />
        <button
          onClick={handleSave}
          disabled={saving}
          className="w-full px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 disabled:opacity-50"
        >
          {saving ? 'Saving...' : 'Save Count'}
        </button>
      </div>
    </div>
  )
}

