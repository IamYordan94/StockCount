import { useState } from "react";
import { useQuery, useMutation } from "@tanstack/react-query";
import { queryClient, apiRequest } from "@/lib/queryClient";
import { useAuth } from "@/hooks/use-auth";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { insertCostSchema } from "@shared/schema";
import { Link } from "wouter";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";
import { Badge } from "@/components/ui/badge";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { useToast } from "@/hooks/use-toast";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogFooter
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from "@/components/ui/select";
import {
  ArrowLeft,
  Plus,
  Edit,
  Trash2,
  DollarSign,
  Calendar,
  Package
} from "lucide-react";

interface Cost {
  id: string;
  itemId: number;
  costPerUom: string;
  currency: string;
  effectiveFrom: string;
  createdAt: string;
}

interface Item {
  id: number;
  defaultName: string;
  sku: string | null;
  category: string;
}

interface CostWithItem extends Cost {
  item?: Item;
}

// Form schema for creating costs
const createCostFormSchema = insertCostSchema.extend({
  itemId: z.coerce.number().min(1, "Please select an item"),
  costPerUom: z.coerce.number().min(0, "Cost must be positive"),
  effectiveFrom: z.string().min(1, "Please select a date")
});

// Form schema for updating costs
const updateCostFormSchema = z.object({
  costPerUom: z.coerce.number().min(0, "Cost must be positive"),
  currency: z.string().min(1, "Currency is required"),
  effectiveFrom: z.string().min(1, "Please select a date")
});

// Category color mapping
const categoryColors = {
  FOOD: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200 border-green-300',
  DRINK: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200 border-blue-300',
  ICECREAM: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200 border-purple-300',
  STROMMA: 'bg-orange-100 text-orange-800 dark:bg-orange-900 dark:text-orange-200 border-orange-300',
};

// Helper function to group costs by category
function groupCostsByCategory(costs: CostWithItem[]) {
  const grouped: Record<string, CostWithItem[]> = {
    FOOD: [],
    DRINK: [],
    ICECREAM: [],
    STROMMA: [],
  };
  
  costs.forEach(cost => {
    const category = cost.item?.category;
    if (category && grouped[category]) {
      grouped[category].push(cost);
    }
  });
  
  return grouped;
}

export default function CostManagement() {
  const { user } = useAuth();
  const { toast } = useToast();
  const [isAddDialogOpen, setIsAddDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const [editingCost, setEditingCost] = useState<Cost | null>(null);
  const [filterItemId, setFilterItemId] = useState<string>('');

  const { data: costs, isLoading: costsLoading } = useQuery<Cost[]>({
    queryKey: ["/api/costs"]
  });

  const { data: items } = useQuery<Item[]>({
    queryKey: ["/api/items"]
  });

  // Create form
  const createForm = useForm<z.infer<typeof createCostFormSchema>>({
    resolver: zodResolver(createCostFormSchema),
    defaultValues: {
      itemId: 0,
      costPerUom: 0,
      currency: 'EUR',
      effectiveFrom: new Date().toISOString().split('T')[0]
    }
  });

  // Update form
  const updateForm = useForm<z.infer<typeof updateCostFormSchema>>({
    resolver: zodResolver(updateCostFormSchema),
    defaultValues: {
      costPerUom: 0,
      currency: 'EUR',
      effectiveFrom: ''
    }
  });

  const createMutation = useMutation({
    mutationFn: async (data: z.infer<typeof createCostFormSchema>) => {
      return await apiRequest("POST", "/api/costs", {
        itemId: data.itemId,
        costPerUom: data.costPerUom.toString(),
        currency: data.currency,
        effectiveFrom: data.effectiveFrom
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/costs"] });
      toast({
        title: "Cost Added",
        description: "The cost has been added successfully"
      });
      setIsAddDialogOpen(false);
      createForm.reset();
    },
    onError: (error: any) => {
      toast({
        title: "Failed to Add Cost",
        description: error.message || "An error occurred",
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: { id: string; costPerUom: number; currency: string; effectiveFrom: string }) => {
      return await apiRequest("PUT", `/api/costs/${data.id}`, {
        costPerUom: data.costPerUom.toString(),
        currency: data.currency,
        effectiveFrom: data.effectiveFrom
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/costs"] });
      toast({
        title: "Cost Updated",
        description: "The cost has been updated successfully"
      });
      setIsEditDialogOpen(false);
      setEditingCost(null);
    },
    onError: (error: any) => {
      toast({
        title: "Failed to Update Cost",
        description: error.message || "An error occurred",
        variant: "destructive"
      });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return await apiRequest("DELETE", `/api/costs/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/costs"] });
      toast({
        title: "Cost Deleted",
        description: "The cost has been deleted successfully"
      });
    },
    onError: (error: any) => {
      toast({
        title: "Failed to Delete Cost",
        description: error.message || "An error occurred",
        variant: "destructive"
      });
    }
  });

  const onCreateSubmit = (data: z.infer<typeof createCostFormSchema>) => {
    createMutation.mutate(data);
  };

  const onUpdateSubmit = (data: z.infer<typeof updateCostFormSchema>) => {
    if (!editingCost) return;
    updateMutation.mutate({
      id: editingCost.id,
      ...data
    });
  };

  const handleDelete = (id: string) => {
    if (confirm('Are you sure you want to delete this cost?')) {
      deleteMutation.mutate(id);
    }
  };

  const handleEdit = (cost: Cost) => {
    setEditingCost(cost);
    updateForm.reset({
      costPerUom: parseFloat(cost.costPerUom),
      currency: cost.currency,
      effectiveFrom: cost.effectiveFrom.split('T')[0]
    });
    setIsEditDialogOpen(true);
  };

  if (!user || user.role !== 'OWNER') {
    return (
      <div className="min-h-screen bg-gray-50 dark:bg-gray-900 flex items-center justify-center">
        <Card>
          <CardContent className="pt-6">
            <p className="text-muted-foreground">Access denied. This page is only available to administrators.</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  // Enrich costs with item data
  const itemsMap = new Map(items?.map(item => [item.id, item]) || []);
  const enrichedCosts: CostWithItem[] = (costs || []).map(cost => ({
    ...cost,
    item: itemsMap.get(cost.itemId)
  }));

  // Filter costs if filter is active
  const filteredCosts = filterItemId
    ? enrichedCosts.filter(cost => cost.itemId === parseInt(filterItemId))
    : enrichedCosts;

  // Sort by effective date (newest first)
  filteredCosts.sort((a, b) => new Date(b.effectiveFrom).getTime() - new Date(a.effectiveFrom).getTime());

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="max-w-6xl mx-auto p-4 pb-40 sm:pb-32">
        {/* Header */}
        <div className="mb-6">
          <Link href="/admin">
            <Button variant="ghost" className="mb-4" data-testid="button-back">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Admin
            </Button>
          </Link>
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-semibold mb-2" data-testid="heading-cost-management">
                Cost Management
              </h1>
              <p className="text-muted-foreground">Manage item costs with effective date tracking</p>
            </div>
            <Dialog open={isAddDialogOpen} onOpenChange={setIsAddDialogOpen}>
              <DialogTrigger asChild>
                <Button data-testid="button-add-cost">
                  <Plus className="h-4 w-4 mr-2" />
                  Add Cost
                </Button>
              </DialogTrigger>
              <DialogContent>
                <DialogHeader>
                  <DialogTitle>Add New Cost</DialogTitle>
                </DialogHeader>
                <Form {...createForm}>
                  <form onSubmit={createForm.handleSubmit(onCreateSubmit)} className="space-y-4">
                    <FormField
                      control={createForm.control}
                      name="itemId"
                      render={({ field }) => (
                        <FormItem>
                          <FormLabel>Item</FormLabel>
                          <Select onValueChange={field.onChange} value={field.value?.toString() || ''}>
                            <FormControl>
                              <SelectTrigger data-testid="select-add-item">
                                <SelectValue placeholder="Select an item" />
                              </SelectTrigger>
                            </FormControl>
                            <SelectContent>
                              {items?.map((item) => (
                                <SelectItem key={item.id} value={item.id.toString()}>
                                  {item.defaultName} {item.sku && `(${item.sku})`}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    <FormField
                      control={createForm.control}
                      name="costPerUom"
                      render={({ field }) => (
                        <FormItem>
                          <FormLabel>Cost (€)</FormLabel>
                          <FormControl>
                            <Input
                              type="number"
                              step="0.01"
                              min="0"
                              placeholder="0.00"
                              {...field}
                              data-testid="input-add-cost"
                            />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    <FormField
                      control={createForm.control}
                      name="effectiveFrom"
                      render={({ field }) => (
                        <FormItem>
                          <FormLabel>Effective From</FormLabel>
                          <FormControl>
                            <Input
                              type="date"
                              {...field}
                              data-testid="input-add-effective"
                            />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    <DialogFooter>
                      <Button 
                        type="button" 
                        variant="outline" 
                        onClick={() => setIsAddDialogOpen(false)} 
                        data-testid="button-cancel-add"
                      >
                        Cancel
                      </Button>
                      <Button 
                        type="submit"
                        disabled={createMutation.isPending}
                        data-testid="button-confirm-add"
                      >
                        {createMutation.isPending ? 'Adding...' : 'Add Cost'}
                      </Button>
                    </DialogFooter>
                  </form>
                </Form>
              </DialogContent>
            </Dialog>
          </div>
        </div>

        {/* Filter */}
        <Card className="mb-6">
          <CardContent className="pt-6">
            <div className="flex items-center gap-4">
              <div className="flex-1">
                <label htmlFor="filter-item" className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 block mb-2">
                  Filter by Item
                </label>
                <Select value={filterItemId || "all"} onValueChange={(value) => setFilterItemId(value === "all" ? "" : value)}>
                  <SelectTrigger id="filter-item" data-testid="select-filter-item">
                    <SelectValue placeholder="All items" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All items</SelectItem>
                    {items?.map((item) => (
                      <SelectItem key={item.id} value={item.id.toString()}>
                        {item.defaultName} {item.sku && `(${item.sku})`}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              {filterItemId && (
                <div className="flex items-end">
                  <Button variant="outline" onClick={() => setFilterItemId('')} data-testid="button-clear-filter">
                    Clear Filter
                  </Button>
                </div>
              )}
            </div>
          </CardContent>
        </Card>

        {/* Costs List */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <DollarSign className="h-5 w-5" />
              Cost History
            </CardTitle>
          </CardHeader>
          <CardContent>
            {costsLoading ? (
              <div className="space-y-2">
                {[1, 2, 3, 4, 5].map((i) => (
                  <Skeleton key={i} className="h-20 w-full" />
                ))}
              </div>
            ) : filteredCosts.length === 0 ? (
              <div className="text-center py-12 text-muted-foreground" data-testid="text-no-costs">
                No costs found. Add your first cost to get started.
              </div>
            ) : (
              <Accordion type="multiple" className="w-full">
                {Object.entries(groupCostsByCategory(filteredCosts)).map(([category, categoryCosts]) => {
                  if (categoryCosts.length === 0) return null;
                  
                  return (
                    <AccordionItem key={category} value={category}>
                      <AccordionTrigger className="hover:no-underline">
                        <div className="flex items-center gap-2">
                          <Badge className={categoryColors[category as keyof typeof categoryColors]}>
                            {category}
                          </Badge>
                          <span className="text-sm text-muted-foreground">
                            ({categoryCosts.length} items)
                          </span>
                        </div>
                      </AccordionTrigger>
                      <AccordionContent>
                        <div className="space-y-2 pt-2">
                          {categoryCosts.map((cost) => (
                            <div 
                              key={cost.id}
                              className="flex items-center justify-between p-4 border rounded-lg"
                              data-testid={`cost-item-${cost.id}`}
                            >
                              <div className="flex-1">
                                <div className="flex items-center gap-2 mb-1">
                                  <Package className="h-4 w-4 text-muted-foreground" />
                                  <span className="font-medium" data-testid={`cost-item-name-${cost.id}`}>
                                    {cost.item?.defaultName || `Item ${cost.itemId}`}
                                  </span>
                                  {cost.item?.sku && (
                                    <span className="text-sm text-muted-foreground">({cost.item.sku})</span>
                                  )}
                                </div>
                                <div className="flex items-center gap-4 text-sm text-muted-foreground">
                                  <div className="flex items-center gap-1">
                                    <DollarSign className="h-3 w-3" />
                                    <span className="font-semibold text-foreground">€{parseFloat(cost.costPerUom).toFixed(2)}</span>
                                  </div>
                                  <div className="flex items-center gap-1">
                                    <Calendar className="h-3 w-3" />
                                    <span>Effective from {new Date(cost.effectiveFrom).toLocaleDateString()}</span>
                                  </div>
                                </div>
                              </div>
                              <div className="flex items-center gap-2">
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleEdit(cost)}
                                  data-testid={`button-edit-${cost.id}`}
                                >
                                  <Edit className="h-4 w-4" />
                                </Button>
                                <Button
                                  variant="destructive"
                                  size="sm"
                                  onClick={() => handleDelete(cost.id)}
                                  disabled={deleteMutation.isPending}
                                  data-testid={`button-delete-${cost.id}`}
                                >
                                  <Trash2 className="h-4 w-4" />
                                </Button>
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

        {/* Edit Dialog */}
        {editingCost && (
          <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Edit Cost</DialogTitle>
              </DialogHeader>
              <Form {...updateForm}>
                <form onSubmit={updateForm.handleSubmit(onUpdateSubmit)} className="space-y-4">
                  <div>
                    <label className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 block mb-2">
                      Item
                    </label>
                    <div className="p-2 bg-gray-100 dark:bg-gray-800 rounded">
                      {itemsMap.get(editingCost.itemId)?.defaultName || `Item ${editingCost.itemId}`}
                    </div>
                  </div>
                  <FormField
                    control={updateForm.control}
                    name="costPerUom"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Cost (€)</FormLabel>
                        <FormControl>
                          <Input
                            type="number"
                            step="0.01"
                            min="0"
                            {...field}
                            data-testid="input-edit-cost"
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <FormField
                    control={updateForm.control}
                    name="currency"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Currency</FormLabel>
                        <FormControl>
                          <Input
                            type="text"
                            {...field}
                            data-testid="input-edit-currency"
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <FormField
                    control={updateForm.control}
                    name="effectiveFrom"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Effective From</FormLabel>
                        <FormControl>
                          <Input
                            type="date"
                            {...field}
                            data-testid="input-edit-effective"
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <DialogFooter>
                    <Button 
                      type="button"
                      variant="outline" 
                      onClick={() => setIsEditDialogOpen(false)} 
                      data-testid="button-cancel-edit"
                    >
                      Cancel
                    </Button>
                    <Button 
                      type="submit"
                      disabled={updateMutation.isPending}
                      data-testid="button-confirm-edit"
                    >
                      {updateMutation.isPending ? 'Updating...' : 'Update Cost'}
                    </Button>
                  </DialogFooter>
                </form>
              </Form>
            </DialogContent>
          </Dialog>
        )}
      </div>
    </div>
  );
}
