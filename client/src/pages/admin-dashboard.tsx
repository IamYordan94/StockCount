import { useState } from "react";
import { useAuth } from "@/hooks/use-auth";
import { useQuery, useMutation } from "@tanstack/react-query";
import { queryClient } from "@/lib/queryClient";
import { Link } from "wouter";
import { 
  Box, Users, Store, TrendingUp, Download, Plus, Edit, Lock,
  ChevronRight, FileText, BarChart3, Settings, LogOut, X, DollarSign
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from "@/components/ui/accordion";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Checkbox } from "@/components/ui/checkbox";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { insertUserSchema, insertItemSchema } from "@shared/schema";
import { z } from "zod";
import { useToast } from "@/hooks/use-toast";

interface User {
  id: string;
  name: string;
  username: string;
  role: string;
  approved: boolean;
  lastLoginAt: string | null;
}

interface Session {
  id: string;
  name: string;
  status: string;
  createdAt: string;
  closedAt: string | null;
  autoCloseAt: string | null;
}

interface Shop {
  id: number;
  name: string;
  active: boolean;
}

interface Item {
  id: number;
  defaultName: string;
  category: 'FOOD' | 'DRINK' | 'ICECREAM' | 'STROMMA';
  unitsPerBox: number;
}

interface ShopItem extends Item {
  active: boolean;
}

interface ProgressData {
  shopId: number;
  shopName: string;
  progress: number;
  status: string;
  userName: string | null;
  userId: string | null;
  totalItems: number;
  countedItems: number;
  lastUpdated: string | null;
  submittedAt: string | null;
}

const createUserFormSchema = insertUserSchema.extend({
  shopIds: z.array(z.number()).optional(),
});

const itemFormSchema = insertItemSchema.pick({
  defaultName: true,
  category: true,
  unitsPerBox: true,
}).extend({
  id: z.number().optional(),
});

const shopFormSchema = z.object({
  name: z.string().min(1, "Shop name is required"),
  active: z.boolean(),
});

type CreateUserForm = z.infer<typeof createUserFormSchema>;
type ItemForm = z.infer<typeof itemFormSchema>;
type ShopForm = z.infer<typeof shopFormSchema>;

// Category color mapping
const categoryColors = {
  FOOD: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200 border-green-300',
  DRINK: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200 border-blue-300',
  ICECREAM: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200 border-purple-300',
  STROMMA: 'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-200 border-orange-300',
};

// Helper function to group items by category
function groupItemsByCategory<T extends { category: string }>(items: T[]) {
  const grouped: Record<string, T[]> = {
    FOOD: [],
    DRINK: [],
    ICECREAM: [],
    STROMMA: [],
  };
  
  items.forEach(item => {
    if (grouped[item.category]) {
      grouped[item.category].push(item);
    }
  });
  
  return grouped;
}

export default function AdminDashboard() {
  const { user, logoutMutation } = useAuth();
  const { toast } = useToast();
  const [activeTab, setActiveTab] = useState("users");
  const [isCreateUserOpen, setIsCreateUserOpen] = useState(false);
  const [isEditUserOpen, setIsEditUserOpen] = useState(false);
  const [isCreateSessionOpen, setIsCreateSessionOpen] = useState(false);
  const [isShopConfigOpen, setIsShopConfigOpen] = useState(false);
  const [isShopItemsOpen, setIsShopItemsOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Item | null>(null);
  const [editingUser, setEditingUser] = useState<User | null>(null);
  const [editingShop, setEditingShop] = useState<Shop | null>(null);
  const [selectedShopForItems, setSelectedShopForItems] = useState<Shop | null>(null);

  if (!user || (user.role !== 'OWNER' && user.role !== 'SUPERVISOR')) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-4">Access Denied</h2>
          <p className="text-muted-foreground mb-4">You don't have permission to access this page.</p>
          <Link href="/" className="text-primary hover:underline">
            Go to Home
          </Link>
        </div>
      </div>
    );
  }

  const { data: users = [] } = useQuery<User[]>({
    queryKey: ['/api/admin/users'],
  });

  const { data: shops = [] } = useQuery<Shop[]>({
    queryKey: ['/api/shops'],
  });

  const { data: sessions = [] } = useQuery<Session[]>({
    queryKey: ['/api/sessions'],
  });

  const { data: activeSession } = useQuery<Session>({
    queryKey: ['/api/sessions/active'],
  });

  const { data: liveProgress = [] } = useQuery<ProgressData[]>({
    queryKey: ['/api/progress/live'],
    refetchInterval: 5000,
  });

  const { data: items = [] } = useQuery<Item[]>({
    queryKey: ['/api/items'],
  });

  // Shop items queries
  const { data: shopItems = [] } = useQuery<ShopItem[]>({
    queryKey: [`/api/shops/${selectedShopForItems?.id}/items`],
    enabled: isShopItemsOpen && !!selectedShopForItems,
  });

  const { data: availableItems = [] } = useQuery<Item[]>({
    queryKey: [`/api/shops/${selectedShopForItems?.id}/available-items`],
    enabled: isShopItemsOpen && !!selectedShopForItems,
  });

  // Create user form
  const createUserForm = useForm<CreateUserForm>({
    resolver: zodResolver(createUserFormSchema),
    defaultValues: {
      name: "",
      username: "",
      password: "",
      role: "EMPLOYEE",
      approved: true,
      mustResetPassword: false,
      shopIds: [],
    },
  });

  // Edit user form
  const editUserForm = useForm<CreateUserForm>({
    resolver: zodResolver(createUserFormSchema),
    defaultValues: {
      name: "",
      username: "",
      password: "",
      role: "EMPLOYEE",
      approved: true,
      mustResetPassword: false,
      shopIds: [],
    },
  });

  // Create user mutation
  const createUserMutation = useMutation({
    mutationFn: async (data: CreateUserForm) => {
      const response = await fetch('/api/admin/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to create user');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/admin/users'] });
      setIsCreateUserOpen(false);
      createUserForm.reset();
      toast({
        title: "User created",
        description: "User has been created successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to create user",
        variant: "destructive",
      });
    },
  });

  // Update user mutation
  const updateUserMutation = useMutation({
    mutationFn: async (data: CreateUserForm & { id: string }) => {
      const response = await fetch(`/api/admin/users/${data.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to update user');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/admin/users'] });
      setIsEditUserOpen(false);
      setEditingUser(null);
      editUserForm.reset();
      toast({
        title: "User updated",
        description: "User has been updated successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to update user",
        variant: "destructive",
      });
    },
  });

  // Delete user mutation
  const deleteUserMutation = useMutation({
    mutationFn: async (userId: string) => {
      const response = await fetch(`/api/admin/users/${userId}`, {
        method: 'DELETE',
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to delete user');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/admin/users'] });
      toast({
        title: "User deleted",
        description: "User has been deleted successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to delete user",
        variant: "destructive",
      });
    },
  });

  // Bulk delete users mutation
  const bulkDeleteUsersMutation = useMutation({
    mutationFn: async (userIds: string[]) => {
      const response = await fetch('/api/admin/users/bulk-delete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userIds }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to delete users');
      }
      
      return response.json();
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: ['/api/admin/users'] });
      toast({
        title: "Users deleted",
        description: `${data.deletedCount} users deleted successfully`,
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to delete users",
        variant: "destructive",
      });
    },
  });

  // Create session form
  const [sessionName, setSessionName] = useState("");
  
  // Create session mutation
  const createSessionMutation = useMutation({
    mutationFn: async (name: string) => {
      const response = await fetch('/api/sessions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, status: 'OPEN' }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to create session');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/sessions'] });
      queryClient.invalidateQueries({ queryKey: ['/api/sessions/active'] });
      setIsCreateSessionOpen(false);
      setSessionName("");
      toast({
        title: "Session created",
        description: "New session has been created successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to create session",
        variant: "destructive",
      });
    },
  });

  // Close session mutation
  const closeSessionMutation = useMutation({
    mutationFn: async (sessionId: string) => {
      const response = await fetch(`/api/sessions/${sessionId}/close`, {
        method: 'PATCH',
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to close session');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/sessions'] });
      queryClient.invalidateQueries({ queryKey: ['/api/sessions/active'] });
      queryClient.invalidateQueries({ queryKey: ['/api/progress/live'] });
      toast({
        title: "Session closed",
        description: "Session has been closed successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to close session",
        variant: "destructive",
      });
    },
  });

  // Reopen counts mutation
  const reopenCountsMutation = useMutation({
    mutationFn: async (sessionId: string) => {
      const response = await fetch(`/api/sessions/${sessionId}/reopen-counts`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reason: 'Reopened by admin' }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to reopen counts');
      }
      
      return response.json();
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: ['/api/sessions'] });
      queryClient.invalidateQueries({ queryKey: ['/api/progress/live'] });
      toast({
        title: "Counts reopened",
        description: `${data.reopenedCount} count(s) reopened successfully`,
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to reopen counts",
        variant: "destructive",
      });
    },
  });

  const onCreateUser = (data: CreateUserForm) => {
    createUserMutation.mutate(data);
  };

  const onEditUser = (data: CreateUserForm) => {
    if (editingUser) {
      updateUserMutation.mutate({ ...data, id: editingUser.id });
    }
  };

  const handleEditUser = async (user: User) => {
    setEditingUser(user);
    setIsEditUserOpen(true);
    
    try {
      // Fetch user's existing shop assignments
      const response = await fetch(`/api/admin/users/${user.id}/shops`, {
        credentials: 'include',
      });
      
      const shopData = await response.json();
      const userShopIds = shopData.shopIds || [];
      
      editUserForm.reset({
        name: user.name,
        username: user.username,
        password: "", // Don't show existing password
        role: user.role as "OWNER" | "SUPERVISOR" | "EMPLOYEE",
        approved: user.approved,
        mustResetPassword: false,
        shopIds: userShopIds,
      });
    } catch (error) {
      console.error('Failed to fetch user shop assignments:', error);
      // Still open the dialog but with empty shop assignments
      editUserForm.reset({
        name: user.name,
        username: user.username,
        password: "", // Don't show existing password
        role: user.role as "OWNER" | "SUPERVISOR" | "EMPLOYEE",
        approved: user.approved,
        mustResetPassword: false,
        shopIds: [],
      });
      toast({
        title: "Warning",
        description: "Could not load shop assignments",
        variant: "destructive",
      });
    }
  };

  const handleDeleteUser = (userId: string, userName: string) => {
    if (confirm(`Are you sure you want to delete user "${userName}"? This action cannot be undone.`)) {
      deleteUserMutation.mutate(userId);
    }
  };

  const handleBulkDeleteUsers = () => {
    const nonAdminUsers = users.filter(u => u.role !== 'OWNER' && u.username !== 'admin');
    
    if (nonAdminUsers.length === 0) {
      toast({
        title: "No users to delete",
        description: "Only admin users remain.",
        variant: "destructive",
      });
      return;
    }
    
    if (confirm(`Are you sure you want to delete all ${nonAdminUsers.length} non-admin users? This action cannot be undone.`)) {
      const userIds = nonAdminUsers.map(u => u.id);
      bulkDeleteUsersMutation.mutate(userIds);
    }
  };

  const handleCreateSession = () => {
    if (sessionName.trim()) {
      createSessionMutation.mutate(sessionName.trim());
    }
  };

  const handleConfigureShop = (shop: Shop) => {
    setEditingShop(shop);
    setIsShopConfigOpen(true);
    shopForm.reset({
      name: shop.name,
      active: shop.active,
    });
  };

  const onUpdateShop = (data: ShopForm) => {
    if (editingShop) {
      updateShopMutation.mutate({ ...data, id: editingShop.id });
    }
  };

  const exportMutation = useMutation({
    mutationFn: async (shopId: number) => {
      const response = await fetch(`/api/exports/shops/${shopId}?sessionId=${activeSession?.id}`, {
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Export failed');
      }

      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.style.display = 'none';
      a.href = url;
      a.download = `Shop_${shopId}_Inventory.xlsx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    },
    onSuccess: () => {
      toast({
        title: "Export successful",
        description: "Shop inventory exported successfully",
      });
    },
    onError: () => {
      toast({
        title: "Export failed",
        description: "Failed to export shop inventory",
        variant: "destructive",
      });
    },
  });

  const exportAllMutation = useMutation({
    mutationFn: async () => {
      toast({
        title: "Feature coming soon",
        description: "Complete workbook export will be available soon",
      });
      throw new Error('Not implemented');
    },
    onError: () => {},
  });

  const exportSummaryMutation = useMutation({
    mutationFn: async () => {
      toast({
        title: "Feature coming soon",
        description: "Summary export will be available soon",
      });
      throw new Error('Not implemented');
    },
  });

  const handleLogout = () => {
    logoutMutation.mutate();
  };

  // Shop configuration form
  const shopForm = useForm<ShopForm>({
    resolver: zodResolver(shopFormSchema),
    defaultValues: {
      name: "",
      active: true,
    },
  });

  // Item management form
  const itemForm = useForm<ItemForm>({
    resolver: zodResolver(itemFormSchema),
    defaultValues: {
      defaultName: "",
      category: "FOOD",
      unitsPerBox: 1,
    },
  });

  // Update shop mutation
  const updateShopMutation = useMutation({
    mutationFn: async (data: ShopForm & { id: number }) => {
      const response = await fetch(`/api/shops/${data.id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: data.name, active: data.active }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to update shop');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/shops'] });
      shopForm.reset();
      setEditingShop(null);
      setIsShopConfigOpen(false);
      toast({
        title: "Shop updated",
        description: "Shop has been updated successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to update shop",
        variant: "destructive",
      });
    },
  });

  // Create item mutation
  const createItemMutation = useMutation({
    mutationFn: async (data: ItemForm) => {
      const response = await fetch('/api/items', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to create item');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/items'] });
      itemForm.reset();
      setEditingItem(null);
      toast({
        title: "Item created",
        description: "Item has been created successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to create item",
        variant: "destructive",
      });
    },
  });

  // Update item mutation
  const updateItemMutation = useMutation({
    mutationFn: async (data: ItemForm & { id: number }) => {
      const response = await fetch(`/api/items/${data.id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to update item');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/items'] });
      itemForm.reset();
      setEditingItem(null);
      toast({
        title: "Item updated",
        description: "Item has been updated successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to update item",
        variant: "destructive",
      });
    },
  });

  // Delete item mutation
  const deleteItemMutation = useMutation({
    mutationFn: async (itemId: number) => {
      const response = await fetch(`/api/items/${itemId}`, {
        method: 'DELETE',
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to delete item');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/items'] });
      toast({
        title: "Item deleted",
        description: "Item has been deleted successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to delete item",
        variant: "destructive",
      });
    },
  });

  const onCreateOrUpdateItem = (data: ItemForm) => {
    if (editingItem) {
      updateItemMutation.mutate({ ...data, id: editingItem.id });
    } else {
      createItemMutation.mutate(data);
    }
  };

  const handleEditItem = (item: Item) => {
    setEditingItem(item);
    itemForm.reset({
      defaultName: item.defaultName,
      category: item.category,
      unitsPerBox: item.unitsPerBox,
    });
  };

  const handleDeleteItem = (itemId: number) => {
    if (confirm('Are you sure you want to delete this item? This action cannot be undoned.')) {
      deleteItemMutation.mutate(itemId);
    }
  };

  // Shop Item Management mutations
  const addShopItemMutation = useMutation({
    mutationFn: async ({ shopId, itemId }: { shopId: number; itemId: number }) => {
      const response = await fetch(`/api/shops/${shopId}/items`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ itemId }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to add item to shop');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [`/api/shops/${selectedShopForItems?.id}/items`] });
      queryClient.invalidateQueries({ queryKey: [`/api/shops/${selectedShopForItems?.id}/available-items`] });
      toast({
        title: "Item added",
        description: "Item has been added to shop successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to add item to shop",
        variant: "destructive",
      });
    },
  });

  const updateShopItemMutation = useMutation({
    mutationFn: async ({ shopId, itemId, active }: { shopId: number; itemId: number; active: boolean }) => {
      const response = await fetch(`/api/shops/${shopId}/items/${itemId}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ active }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to update shop item');
      }
      
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [`/api/shops/${selectedShopForItems?.id}/items`] });
      toast({
        title: "Item updated",
        description: "Shop item has been updated successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to update shop item",
        variant: "destructive",
      });
    },
  });

  const removeShopItemMutation = useMutation({
    mutationFn: async ({ shopId, itemId }: { shopId: number; itemId: number }) => {
      const response = await fetch(`/api/shops/${shopId}/items/${itemId}`, {
        method: 'DELETE',
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Failed to remove item from shop');
      }
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [`/api/shops/${selectedShopForItems?.id}/items`] });
      queryClient.invalidateQueries({ queryKey: [`/api/shops/${selectedShopForItems?.id}/available-items`] });
      toast({
        title: "Item removed",
        description: "Item has been removed from shop successfully",
      });
    },
    onError: () => {
      toast({
        title: "Error",
        description: "Failed to remove item from shop",
        variant: "destructive",
      });
    },
  });

  // Shop item handlers
  const handleManageShopItems = (shop: Shop) => {
    setSelectedShopForItems(shop);
    setIsShopItemsOpen(true);
  };

  const handleAddItemToShop = (itemId: number) => {
    if (selectedShopForItems) {
      addShopItemMutation.mutate({ shopId: selectedShopForItems.id, itemId });
    }
  };

  const handleToggleShopItem = (itemId: number, active: boolean) => {
    if (selectedShopForItems) {
      updateShopItemMutation.mutate({ shopId: selectedShopForItems.id, itemId, active });
    }
  };

  const handleRemoveShopItem = (itemId: number, itemName: string) => {
    if (selectedShopForItems && confirm(`Are you sure you want to remove "${itemName}" from this shop?`)) {
      removeShopItemMutation.mutate({ shopId: selectedShopForItems.id, itemId });
    }
  };

  const handleCloseShopItemsManagement = () => {
    setIsShopItemsOpen(false);
    setSelectedShopForItems(null);
  };

  // Mock stats for demo
  const stats = {
    activeUsers: users.filter(u => u.approved).length,
    completedShops: '0/10',
    itemsCounted: '0',
    progress: '0%',
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="bg-card border-b border-border sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-3 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-14 sm:h-16">
            <div className="flex items-center space-x-2 sm:space-x-4">
              <div className="w-7 h-7 sm:w-8 sm:h-8 bg-primary rounded-lg flex items-center justify-center">
                <Box className="text-primary-foreground text-xs sm:text-sm" />
              </div>
              <h1 className="text-base sm:text-xl font-semibold" data-testid="text-dashboard-title">Admin Dashboard</h1>
            </div>
            <div className="flex items-center space-x-2 sm:space-x-4">
              {/* Session Status - Hidden on very small screens */}
              <div className="hidden sm:flex items-center space-x-2 text-sm">
                <div className={`w-3 h-3 rounded-full ${activeSession ? 'bg-green-500' : 'bg-red-500'}`}></div>
                <span className="text-muted-foreground" data-testid="text-session-status">
                  {activeSession?.name || 'No Active Session'}
                </span>
              </div>
              {/* User Menu */}
              <button 
                onClick={handleLogout} 
                className="flex items-center space-x-1 sm:space-x-2 text-xs sm:text-sm text-muted-foreground hover:text-foreground transition-colors"
                data-testid="button-logout"
              >
                <Users className="w-4 h-4" />
                <span className="hidden sm:inline" data-testid="text-username">{user.name}</span>
                <LogOut className="w-4 h-4 sm:ml-2" />
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-3 sm:px-4 lg:px-8 py-3 sm:py-6 space-y-4 sm:space-y-6">
        {/* Stats Overview */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 sm:gap-4">
          <Card>
            <CardContent className="p-4 sm:p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xs sm:text-sm text-muted-foreground">Active Users</p>
                  <p className="text-lg sm:text-2xl font-bold" data-testid="text-stat-users">{stats.activeUsers}</p>
                </div>
                <div className="w-10 h-10 sm:w-12 sm:h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                  <Users className="text-primary w-5 h-5 sm:w-6 sm:h-6" />
                </div>
              </div>
            </CardContent>
          </Card>
          
          <Card>
            <CardContent className="p-4 sm:p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xs sm:text-sm text-muted-foreground">Shops Complete</p>
                  <p className="text-lg sm:text-2xl font-bold" data-testid="text-stat-shops">{stats.completedShops}</p>
                </div>
                <div className="w-10 h-10 sm:w-12 sm:h-12 bg-green-500/10 rounded-lg flex items-center justify-center">
                  <Store className="text-green-500 w-5 h-5 sm:w-6 sm:h-6" />
                </div>
              </div>
            </CardContent>
          </Card>
          
          <Card>
            <CardContent className="p-4 sm:p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xs sm:text-sm text-muted-foreground">Items Counted</p>
                  <p className="text-lg sm:text-2xl font-bold" data-testid="text-stat-items">{stats.itemsCounted}</p>
                </div>
                <div className="w-10 h-10 sm:w-12 sm:h-12 bg-blue-500/10 rounded-lg flex items-center justify-center">
                  <Box className="text-blue-500 w-5 h-5 sm:w-6 sm:h-6" />
                </div>
              </div>
            </CardContent>
          </Card>
          
          <Card>
            <CardContent className="p-4 sm:p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xs sm:text-sm text-muted-foreground">Session Progress</p>
                  <p className="text-lg sm:text-2xl font-bold" data-testid="text-stat-progress">{stats.progress}</p>
                </div>
                <div className="w-10 h-10 sm:w-12 sm:h-12 bg-amber-500/10 rounded-lg flex items-center justify-center">
                  <TrendingUp className="text-amber-500 w-5 h-5 sm:w-6 sm:h-6" />
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Tab Navigation */}
        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-6 text-xs sm:text-sm">
            <TabsTrigger value="users" data-testid="tab-users" className="px-2 sm:px-3">Users</TabsTrigger>
            <TabsTrigger value="shops" data-testid="tab-shops" className="px-2 sm:px-3">Shops</TabsTrigger>
            <TabsTrigger value="catalog" data-testid="tab-catalog" className="px-2 sm:px-3">
              <span className="hidden sm:inline">Catalog</span>
              <span className="sm:hidden">Cat</span>
            </TabsTrigger>
            <TabsTrigger value="sessions" data-testid="tab-sessions" className="px-2 sm:px-3">
              <span className="hidden sm:inline">Sessions</span>
              <span className="sm:hidden">Sess</span>
            </TabsTrigger>
            <TabsTrigger value="exports" data-testid="tab-exports" className="px-2 sm:px-3">
              <span className="hidden sm:inline">Exports</span>
              <span className="sm:hidden">Exp</span>
            </TabsTrigger>
            <TabsTrigger value="costs" data-testid="tab-costs" className="px-2 sm:px-3">
              <span className="hidden sm:inline">Costs</span>
              <span className="sm:hidden">Cost</span>
            </TabsTrigger>
          </TabsList>

          {/* Users Tab */}
          <TabsContent value="users">
            <Card>
              <CardHeader>
                <div className="flex justify-between items-center">
                  <div>
                    <CardTitle>User Management</CardTitle>
                    <CardDescription>Manage user accounts and permissions</CardDescription>
                  </div>
                  <div className="flex space-x-2">
                    {users.filter(u => u.role !== 'OWNER' && u.username !== 'admin').length > 0 && (
                      <Button 
                        variant="destructive" 
                        size="sm"
                        onClick={handleBulkDeleteUsers}
                        disabled={bulkDeleteUsersMutation.isPending}
                        data-testid="button-bulk-delete-users"
                      >
                        <X className="w-4 h-4 mr-2" />
                        Delete All Non-Admin
                      </Button>
                    )}
                    <Dialog open={isCreateUserOpen} onOpenChange={setIsCreateUserOpen}>
                      <DialogTrigger asChild>
                        <Button data-testid="button-create-user">
                          <Plus className="w-4 h-4 mr-2" />
                          Create User
                        </Button>
                      </DialogTrigger>
                      <DialogContent className="max-w-2xl">
                      <DialogHeader>
                        <DialogTitle>Create New User</DialogTitle>
                        <DialogDescription>
                          Create a new user account and assign shop permissions
                        </DialogDescription>
                      </DialogHeader>
                      
                      <Form {...createUserForm}>
                        <form onSubmit={createUserForm.handleSubmit(onCreateUser)} className="space-y-4">
                          <div className="grid grid-cols-2 gap-4">
                            <FormField
                              control={createUserForm.control}
                              name="name"
                              render={({ field }) => (
                                <FormItem>
                                  <FormLabel>Full Name</FormLabel>
                                  <FormControl>
                                    <Input placeholder="John Doe" {...field} data-testid="input-user-name" />
                                  </FormControl>
                                  <FormMessage />
                                </FormItem>
                              )}
                            />
                            
                            <FormField
                              control={createUserForm.control}
                              name="username"
                              render={({ field }) => (
                                <FormItem>
                                  <FormLabel>Username</FormLabel>
                                  <FormControl>
                                    <Input placeholder="johndoe" {...field} data-testid="input-user-username" />
                                  </FormControl>
                                  <FormMessage />
                                </FormItem>
                              )}
                            />
                          </div>

                          <FormField
                            control={createUserForm.control}
                            name="password"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Password</FormLabel>
                                <FormControl>
                                  <Input 
                                    type="password" 
                                    placeholder="Enter password" 
                                    {...field} 
                                    data-testid="input-user-password" 
                                  />
                                </FormControl>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                          
                          <FormField
                            control={createUserForm.control}
                            name="role"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Role</FormLabel>
                                <Select onValueChange={field.onChange} defaultValue={field.value}>
                                  <FormControl>
                                    <SelectTrigger data-testid="select-user-role">
                                      <SelectValue placeholder="Select a role" />
                                    </SelectTrigger>
                                  </FormControl>
                                  <SelectContent>
                                    <SelectItem value="OWNER">Owner</SelectItem>
                                    <SelectItem value="SUPERVISOR">Supervisor</SelectItem>
                                    <SelectItem value="EMPLOYEE">Employee</SelectItem>
                                  </SelectContent>
                                </Select>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                          
                          <FormField
                            control={createUserForm.control}
                            name="shopIds"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Shop Assignments</FormLabel>
                                <div className="grid grid-cols-2 gap-2 max-h-40 overflow-y-auto border rounded p-3">
                                  {shops.map((shop) => (
                                    <div key={shop.id} className="flex items-center space-x-2">
                                      <Checkbox
                                        id={`shop-${shop.id}`}
                                        checked={field.value?.includes(shop.id) || false}
                                        onCheckedChange={(checked) => {
                                          const currentShops = field.value || [];
                                          if (checked) {
                                            field.onChange([...currentShops, shop.id]);
                                          } else {
                                            field.onChange(currentShops.filter(id => id !== shop.id));
                                          }
                                        }}
                                        data-testid={`checkbox-shop-${shop.id}`}
                                      />
                                      <label 
                                        htmlFor={`shop-${shop.id}`} 
                                        className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                                      >
                                        {shop.name}
                                      </label>
                                    </div>
                                  ))}
                                </div>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                          
                          <div className="flex justify-end space-x-2 pt-4">
                            <Button 
                              type="button" 
                              variant="outline" 
                              onClick={() => setIsCreateUserOpen(false)}
                              data-testid="button-cancel-user"
                            >
                              Cancel
                            </Button>
                            <Button 
                              type="submit" 
                              disabled={createUserMutation.isPending}
                              data-testid="button-save-user"
                            >
                              {createUserMutation.isPending ? 'Creating...' : 'Create User'}
                            </Button>
                          </div>
                        </form>
                      </Form>
                    </DialogContent>
                  </Dialog>
                </div>
                  
                  {/* Edit User Dialog */}
                  <Dialog open={isEditUserOpen} onOpenChange={setIsEditUserOpen}>
                    <DialogContent className="max-w-2xl">
                      <DialogHeader>
                        <DialogTitle>Edit User</DialogTitle>
                        <DialogDescription>
                          Edit user account details and permissions
                        </DialogDescription>
                      </DialogHeader>
                      
                      <Form {...editUserForm}>
                        <form onSubmit={editUserForm.handleSubmit(onEditUser)} className="space-y-4">
                          <div className="grid grid-cols-2 gap-4">
                            <FormField
                              control={editUserForm.control}
                              name="name"
                              render={({ field }) => (
                                <FormItem>
                                  <FormLabel>Full Name</FormLabel>
                                  <FormControl>
                                    <Input placeholder="John Doe" {...field} data-testid="input-edit-user-name" />
                                  </FormControl>
                                  <FormMessage />
                                </FormItem>
                              )}
                            />
                            
                            <FormField
                              control={editUserForm.control}
                              name="username"
                              render={({ field }) => (
                                <FormItem>
                                  <FormLabel>Username</FormLabel>
                                  <FormControl>
                                    <Input placeholder="johndoe" {...field} data-testid="input-edit-user-username" />
                                  </FormControl>
                                  <FormMessage />
                                </FormItem>
                              )}
                            />
                          </div>

                          <FormField
                            control={editUserForm.control}
                            name="password"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>New Password (leave blank to keep current)</FormLabel>
                                <FormControl>
                                  <Input 
                                    type="password" 
                                    placeholder="Enter new password" 
                                    {...field} 
                                    data-testid="input-edit-user-password" 
                                  />
                                </FormControl>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                          
                          <FormField
                            control={editUserForm.control}
                            name="role"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Role</FormLabel>
                                <Select onValueChange={field.onChange} value={field.value}>
                                  <FormControl>
                                    <SelectTrigger data-testid="select-edit-user-role">
                                      <SelectValue placeholder="Select a role" />
                                    </SelectTrigger>
                                  </FormControl>
                                  <SelectContent>
                                    <SelectItem value="OWNER">Owner</SelectItem>
                                    <SelectItem value="SUPERVISOR">Supervisor</SelectItem>
                                    <SelectItem value="EMPLOYEE">Employee</SelectItem>
                                  </SelectContent>
                                </Select>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                          
                          <FormField
                            control={editUserForm.control}
                            name="shopIds"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Shop Assignments</FormLabel>
                                <div className="grid grid-cols-2 gap-2 max-h-40 overflow-y-auto border rounded p-3">
                                  {shops.map((shop) => (
                                    <div key={shop.id} className="flex items-center space-x-2">
                                      <Checkbox
                                        id={`edit-shop-${shop.id}`}
                                        checked={field.value?.includes(shop.id) || false}
                                        onCheckedChange={(checked) => {
                                          const currentShops = field.value || [];
                                          if (checked) {
                                            field.onChange([...currentShops, shop.id]);
                                          } else {
                                            field.onChange(currentShops.filter(id => id !== shop.id));
                                          }
                                        }}
                                        data-testid={`checkbox-edit-shop-${shop.id}`}
                                      />
                                      <label 
                                        htmlFor={`edit-shop-${shop.id}`} 
                                        className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                                      >
                                        {shop.name}
                                      </label>
                                    </div>
                                  ))}
                                </div>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                          
                          <div className="flex justify-end space-x-2 pt-4">
                            <Button 
                              type="button" 
                              variant="outline" 
                              onClick={() => {
                                setIsEditUserOpen(false);
                                setEditingUser(null);
                                editUserForm.reset();
                              }}
                              data-testid="button-cancel-edit-user"
                            >
                              Cancel
                            </Button>
                            <Button 
                              type="submit" 
                              disabled={updateUserMutation.isPending}
                              data-testid="button-save-edit-user"
                            >
                              {updateUserMutation.isPending ? 'Updating...' : 'Update User'}
                            </Button>
                          </div>
                        </form>
                      </Form>
                    </DialogContent>
                  </Dialog>
                </div>
              </CardHeader>
              
              <CardContent>
                <div className="space-y-4">
                  {users.length === 0 ? (
                    <div className="text-center py-8 text-muted-foreground" data-testid="text-no-users">
                      No users found. Create your first user to get started.
                    </div>
                  ) : (
                    users.map((user) => (
                      <div key={user.id} className="flex items-center justify-between p-4 border border-border rounded-lg" data-testid={`user-card-${user.id}`}>
                        <div className="flex items-center space-x-4">
                          <div className="w-10 h-10 bg-primary/10 rounded-lg flex items-center justify-center">
                            <Users className="text-primary" />
                          </div>
                          <div>
                            <h4 className="font-medium" data-testid={`text-user-name-${user.id}`}>{user.name}</h4>
                            <p className="text-sm text-muted-foreground" data-testid={`text-user-username-${user.id}`}>@{user.username}</p>
                            <div className="flex items-center space-x-2 mt-1">
                              <Badge variant="secondary" data-testid={`badge-user-role-${user.id}`}>
                                {user.role}
                              </Badge>
                              <Badge 
                                variant={user.approved ? "default" : "destructive"} 
                                data-testid={`badge-user-status-${user.id}`}
                              >
                                {user.approved ? 'APPROVED' : 'PENDING'}
                              </Badge>
                              {user.lastLoginAt && (
                                <span className="text-xs text-muted-foreground" data-testid={`text-user-lastlogin-${user.id}`}>
                                  Last: {new Date(user.lastLoginAt).toLocaleDateString()}
                                </span>
                              )}
                            </div>
                          </div>
                        </div>
                        <div className="flex items-center space-x-2">
                          <Button 
                            size="sm" 
                            variant="outline"
                            onClick={() => handleEditUser(user)}
                            data-testid={`button-edit-user-${user.id}`}
                          >
                            <Edit className="w-4 h-4" />
                          </Button>
                          {user.role !== 'OWNER' && user.username !== 'admin' && (
                            <Button 
                              size="sm" 
                              variant="outline"
                              onClick={() => handleDeleteUser(user.id, user.name)}
                              disabled={deleteUserMutation.isPending}
                              data-testid={`button-delete-user-${user.id}`}
                            >
                              <X className="w-4 h-4" />
                            </Button>
                          )}
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Shops Tab */}
          <TabsContent value="shops">
            <Card>
              <CardHeader>
                <CardTitle>Shop Management</CardTitle>
                <CardDescription>Configure shops and items</CardDescription>
              </CardHeader>
              
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {shops.map((shop) => (
                    <Card key={shop.id} className="p-4" data-testid={`shop-card-${shop.id}`}>
                      <div className="flex items-center justify-between mb-3">
                        <h4 className="font-medium" data-testid={`text-shop-name-${shop.id}`}>{shop.name}</h4>
                        <Badge variant={shop.active ? "default" : "secondary"}>
                          {shop.active ? 'ACTIVE' : 'INACTIVE'}
                        </Badge>
                      </div>
                      <div className="space-y-2 text-sm text-muted-foreground">
                        <div className="flex justify-between">
                          <span>Items:</span>
                          <span data-testid={`text-shop-items-${shop.id}`}>40/40</span>
                        </div>
                        <div className="flex justify-between">
                          <span>Assigned Users:</span>
                          <span data-testid={`text-shop-users-${shop.id}`}>0</span>
                        </div>
                        <div className="flex justify-between">
                          <span>Progress:</span>
                          <span data-testid={`text-shop-progress-${shop.id}`}>0%</span>
                        </div>
                      </div>
                      <div className="flex gap-2 mt-3">
                        <Button 
                          className="flex-1" 
                          variant="secondary"
                          onClick={() => handleConfigureShop(shop)}
                          data-testid={`button-configure-shop-${shop.id}`}
                        >
                          <Settings className="w-4 h-4 mr-2" />
                          Configure
                        </Button>
                        <Button 
                          className="flex-1" 
                          variant="outline"
                          onClick={() => handleManageShopItems(shop)}
                          data-testid={`button-manage-items-shop-${shop.id}`}
                        >
                          <Box className="w-4 h-4 mr-2" />
                          Manage Items
                        </Button>
                      </div>
                    </Card>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Catalog Tab */}
          <TabsContent value="catalog">
            <Card>
              <CardHeader>
                <CardTitle>Item Catalog</CardTitle>
                <CardDescription>Manage your inventory items. Add, edit, or remove items from your catalog.</CardDescription>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Add New Item Form */}
                <Card>
                  <CardHeader>
                    <CardTitle className="text-lg">
                      {editingItem ? 'Edit Item' : 'Add New Item'}
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <Form {...itemForm}>
                      <form onSubmit={itemForm.handleSubmit(onCreateOrUpdateItem)} className="space-y-4">
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                          <FormField
                            control={itemForm.control}
                            name="defaultName"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Item Name</FormLabel>
                                <FormControl>
                                  <Input 
                                    placeholder="e.g., Red Bull 250ml" 
                                    data-testid="input-item-name"
                                    {...field} 
                                  />
                                </FormControl>
                                <FormMessage />
                              </FormItem>
                            )}
                          />

                          <FormField
                            control={itemForm.control}
                            name="category"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Category</FormLabel>
                                <Select onValueChange={field.onChange} value={field.value}>
                                  <FormControl>
                                    <SelectTrigger data-testid="select-item-category">
                                      <SelectValue placeholder="Select category" />
                                    </SelectTrigger>
                                  </FormControl>
                                  <SelectContent>
                                    <SelectItem value="FOOD">Food</SelectItem>
                                    <SelectItem value="DRINK">Drink</SelectItem>
                                    <SelectItem value="ICECREAM">Ice Cream</SelectItem>
                                    <SelectItem value="STROMMA">Stromma Branded</SelectItem>
                                  </SelectContent>
                                </Select>
                                <FormMessage />
                              </FormItem>
                            )}
                          />

                          <FormField
                            control={itemForm.control}
                            name="unitsPerBox"
                            render={({ field }) => (
                              <FormItem>
                                <FormLabel>Units per Box</FormLabel>
                                <FormControl>
                                  <Input 
                                    type="number" 
                                    min="1"
                                    placeholder="6"
                                    data-testid="input-units-per-box"
                                    {...field}
                                    onChange={e => field.onChange(parseInt(e.target.value) || 1)}
                                  />
                                </FormControl>
                                <FormMessage />
                              </FormItem>
                            )}
                          />
                        </div>

                        <div className="flex gap-2">
                          <Button 
                            type="submit" 
                            disabled={createItemMutation.isPending || updateItemMutation.isPending}
                            data-testid="button-save-item"
                          >
                            {editingItem ? 'Update Item' : 'Add Item'}
                          </Button>
                          
                          {editingItem && (
                            <Button 
                              type="button" 
                              variant="outline" 
                              onClick={() => {
                                setEditingItem(null);
                                itemForm.reset();
                              }}
                              data-testid="button-cancel-edit"
                            >
                              Cancel Edit
                            </Button>
                          )}
                        </div>
                      </form>
                    </Form>
                  </CardContent>
                </Card>

                {/* CSV Import/Export */}
                {user?.role === 'OWNER' && (
                  <Card>
                    <CardHeader>
                      <CardTitle className="text-lg">Bulk Import/Export</CardTitle>
                      <CardDescription>Import or export items catalog as CSV for easy editing</CardDescription>
                    </CardHeader>
                    <CardContent>
                      <div className="flex gap-2">
                        <Button
                          variant="outline"
                          onClick={async () => {
                            try {
                              const response = await fetch('/api/exports/items.csv', {
                                credentials: 'include',
                              });
                              if (!response.ok) throw new Error('Export failed');
                              const blob = await response.blob();
                              const url = window.URL.createObjectURL(blob);
                              const a = document.createElement('a');
                              a.href = url;
                              a.download = 'items-catalog.csv';
                              document.body.appendChild(a);
                              a.click();
                              window.URL.revokeObjectURL(url);
                              document.body.removeChild(a);
                              toast({
                                title: "Export successful",
                                description: "Items catalog exported to CSV",
                              });
                            } catch (error) {
                              toast({
                                title: "Export failed",
                                description: "Failed to export items catalog",
                                variant: "destructive",
                              });
                            }
                          }}
                          data-testid="button-export-items-csv"
                        >
                          <Download className="w-4 h-4 mr-2" />
                          Export CSV
                        </Button>
                        <Button
                          variant="outline"
                          onClick={() => {
                            const input = document.createElement('input');
                            input.type = 'file';
                            input.accept = '.csv';
                            input.onchange = async (e) => {
                              const file = (e.target as HTMLInputElement).files?.[0];
                              if (!file) return;
                              
                              try {
                                const text = await file.text();
                                const response = await fetch('/api/imports/items.csv', {
                                  method: 'POST',
                                  headers: { 'Content-Type': 'application/json' },
                                  body: JSON.stringify({ csv: text }),
                                  credentials: 'include',
                                });
                                
                                if (!response.ok) {
                                  const error = await response.json();
                                  throw new Error(error.message || 'Import failed');
                                }
                                
                                const result = await response.json();
                                queryClient.invalidateQueries({ queryKey: ['/api/items'] });
                                toast({
                                  title: "Import successful",
                                  description: result.message,
                                });
                              } catch (error) {
                                toast({
                                  title: "Import failed",
                                  description: error instanceof Error ? error.message : 'Failed to import items',
                                  variant: "destructive",
                                });
                              }
                            };
                            input.click();
                          }}
                          data-testid="button-import-items-csv"
                        >
                          <FileText className="w-4 h-4 mr-2" />
                          Import CSV
                        </Button>
                      </div>
                    </CardContent>
                  </Card>
                )}

                {/* Items List */}
                <Card>
                  <CardHeader>
                    <CardTitle className="text-lg">Current Items ({items.length})</CardTitle>
                  </CardHeader>
                  <CardContent>
                    {items.length === 0 ? (
                      <div className="text-center py-8 text-muted-foreground">
                        No items found. Add your first item above.
                      </div>
                    ) : (
                      <Accordion type="multiple" className="w-full">
                        {Object.entries(groupItemsByCategory(items)).map(([category, categoryItems]) => {
                          if (categoryItems.length === 0) return null;
                          
                          return (
                            <AccordionItem key={category} value={category}>
                              <AccordionTrigger className="hover:no-underline">
                                <div className="flex items-center gap-2">
                                  <Badge className={categoryColors[category as keyof typeof categoryColors]}>
                                    {category}
                                  </Badge>
                                  <span className="text-sm text-muted-foreground">
                                    ({categoryItems.length} items)
                                  </span>
                                </div>
                              </AccordionTrigger>
                              <AccordionContent>
                                <div className="space-y-2 pt-2">
                                  {categoryItems.map((item) => (
                                    <div 
                                      key={item.id} 
                                      className="flex items-center justify-between p-3 border rounded-lg hover:bg-muted/50"
                                      data-testid={`item-row-${item.id}`}
                                    >
                                      <div className="flex items-center justify-between">
                                        <div className="flex-1">
                                          <div className="font-medium" data-testid={`text-item-name-${item.id}`}>
                                            {item.defaultName}
                                          </div>
                                          <div className="text-sm text-muted-foreground">
                                            <span data-testid={`text-units-per-box-${item.id}`}>
                                              {item.unitsPerBox} units/box
                                            </span>
                                          </div>
                                        </div>
                                        
                                        <div className="flex gap-2">
                                          <Button 
                                            size="sm" 
                                            variant="outline"
                                            onClick={() => handleEditItem(item)}
                                            data-testid={`button-edit-item-${item.id}`}
                                          >
                                            <Edit className="w-4 h-4" />
                                          </Button>
                                          <Button 
                                            size="sm" 
                                            variant="outline"
                                            onClick={() => handleDeleteItem(item.id)}
                                            disabled={deleteItemMutation.isPending}
                                            data-testid={`button-delete-item-${item.id}`}
                                          >
                                            <X className="w-4 h-4" />
                                          </Button>
                                        </div>
                                      </div>
                                    </div>
                                  ))}
                                </div>
                              </AccordionContent>
                            </AccordionItem>
                          );
                        })}
                      </Accordion>
                    )}
                  </CardContent>
                </Card>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Sessions Tab */}
          <TabsContent value="sessions">
            <Card>
              <CardHeader>
                <div className="flex justify-between items-center">
                  <div>
                    <CardTitle>Inventory Sessions</CardTitle>
                    <CardDescription>Manage counting sessions</CardDescription>
                  </div>
                  <Dialog open={isCreateSessionOpen} onOpenChange={setIsCreateSessionOpen}>
                    <DialogTrigger asChild>
                      <Button data-testid="button-new-session">
                        <Plus className="w-4 h-4 mr-2" />
                        New Session
                      </Button>
                    </DialogTrigger>
                    <DialogContent>
                      <DialogHeader>
                        <DialogTitle>Create New Session</DialogTitle>
                        <DialogDescription>
                          Create a new inventory counting session
                        </DialogDescription>
                      </DialogHeader>
                      
                      <div className="space-y-4">
                        <div>
                          <label htmlFor="session-name" className="block text-sm font-medium mb-2">
                            Session Name
                          </label>
                          <Input
                            id="session-name"
                            placeholder="e.g., Monthly Count - January 2024"
                            value={sessionName}
                            onChange={(e) => setSessionName(e.target.value)}
                            data-testid="input-session-name"
                          />
                        </div>
                        
                        <div className="flex justify-end space-x-2 pt-4">
                          <Button 
                            variant="outline" 
                            onClick={() => setIsCreateSessionOpen(false)}
                            data-testid="button-cancel-session"
                          >
                            Cancel
                          </Button>
                          <Button 
                            onClick={handleCreateSession}
                            disabled={createSessionMutation.isPending || !sessionName.trim()}
                            data-testid="button-save-session"
                          >
                            {createSessionMutation.isPending ? 'Creating...' : 'Create Session'}
                          </Button>
                        </div>
                      </div>
                    </DialogContent>
                  </Dialog>
                </div>
              </CardHeader>
              
              <CardContent>
                <div className="space-y-4">
                  {sessions.length === 0 ? (
                    <div className="text-center py-8 text-muted-foreground" data-testid="text-no-sessions">
                      No sessions found. Create your first inventory session.
                    </div>
                  ) : (
                    sessions.map((session) => (
                      <div 
                        key={session.id} 
                        className={`p-4 rounded-lg border-2 ${
                          session.status === 'OPEN' 
                            ? 'border-primary bg-primary/5' 
                            : 'border-border'
                        }`}
                        data-testid={`session-card-${session.id}`}
                      >
                        <div className="flex items-center justify-between mb-3">
                          <div>
                            <h4 className="font-medium" data-testid={`text-session-name-${session.id}`}>
                              {session.name}
                            </h4>
                            <div className="space-y-1">
                              <p className="text-sm text-muted-foreground" data-testid={`text-session-date-${session.id}`}>
                                Started: {new Date(session.createdAt).toLocaleString()}
                              </p>
                              {session.status === 'OPEN' && session.autoCloseAt && (
                                <p className="text-sm text-muted-foreground" data-testid={`text-session-autoclose-${session.id}`}>
                                  Auto-closes: {new Date(session.autoCloseAt).toLocaleString()}
                                </p>
                              )}
                              {session.status === 'CLOSED' && session.closedAt && (
                                <p className="text-sm text-muted-foreground" data-testid={`text-session-closed-${session.id}`}>
                                  Closed: {new Date(session.closedAt).toLocaleString()}
                                </p>
                              )}
                            </div>
                          </div>
                          <Badge variant={session.status === 'OPEN' ? 'default' : 'secondary'}>
                            {session.status}
                          </Badge>
                        </div>
                        {session.status === 'OPEN' && (
                          <div className="flex space-x-4">
                            <Button 
                              variant="outline" 
                              onClick={() => closeSessionMutation.mutate(session.id)}
                              disabled={closeSessionMutation.isPending}
                              data-testid={`button-close-session-${session.id}`}
                            >
                              Close Session
                            </Button>
                            <Button 
                              variant="outline" 
                              onClick={() => reopenCountsMutation.mutate(session.id)}
                              disabled={reopenCountsMutation.isPending}
                              data-testid={`button-reopen-counts-${session.id}`}
                            >
                              Reopen Counts
                            </Button>
                          </div>
                        )}
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Exports Tab */}
          <TabsContent value="exports">
            <Card>
              <CardHeader>
                <CardTitle>Data Exports</CardTitle>
                <CardDescription>Generate Excel and CSV exports for inventory data</CardDescription>
              </CardHeader>
              
              <CardContent className="space-y-6">
                {/* Quick Export Options */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <Button 
                    variant="outline" 
                    className="p-4 sm:p-6 h-auto justify-start"
                    onClick={() => exportAllMutation.mutate()}
                    disabled={exportAllMutation.isPending || !activeSession}
                    data-testid="button-export-all"
                  >
                    <div className="flex items-center space-x-3 w-full">
                      <div className="w-10 h-10 sm:w-12 sm:h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                        <FileText className="text-primary text-lg sm:text-xl" />
                      </div>
                      <div className="text-left">
                        <h4 className="font-medium text-sm sm:text-base text-primary">Complete Workbook</h4>
                        <p className="text-xs sm:text-sm text-muted-foreground">All shops + summary sheet</p>
                      </div>
                    </div>
                  </Button>
                  
                  <Button 
                    variant="outline" 
                    className="p-4 sm:p-6 h-auto justify-start"
                    onClick={() => exportSummaryMutation.mutate()}
                    disabled={exportSummaryMutation.isPending || !activeSession}
                    data-testid="button-export-summary"
                  >
                    <div className="flex items-center space-x-3 w-full">
                      <div className="w-10 h-10 sm:w-12 sm:h-12 bg-secondary/10 rounded-lg flex items-center justify-center">
                        <BarChart3 className="text-secondary-foreground text-lg sm:text-xl" />
                      </div>
                      <div className="text-left">
                        <h4 className="font-medium text-sm sm:text-base">Summary Only</h4>
                        <p className="text-xs sm:text-sm text-muted-foreground">Aggregated totals by category</p>
                      </div>
                    </div>
                  </Button>
                </div>
                
                {/* Individual Shop Exports */}
                <div>
                  <h4 className="font-medium mb-3">Individual Shop Exports</h4>
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
                    {shops.map((shop) => (
                      <Button 
                        key={shop.id}
                        variant="outline" 
                        className="p-3 h-auto justify-between"
                        onClick={() => exportMutation.mutate(shop.id)}
                        disabled={exportMutation.isPending || !activeSession}
                        data-testid={`button-export-shop-${shop.id}`}
                      >
                        <div className="text-left">
                          <span className="font-medium">{shop.name}</span>
                          <p className="text-sm text-muted-foreground">Excel • CSV</p>
                        </div>
                        <Download className="w-4 h-4 text-muted-foreground" />
                      </Button>
                    ))}
                  </div>
                </div>

                {!activeSession && (
                  <div className="text-center py-4 text-muted-foreground" data-testid="text-no-active-session">
                    No active session. Create and activate a session to enable exports.
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Cost Management Tab */}
          <TabsContent value="costs">
            <Card>
              <CardHeader>
                <CardTitle>Cost Management</CardTitle>
                <CardDescription>Manage item costs and pricing data</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <p className="text-sm text-muted-foreground">
                    Cost management allows you to track and update item costs across all locations. This data is used for variance calculations and financial reporting.
                  </p>
                  <Link href="/costs">
                    <Button className="w-full sm:w-auto" data-testid="button-open-cost-management">
                      <DollarSign className="w-4 h-4 mr-2" />
                      Open Cost Management
                    </Button>
                  </Link>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>

      {/* Shop Configuration Modal */}
      <Dialog open={isShopConfigOpen} onOpenChange={setIsShopConfigOpen}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>Configure Shop</DialogTitle>
            <DialogDescription>
              Update shop settings and status
            </DialogDescription>
          </DialogHeader>

          <Form {...shopForm}>
            <form onSubmit={shopForm.handleSubmit(onUpdateShop)} className="space-y-4">
              <FormField
                control={shopForm.control}
                name="name"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Shop Name</FormLabel>
                    <FormControl>
                      <Input 
                        placeholder="e.g., Shop 01" 
                        data-testid="input-shop-name"
                        {...field} 
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={shopForm.control}
                name="active"
                render={({ field }) => (
                  <FormItem className="flex flex-row items-center justify-between rounded-lg border p-3">
                    <div className="space-y-0.5">
                      <FormLabel>Shop Status</FormLabel>
                      <div className="text-sm text-muted-foreground">
                        {field.value ? 'Shop is active and available for counting' : 'Shop is inactive and not available'}
                      </div>
                    </div>
                    <FormControl>
                      <Checkbox
                        checked={field.value}
                        onCheckedChange={field.onChange}
                        data-testid="checkbox-shop-active"
                      />
                    </FormControl>
                  </FormItem>
                )}
              />

              <div className="flex justify-end space-x-2 pt-4">
                <Button 
                  type="button" 
                  variant="outline" 
                  onClick={() => {
                    setIsShopConfigOpen(false);
                    setEditingShop(null);
                    shopForm.reset();
                  }}
                  data-testid="button-cancel-shop-config"
                >
                  Cancel
                </Button>
                <Button 
                  type="submit" 
                  disabled={updateShopMutation.isPending}
                  data-testid="button-save-shop-config"
                >
                  {updateShopMutation.isPending ? 'Updating...' : 'Update Shop'}
                </Button>
              </div>
            </form>
          </Form>
        </DialogContent>
      </Dialog>

      {/* Shop Item Management Modal */}
      <Dialog open={isShopItemsOpen} onOpenChange={setIsShopItemsOpen}>
        <DialogContent className="max-w-4xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>
              Manage Items - {selectedShopForItems?.name}
            </DialogTitle>
            <DialogDescription>
              Configure which items are available in this shop
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-6">
            {/* Current Shop Items */}
            <div>
              <h3 className="text-lg font-medium mb-3">Current Shop Items ({shopItems.length})</h3>
              {shopItems.length === 0 ? (
                <p className="text-muted-foreground text-center py-4">
                  No items configured for this shop yet.
                </p>
              ) : (
                <Accordion type="multiple" className="w-full">
                  {Object.entries(groupItemsByCategory(shopItems)).map(([category, categoryItems]) => {
                    if (categoryItems.length === 0) return null;
                    
                    return (
                      <AccordionItem key={category} value={category}>
                        <AccordionTrigger className="hover:no-underline">
                          <div className="flex items-center gap-2">
                            <Badge className={categoryColors[category as keyof typeof categoryColors]}>
                              {category}
                            </Badge>
                            <span className="text-sm text-muted-foreground">
                              ({categoryItems.length} items)
                            </span>
                          </div>
                        </AccordionTrigger>
                        <AccordionContent>
                          <div className="grid grid-cols-1 md:grid-cols-2 gap-3 pt-2">
                            {categoryItems.map((item) => (
                              <Card key={item.id} className="p-3">
                                <div className="flex items-center justify-between">
                                  <div>
                                    <h4 className="font-medium" data-testid={`text-shop-item-${item.id}`}>
                                      {item.defaultName}
                                    </h4>
                                    <div className="text-sm text-muted-foreground">
                                      {item.unitsPerBox} units/box
                                    </div>
                                  </div>
                                  <div className="flex items-center space-x-2">
                                    <Checkbox
                                      checked={item.active}
                                      onCheckedChange={(checked) => 
                                        handleToggleShopItem(item.id, Boolean(checked))
                                      }
                                      data-testid={`checkbox-shop-item-active-${item.id}`}
                                    />
                                    <span className="text-xs text-muted-foreground">
                                      {item.active ? 'Active' : 'Inactive'}
                                    </span>
                                    <Button
                                      size="sm"
                                      variant="destructive"
                                      onClick={() => handleRemoveShopItem(item.id, item.defaultName)}
                                      data-testid={`button-remove-shop-item-${item.id}`}
                                    >
                                      <X className="w-4 h-4" />
                                    </Button>
                                  </div>
                                </div>
                              </Card>
                            ))}
                          </div>
                        </AccordionContent>
                      </AccordionItem>
                    );
                  })}
                </Accordion>
              )}
            </div>

            {/* Available Items to Add */}
            <div>
              <h3 className="text-lg font-medium mb-3">Available Items to Add ({availableItems.length})</h3>
              {availableItems.length === 0 ? (
                <p className="text-muted-foreground text-center py-4">
                  All items are already configured for this shop.
                </p>
              ) : (
                <Accordion type="multiple" className="w-full">
                  {Object.entries(groupItemsByCategory(availableItems)).map(([category, categoryItems]) => {
                    if (categoryItems.length === 0) return null;
                    
                    return (
                      <AccordionItem key={category} value={category}>
                        <AccordionTrigger className="hover:no-underline">
                          <div className="flex items-center gap-2">
                            <Badge className={categoryColors[category as keyof typeof categoryColors]}>
                              {category}
                            </Badge>
                            <span className="text-sm text-muted-foreground">
                              ({categoryItems.length} items)
                            </span>
                          </div>
                        </AccordionTrigger>
                        <AccordionContent>
                          <div className="grid grid-cols-1 md:grid-cols-2 gap-3 pt-2">
                            {categoryItems.map((item) => (
                              <Card key={item.id} className="p-3">
                                <div className="flex items-center justify-between">
                                  <div>
                                    <h4 className="font-medium" data-testid={`text-available-item-${item.id}`}>
                                      {item.defaultName}
                                    </h4>
                                    <div className="text-sm text-muted-foreground">
                                      {item.unitsPerBox} units/box
                                    </div>
                                  </div>
                                  <Button
                                    size="sm"
                                    onClick={() => handleAddItemToShop(item.id)}
                                    disabled={addShopItemMutation.isPending}
                                    data-testid={`button-add-shop-item-${item.id}`}
                                  >
                                    <Plus className="w-4 h-4 mr-2" />
                                    Add
                                  </Button>
                                </div>
                              </Card>
                            ))}
                          </div>
                        </AccordionContent>
                      </AccordionItem>
                    );
                  })}
                </Accordion>
              )}
            </div>
          </div>

          <div className="flex justify-end pt-4">
            <Button 
              onClick={handleCloseShopItemsManagement}
              data-testid="button-close-shop-items"
            >
              Close
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
