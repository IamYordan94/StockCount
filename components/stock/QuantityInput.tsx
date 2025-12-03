'use client'

import { Minus, Plus } from 'lucide-react'

interface QuantityInputProps {
  label: string
  value: number
  onChange: (value: number) => void
  min?: number
}

export default function QuantityInput({ label, value, onChange, min = 0 }: QuantityInputProps) {
  const handleIncrement = () => {
    onChange(value + 1)
  }

  const handleDecrement = () => {
    if (value > min) {
      onChange(value - 1)
    }
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newValue = parseInt(e.target.value, 10) || 0
    if (newValue >= min) {
      onChange(newValue)
    }
  }

  return (
    <div className="flex items-center space-x-2">
      <label className="text-sm font-medium text-gray-700 w-24">{label}</label>
      <div className="flex items-center border border-gray-300 rounded-md">
        <button
          type="button"
          onClick={handleDecrement}
          disabled={value <= min}
          className="p-1 hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <Minus className="h-4 w-4" />
        </button>
        <input
          type="number"
          value={value}
          onChange={handleChange}
          min={min}
          className="w-16 px-2 py-1 text-center border-0 focus:ring-0 focus:outline-none"
        />
        <button
          type="button"
          onClick={handleIncrement}
          className="p-1 hover:bg-gray-100"
        >
          <Plus className="h-4 w-4" />
        </button>
      </div>
    </div>
  )
}

