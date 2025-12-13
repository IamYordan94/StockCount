'use client'

import { HelpCircle } from 'lucide-react'

interface HelpButtonProps {
  onClick: () => void
  className?: string
}

export default function HelpButton({ onClick, className = '' }: HelpButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`p-2 text-gray-600 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-all ${className}`}
      aria-label="Open help manual"
      title="Help"
    >
      <HelpCircle size={20} />
    </button>
  )
}

