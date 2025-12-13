'use client'

import { useState, useMemo } from 'react'
import { X, Search, BookOpen, Package, Store, Users, FileSpreadsheet, ClipboardList, Home, ChevronRight } from 'lucide-react'
import Modal from './Modal'

interface ManualStep {
  number: number
  title: string
  description: string
}

interface ManualSection {
  id: string
  title: string
  icon: React.ReactNode
  steps: ManualStep[]
}

interface UserManualProps {
  isOpen: boolean
  onClose: () => void
  initialSection?: string
}

export default function UserManual({ isOpen, onClose, initialSection }: UserManualProps) {
  const [activeSection, setActiveSection] = useState<string>(initialSection || 'getting-started')
  const [searchQuery, setSearchQuery] = useState('')

  const sections: ManualSection[] = [
    {
      id: 'getting-started',
      title: 'Getting Started',
      icon: <Home size={20} />,
      steps: [
        {
          number: 1,
          title: 'Logging In',
          description: 'Access the system using your manager account credentials. Your account must be created by an administrator.',
        },
        {
          number: 2,
          title: 'Dashboard Overview',
          description: 'After logging in, you\'ll see the main dashboard with cards for Sessions, Products, Users, and Shops. Click on any card to navigate to that section.',
        },
        {
          number: 3,
          title: 'Navigation',
          description: 'Use the back arrow (←) in the top-left corner of any page to return to the dashboard. The help button (?) is available on every page for quick access to this manual.',
        },
      ],
    },
    {
      id: 'products',
      title: 'Products Management',
      icon: <Package size={20} />,
      steps: [
        {
          number: 1,
          title: 'Creating a Product',
          description: 'Click the "Add Product" button. Enter the product name, pack size (e.g., "12 per pack" or "500g"), and select a category. Click "Create" to save.',
        },
        {
          number: 2,
          title: 'Editing a Product',
          description: 'Click the edit icon (pencil) next to any product. Modify the name, pack size, or category, then click "Update".',
        },
        {
          number: 3,
          title: 'Deleting a Product',
          description: 'Click the delete icon (trash) next to a product. Confirm the deletion in the dialog that appears. This action cannot be undone.',
        },
        {
          number: 4,
          title: 'See Products per Shop',
          description: 'Click "See Products per Shop" button. Select a shop from the dropdown. You\'ll see all products assigned to that shop. You can add or remove products using the buttons next to each item.',
        },
        {
          number: 5,
          title: 'Searching and Filtering',
          description: 'Use the search bar to find products by name. Use the category filter dropdown to show only products in a specific category.',
        },
      ],
    },
    {
      id: 'shops',
      title: 'Shops Management',
      icon: <Store size={20} />,
      steps: [
        {
          number: 1,
          title: 'Creating a Shop',
          description: 'Click the "Add Shop" button. Enter the shop name and click "Create Shop".',
        },
        {
          number: 2,
          title: 'Editing a Shop Name',
          description: 'Click the edit icon (pencil) next to a shop. Change the name and click "Update Shop".',
        },
        {
          number: 3,
          title: 'Deleting a Shop',
          description: 'Click the delete icon (trash) next to a shop. Confirm deletion. This will also remove all item assignments and stock counts for this shop.',
        },
        {
          number: 4,
          title: 'Managing Shop Products',
          description: 'To assign products to a shop, go to the Products page and use the "See Products per Shop" feature. This is where you manage which products are available in each shop.',
        },
      ],
    },
    {
      id: 'users',
      title: 'Users Management',
      icon: <Users size={20} />,
      steps: [
        {
          number: 1,
          title: 'Creating a User',
          description: 'Click "Add User". Enter the user\'s name (required) and email (optional - can be auto-generated). Set a password and select their role (Manager or Employee). Click "Create User".',
        },
        {
          number: 2,
          title: 'Assigning Shops to Users',
          description: 'When creating or editing a user, select one or more shops from the "Assign Shops" section. Employees can only count stock for shops they are assigned to.',
        },
        {
          number: 3,
          title: 'Editing a User',
          description: 'Click the edit icon next to a user. You can change their name, email, password, role, and shop assignments. Click "Update User" to save.',
        },
        {
          number: 4,
          title: 'Deleting a User',
          description: 'Click the delete icon next to a user. Confirm deletion. This will remove the user and all their assignments.',
        },
        {
          number: 5,
          title: 'User Roles',
          description: 'Managers have full access to all features. Employees can only count stock for their assigned shops and sessions.',
        },
      ],
    },
    {
      id: 'sessions',
      title: 'Sessions Management',
      icon: <FileSpreadsheet size={20} />,
      steps: [
        {
          number: 1,
          title: 'Creating a Counting Session',
          description: 'Click "Create Session". Enter a session name (e.g., "December 2024 Stock Count"). Optionally select specific employees to assign to this session. Click "Create Session".',
        },
        {
          number: 2,
          title: 'Assigning Users to Sessions',
          description: 'When creating a session, you can select specific employees from the "Assign Users" section. Only assigned employees will see this session when they log in. If no users are selected, all employees can access it.',
        },
        {
          number: 3,
          title: 'Viewing Active Sessions',
          description: 'All active sessions are shown in the "Active Sessions" tab. You can see which users are assigned to each session.',
        },
        {
          number: 4,
          title: 'Completing a Session',
          description: 'When counting is finished, click "Complete" on a session. This moves it to the History tab and prevents further counting.',
        },
        {
          number: 5,
          title: 'Downloading Excel Reports',
          description: 'Click the download icon (Excel) on any active or completed session. The Excel file will contain all counted items organized by shop and category.',
        },
        {
          number: 6,
          title: 'Viewing Session History',
          description: 'Click the "History" tab to see all completed sessions. You can download reports again or delete old sessions from here.',
        },
        {
          number: 7,
          title: 'Deleting a Session',
          description: 'Click the delete icon on a session. Confirm deletion. This permanently removes the session and all its count data.',
        },
      ],
    },
    {
      id: 'counting',
      title: 'Running Counting Sessions',
      icon: <ClipboardList size={20} />,
      steps: [
        {
          number: 1,
          title: 'Employee Access',
          description: 'Employees log in and see only sessions they are assigned to (or all active sessions if not specifically assigned). They select a session and then a shop.',
        },
        {
          number: 2,
          title: 'Counting Stock',
          description: 'Employees enter quantities for each item in the selected shop. The interface shows items organized by category. Enter the count and it saves automatically.',
        },
        {
          number: 3,
          title: 'Manager Monitoring',
          description: 'Managers can view active sessions and see progress. They can download Excel reports at any time, even before completing the session.',
        },
        {
          number: 4,
          title: 'Completing the Count',
          description: 'Once all shops are counted, managers complete the session. This finalizes the data and moves it to history. Employees can no longer modify counts after completion.',
        },
      ],
    },
  ]

  const filteredSections = useMemo(() => {
    if (!searchQuery.trim()) return sections

    const query = searchQuery.toLowerCase()
    return sections
      .map((section) => ({
        ...section,
        steps: section.steps.filter(
          (step) =>
            step.title.toLowerCase().includes(query) ||
            step.description.toLowerCase().includes(query) ||
            section.title.toLowerCase().includes(query)
        ),
      }))
      .filter((section) => section.steps.length > 0)
  }, [searchQuery, sections])

  const currentSection = filteredSections.find((s) => s.id === activeSection) || filteredSections[0]

  return (
    <Modal isOpen={isOpen} onClose={onClose} title="User Manual" size="lg">
      <div className="flex flex-col" style={{ maxHeight: '70vh', minHeight: '500px' }}>
        {/* Search Bar */}
        <div className="mb-4">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" size={18} />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search manual..."
              className="w-full pl-10 pr-4 py-2 border-2 border-gray-200 rounded-lg bg-white text-gray-900 placeholder-gray-400 focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-all"
            />
          </div>
        </div>

        <div className="flex flex-1 gap-4 overflow-hidden min-h-0">
          {/* Sidebar - Table of Contents */}
          <div className="w-64 flex-shrink-0 border-r border-gray-200 pr-4 overflow-y-auto">
            <div className="space-y-1">
              {filteredSections.map((section) => (
                <button
                  key={section.id}
                  onClick={() => setActiveSection(section.id)}
                  className={`w-full text-left px-4 py-3 rounded-lg transition-all flex items-center gap-3 ${
                    activeSection === section.id
                      ? 'bg-gradient-to-r from-primary-50 to-indigo-50 text-primary-700 font-semibold border border-primary-200'
                      : 'text-gray-700 hover:bg-gray-50'
                  }`}
                >
                  <div className={`${activeSection === section.id ? 'text-primary-600' : 'text-gray-500'}`}>
                    {section.icon}
                  </div>
                  <span className="flex-1 text-sm">{section.title}</span>
                  {activeSection === section.id && <ChevronRight size={16} className="text-primary-600" />}
                </button>
              ))}
            </div>
          </div>

          {/* Main Content */}
          <div className="flex-1 overflow-y-auto">
            {currentSection ? (
              <div>
                <div className="flex items-center gap-3 mb-6 pb-4 border-b border-gray-200">
                  <div className="p-2 bg-gradient-to-br from-primary-500 to-indigo-600 rounded-lg text-white">
                    {currentSection.icon}
                  </div>
                  <h3 className="text-2xl font-bold text-gray-900">{currentSection.title}</h3>
                </div>

                <div className="space-y-6">
                  {currentSection.steps.map((step) => (
                    <div key={step.number} className="bg-gray-50 rounded-xl p-5 border border-gray-200">
                      <div className="flex items-start gap-4">
                        <div className="flex-shrink-0 w-8 h-8 bg-gradient-to-br from-primary-500 to-indigo-600 rounded-full flex items-center justify-center text-white font-bold text-sm">
                          {step.number}
                        </div>
                        <div className="flex-1">
                          <h4 className="font-semibold text-gray-900 mb-2">{step.title}</h4>
                          <p className="text-sm text-gray-700 leading-relaxed">{step.description}</p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>

                {currentSection.steps.length === 0 && (
                  <div className="text-center py-12 text-gray-500">
                    <BookOpen size={48} className="mx-auto mb-4 text-gray-300" />
                    <p>No steps found matching your search.</p>
                  </div>
                )}
              </div>
            ) : (
              <div className="text-center py-12 text-gray-500">
                <BookOpen size={48} className="mx-auto mb-4 text-gray-300" />
                <p>No content found.</p>
              </div>
            )}
          </div>
        </div>
      </div>
    </Modal>
  )
}

