'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase'
import { Auth } from '@supabase/auth-ui-react'
import { ThemeSupa } from '@supabase/auth-ui-shared'
import { Package } from 'lucide-react'

export default function LoginPage() {
  const router = useRouter()
  const supabase = createClient()

  const customTheme = {
    ...ThemeSupa,
    default: {
      ...ThemeSupa.default,
      colors: {
        ...ThemeSupa.default.colors,
        brand: '#2563eb',
        brandAccent: '#1d4ed8',
        brandButtonText: 'white',
        defaultButtonBackground: '#2563eb',
        defaultButtonBackgroundHover: '#1d4ed8',
        defaultButtonBorder: 'transparent',
        defaultButtonText: 'white',
        dividerBackground: '#e5e7eb',
        inputBackground: 'white',
        inputBorder: '#e5e7eb',
        inputBorderHover: '#2563eb',
        inputBorderFocus: '#2563eb',
        inputText: '#111827',
        inputLabelText: '#374151',
        inputPlaceholder: '#9ca3af',
        messageText: '#6b7280',
        messageTextDanger: '#dc2626',
        anchorTextColor: '#2563eb',
        anchorTextHoverColor: '#1d4ed8',
      },
      space: {
        ...ThemeSupa.default.space,
        spaceSmall: '0.5rem',
        spaceMedium: '1rem',
        spaceLarge: '1.5rem',
        labelBottomMargin: '0.5rem',
        anchorBottomMargin: '0.5rem',
        emailInputSpacing: '0.75rem',
        socialAuthSpacing: '0.75rem',
        buttonPadding: '0.75rem 1.5rem',
        inputPadding: '0.75rem 1rem',
      },
      fontSizes: {
        ...ThemeSupa.default.fontSizes,
        baseBodySize: '0.875rem',
        baseInputSize: '0.875rem',
        baseLabelSize: '0.875rem',
        baseButtonSize: '0.875rem',
      },
      radii: {
        ...ThemeSupa.default.radii,
        borderRadiusButton: '0.75rem',
        buttonBorderRadius: '0.75rem',
        inputBorderRadius: '0.75rem',
        labelBorderRadius: '0.5rem',
        containerBorderRadius: '1rem',
      },
    },
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 px-4 py-12">
      <div className="w-full max-w-md animate-fade-in">
        {/* Logo/Header */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-primary-500 to-indigo-600 rounded-2xl shadow-glow mb-4">
            <Package className="text-white" size={32} />
          </div>
          <h1 className="text-3xl font-bold bg-gradient-to-r from-primary-600 to-indigo-600 bg-clip-text text-transparent mb-2">
            Stock Count
          </h1>
          <p className="text-gray-600 text-sm">Manage your inventory with ease</p>
        </div>

        {/* Auth Card */}
        <div className="bg-white/80 backdrop-blur-md rounded-2xl shadow-strong border border-white/20 p-8">
          <Auth
            supabaseClient={supabase as any}
            appearance={{ theme: customTheme }}
            providers={[]}
            onlyThirdPartyProviders={false}
            view="sign_in"
            redirectTo={`${typeof window !== 'undefined' ? window.location.origin : ''}/dashboard`}
          />
        </div>

        {/* Footer */}
        <p className="text-center text-xs text-gray-500 mt-6">
          Secure login powered by Supabase
        </p>
      </div>
    </div>
  )
}
