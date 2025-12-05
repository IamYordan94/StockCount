'use client'

import { useState, useEffect } from 'react'
import QuantityInput from './QuantityInput'
import { ChevronDown, ChevronUp, Edit2, Save, X } from 'lucide-react'

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

interface StockTableProps {
  items: StockItem[]
  onUpdate: (itemId: string, packagingUnits: number, loosePieces: number) => Promise<void>
  onUpdateItem?: (itemId: string, name: string, packagingUnit: string) => Promise<void>
  loading?: boolean
}

export default function StockTable({ items, onUpdate, onUpdateItem, loading }: StockTableProps) {
  const [counts, setCounts] = useState<Record<string, { packaging_units: number; loose_pieces: number }>>({})
  const [updating, setUpdating] = useState<Set<string>>(new Set())
  const [editingItem, setEditingItem] = useState<Record<string, { name: string; packaging_unit: string }>>({})
  const [collapsedCategories, setCollapsedCategories] = useState<Set<string>>(new Set())

  // Initialize counts from items
  useEffect(() => {
    const initialCounts: Record<string, { packaging_units: number; loose_pieces: number }> = {}
    items.forEach(item => {
      initialCounts[item.id] = {
        packaging_units: item.packaging_units,
        loose_pieces: item.loose_pieces,
      }
    })
    setCounts(initialCounts)
  }, [items])

  const handleCountChange = async (itemId: string, field: 'packaging_units' | 'loose_pieces', value: number) => {
    const current = counts[itemId] || {
      packaging_units: items.find(i => i.id === itemId)?.packaging_units || 0,
      loose_pieces: items.find(i => i.id === itemId)?.loose_pieces || 0,
    }
    
    const newCounts = {
      ...counts,
      [itemId]: {
        ...current,
        [field]: value,
      },
    }
    setCounts(newCounts)

    // Auto-save after a short delay
    setUpdating(prev => new Set(prev).add(itemId))
    try {
      await onUpdate(itemId, newCounts[itemId].packaging_units, newCounts[itemId].loose_pieces)
    } catch (error) {
      console.error('Failed to update stock:', error)
      alert('Failed to update stock. Please try again.')
      // Revert on error
      setCounts(prev => ({
        ...prev,
        [itemId]: current,
      }))
    } finally {
      setUpdating(prev => {
        const next = new Set(prev)
        next.delete(itemId)
        return next
      })
    }
  }

  const handleEditItem = (itemId: string) => {
    const item = items.find(i => i.id === itemId)
    if (item) {
      setEditingItem({
        ...editingItem,
        [itemId]: {
          name: item.item_name,
          packaging_unit: item.packaging_unit_description || '',
        },
      })
    }
  }

  const handleSaveItem = async (itemId: string) => {
    const edited = editingItem[itemId]
    if (!edited || !onUpdateItem) return

    const item = items.find(i => i.id === itemId)
    if (!item) return

    try {
      await onUpdateItem(item.item_id, edited.name, edited.packaging_unit)
      setEditingItem(prev => {
        const next = { ...prev }
        delete next[itemId]
        return next
      })
      // Refresh page to show updated data
      window.location.reload()
    } catch (error) {
      console.error('Failed to update item:', error)
      alert('Failed to update item. Please try again.')
    }
  }

  const handleCancelItem = (itemId: string) => {
    setEditingItem(prev => {
      const next = { ...prev }
      delete next[itemId]
      return next
    })
  }

  const toggleCategory = (category: string) => {
    setCollapsedCategories(prev => {
      const next = new Set(prev)
      if (next.has(category)) {
        next.delete(category)
      } else {
        next.add(category)
      }
      return next
    })
  }

  // Group items by category
  const groupedItems = items.reduce((acc, item) => {
    const category = item.category || 'Uncategorized'
    if (!acc[category]) {
      acc[category] = []
    }
    acc[category].push(item)
    return acc
  }, {} as Record<string, StockItem[]>)

  return (
    <div className="space-y-1 md:space-y-4">
      {Object.entries(groupedItems).map(([category, categoryItems]) => {
        const isCollapsed = collapsedCategories.has(category)
        const currentCounts = counts[categoryItems[0]?.id] || {}
        
        return (
          <div key={category} className="bg-white shadow-sm rounded-md overflow-hidden">
            <button
              onClick={() => toggleCategory(category)}
              className="w-full bg-gray-50 px-2 py-1 md:px-4 md:py-3 border-b flex items-center justify-between hover:bg-gray-100 transition-colors"
            >
              <h3 className="text-[11px] md:text-lg font-semibold text-gray-900">{category}</h3>
              {isCollapsed ? (
                <ChevronDown className="h-3 w-3 md:h-5 md:w-5 text-gray-500" />
              ) : (
                <ChevronUp className="h-3 w-3 md:h-5 md:w-5 text-gray-500" />
              )}
            </button>
            
            {!isCollapsed && (
              <>
                {/* Desktop Table View */}
                <div className="hidden md:block overflow-x-auto">
                  <table className="min-w-full divide-y divide-gray-200">
                    <thead className="bg-gray-50">
                      <tr>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                          Item
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                          Packaging Unit
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                          Aantal
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                          Losse Stuks
                        </th>
                        {onUpdateItem && (
                          <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Actions
                          </th>
                        )}
                      </tr>
                    </thead>
                    <tbody className="bg-white divide-y divide-gray-200">
                      {categoryItems.map((item) => {
                        const itemCounts = counts[item.id] || {
                          packaging_units: item.packaging_units,
                          loose_pieces: item.loose_pieces,
                        }
                        const isUpdating = updating.has(item.id)
                        const isEditingItem = !!editingItem[item.id]
                        const editedItem = editingItem[item.id]

                        return (
                          <tr key={item.id}>
                            <td className="px-6 py-4 whitespace-nowrap">
                              {isEditingItem && editedItem ? (
                                <input
                                  type="text"
                                  value={editedItem.name}
                                  onChange={(e) => {
                                    setEditingItem({
                                      ...editingItem,
                                      [item.id]: { ...editedItem, name: e.target.value },
                                    })
                                  }}
                                  className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                                />
                              ) : (
                                <div className="text-sm font-medium text-gray-900">{item.item_name}</div>
                              )}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                              {isEditingItem && editedItem ? (
                                <input
                                  type="text"
                                  value={editedItem.packaging_unit}
                                  onChange={(e) => {
                                    setEditingItem({
                                      ...editingItem,
                                      [item.id]: { ...editedItem, packaging_unit: e.target.value },
                                    })
                                  }}
                                  className="w-full px-2 py-1 border border-gray-300 rounded text-sm"
                                />
                              ) : (
                                <div className="text-sm text-gray-500">
                                  {item.packaging_unit_description || '-'}
                                </div>
                              )}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                              <div className="flex items-center">
                                <div className="flex items-center border border-gray-300 rounded-md">
                                  <button
                                    type="button"
                                    onClick={() => handleCountChange(item.id, 'packaging_units', Math.max(0, itemCounts.packaging_units - 1))}
                                    disabled={itemCounts.packaging_units <= 0 || isUpdating}
                                    className="p-2 hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed min-h-[44px] min-w-[44px] flex items-center justify-center"
                                    aria-label="Decrease"
                                  >
                                    <span className="text-lg">−</span>
                                  </button>
                                  <input
                                    type="number"
                                    inputMode="numeric"
                                    value={itemCounts.packaging_units}
                                    onChange={(e) => {
                                      const value = parseInt(e.target.value, 10) || 0
                                      handleCountChange(item.id, 'packaging_units', value)
                                    }}
                                    min={0}
                                    className="w-20 px-2 py-2 text-center border-0 focus:ring-0 focus:outline-none"
                                  />
                                  <button
                                    type="button"
                                    onClick={() => handleCountChange(item.id, 'packaging_units', itemCounts.packaging_units + 1)}
                                    disabled={isUpdating}
                                    className="p-2 hover:bg-gray-100 min-h-[44px] min-w-[44px] flex items-center justify-center"
                                    aria-label="Increase"
                                  >
                                    <span className="text-lg">+</span>
                                  </button>
                                </div>
                                {isUpdating && (
                                  <span className="ml-2 text-xs text-gray-500">Saving...</span>
                                )}
                              </div>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                              <div className="flex items-center border border-gray-300 rounded-md">
                                <button
                                  type="button"
                                  onClick={() => handleCountChange(item.id, 'loose_pieces', Math.max(0, itemCounts.loose_pieces - 1))}
                                  disabled={itemCounts.loose_pieces <= 0 || isUpdating}
                                  className="p-2 hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed min-h-[44px] min-w-[44px] flex items-center justify-center"
                                  aria-label="Decrease"
                                >
                                  <span className="text-lg">−</span>
                                </button>
                                <input
                                  type="number"
                                  inputMode="numeric"
                                  value={itemCounts.loose_pieces}
                                  onChange={(e) => {
                                    const value = parseInt(e.target.value, 10) || 0
                                    handleCountChange(item.id, 'loose_pieces', value)
                                  }}
                                  min={0}
                                  className="w-20 px-2 py-2 text-center border-0 focus:ring-0 focus:outline-none"
                                />
                                <button
                                  type="button"
                                  onClick={() => handleCountChange(item.id, 'loose_pieces', itemCounts.loose_pieces + 1)}
                                  disabled={isUpdating}
                                  className="p-2 hover:bg-gray-100 min-h-[44px] min-w-[44px] flex items-center justify-center"
                                  aria-label="Increase"
                                >
                                  <span className="text-lg">+</span>
                                </button>
                              </div>
                            </td>
                            {onUpdateItem && (
                              <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                {isEditingItem ? (
                                  <div className="flex space-x-2">
                                    <button
                                      onClick={() => handleSaveItem(item.id)}
                                      className="text-green-600 hover:text-green-900"
                                      title="Save"
                                    >
                                      <Save className="h-4 w-4" />
                                    </button>
                                    <button
                                      onClick={() => handleCancelItem(item.id)}
                                      className="text-gray-600 hover:text-gray-900"
                                      title="Cancel"
                                    >
                                      <X className="h-4 w-4" />
                                    </button>
                                  </div>
                                ) : (
                                  <button
                                    onClick={() => handleEditItem(item.id)}
                                    className="text-indigo-600 hover:text-indigo-900"
                                    title="Edit item"
                                  >
                                    <Edit2 className="h-4 w-4" />
                                  </button>
                                )}
                              </td>
                            )}
                          </tr>
                        )
                      })}
                    </tbody>
                  </table>
                </div>

                {/* Mobile Card View */}
                <div className="md:hidden divide-y divide-gray-100">
                  {categoryItems.map((item) => {
                    const itemCounts = counts[item.id] || {
                      packaging_units: item.packaging_units,
                      loose_pieces: item.loose_pieces,
                    }
                    const isUpdating = updating.has(item.id)
                    const isEditingItem = !!editingItem[item.id]
                    const editedItem = editingItem[item.id]

                    return (
                      <div key={item.id} className="px-2 py-1.5">
                        <div className="mb-1.5">
                          {isEditingItem && editedItem ? (
                            <div className="space-y-1.5">
                              <input
                                type="text"
                                value={editedItem.name}
                                onChange={(e) => {
                                  setEditingItem({
                                    ...editingItem,
                                    [item.id]: { ...editedItem, name: e.target.value },
                                  })
                                }}
                                className="w-full px-1.5 py-1 text-xs border border-gray-300 rounded"
                                placeholder="Item name"
                              />
                              <input
                                type="text"
                                value={editedItem.packaging_unit}
                                onChange={(e) => {
                                  setEditingItem({
                                    ...editingItem,
                                    [item.id]: { ...editedItem, packaging_unit: e.target.value },
                                  })
                                }}
                                className="w-full px-1.5 py-1 text-xs border border-gray-300 rounded"
                                placeholder="Packaging unit"
                              />
                              <div className="flex space-x-1.5">
                                <button
                                  onClick={() => handleSaveItem(item.id)}
                                  className="flex-1 px-2 py-1 bg-green-600 text-white text-[10px] font-medium rounded hover:bg-green-700 min-h-[28px]"
                                >
                                  Save
                                </button>
                                <button
                                  onClick={() => handleCancelItem(item.id)}
                                  className="flex-1 px-2 py-1 bg-gray-200 text-gray-700 text-[10px] font-medium rounded hover:bg-gray-300 min-h-[28px]"
                                >
                                  Cancel
                                </button>
                              </div>
                            </div>
                          ) : (
                            <>
                              <h4 className="text-[11px] font-medium text-gray-900 leading-tight">{item.item_name}</h4>
                              {item.packaging_unit_description && (
                                <p className="text-[9px] text-gray-500 mt-0.5 leading-tight">{item.packaging_unit_description}</p>
                              )}
                              {onUpdateItem && (
                                <button
                                  onClick={() => handleEditItem(item.id)}
                                  className="mt-0.5 text-[9px] text-indigo-600 hover:text-indigo-900"
                                >
                                  Edit
                                </button>
                              )}
                            </>
                          )}
                        </div>
                        
                        <div className="space-y-1.5">
                          <div>
                            <label className="block text-[9px] font-medium text-gray-700 mb-0.5">Aantal</label>
                            <div className="flex items-center border border-gray-300 rounded">
                              <button
                                type="button"
                                onClick={() => handleCountChange(item.id, 'packaging_units', Math.max(0, itemCounts.packaging_units - 1))}
                                disabled={itemCounts.packaging_units <= 0 || isUpdating}
                                className="p-1 hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed min-h-[28px] min-w-[28px] flex items-center justify-center"
                                aria-label="Decrease"
                              >
                                <span className="text-sm">−</span>
                              </button>
                              <input
                                type="number"
                                inputMode="numeric"
                                value={itemCounts.packaging_units}
                                onChange={(e) => {
                                  const value = parseInt(e.target.value, 10) || 0
                                  handleCountChange(item.id, 'packaging_units', value)
                                }}
                                min={0}
                                className="flex-1 px-1 py-0.5 text-xs text-center border-0 focus:ring-0 focus:outline-none"
                              />
                              <button
                                type="button"
                                onClick={() => handleCountChange(item.id, 'packaging_units', itemCounts.packaging_units + 1)}
                                disabled={isUpdating}
                                className="p-1 hover:bg-gray-100 min-h-[28px] min-w-[28px] flex items-center justify-center"
                                aria-label="Increase"
                              >
                                <span className="text-sm">+</span>
                              </button>
                            </div>
                            {isUpdating && (
                              <span className="mt-0.5 text-[9px] text-gray-500 block">Saving...</span>
                            )}
                          </div>
                          
                          <div>
                            <label className="block text-[9px] font-medium text-gray-700 mb-0.5">Losse Stuks</label>
                            <div className="flex items-center border border-gray-300 rounded">
                              <button
                                type="button"
                                onClick={() => handleCountChange(item.id, 'loose_pieces', Math.max(0, itemCounts.loose_pieces - 1))}
                                disabled={itemCounts.loose_pieces <= 0 || isUpdating}
                                className="p-1 hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed min-h-[28px] min-w-[28px] flex items-center justify-center"
                                aria-label="Decrease"
                              >
                                <span className="text-sm">−</span>
                              </button>
                              <input
                                type="number"
                                inputMode="numeric"
                                value={itemCounts.loose_pieces}
                                onChange={(e) => {
                                  const value = parseInt(e.target.value, 10) || 0
                                  handleCountChange(item.id, 'loose_pieces', value)
                                }}
                                min={0}
                                className="flex-1 px-1 py-0.5 text-xs text-center border-0 focus:ring-0 focus:outline-none"
                              />
                              <button
                                type="button"
                                onClick={() => handleCountChange(item.id, 'loose_pieces', itemCounts.loose_pieces + 1)}
                                disabled={isUpdating}
                                className="p-1 hover:bg-gray-100 min-h-[28px] min-w-[28px] flex items-center justify-center"
                                aria-label="Increase"
                              >
                                <span className="text-sm">+</span>
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    )
                  })}
                </div>
              </>
            )}
          </div>
        )
      })}
    </div>
  )
}
