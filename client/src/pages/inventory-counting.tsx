import { useState, useEffect } from "react";
import { useAuth } from "@/hooks/use-auth";
import { useQuery, useMutation } from "@tanstack/react-query";
import { useRoute, Link } from "wouter";
import { queryClient } from "@/lib/queryClient";
import { offlineStorage } from "@/lib/offline-storage";
import { 
  ArrowLeft, CloudUpload, Check, Plus, Minus, 
  Utensils, Coffee, IceCream, Tag, ChevronDown, ChevronRight
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Card, CardContent } from "@/components/ui/card";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { useToast } from "@/hooks/use-toast";

interface Item {
  id: number;
  defaultName: string;
  category: 'FOOD' | 'DRINK' | 'ICECREAM' | 'STROMMA';
  unitsPerBox: number;
  customName: string | null;
  packagingUnit: string | null;
  displayOrder: number | null;
}

interface CountLine {
  itemId: number;
  boxes: number;
  singles: number;
}

interface Session {
  id: string;
  name: string;
  status: string;
}

interface Shop {
  id: number;
  name: string;
}

const categoryConfig = {
  ICECREAM: {
    icon: IceCream,
    label: 'Ice Cream',
    color: 'bg-pink-100 text-pink-600',
  },
  DRINK: {
    icon: Coffee,
    label: 'Drink Items',
    color: 'bg-blue-100 text-blue-600',
  },
  FOOD: {
    icon: Utensils,
    label: 'Food Items',
    color: 'bg-orange-100 text-orange-600',
  },
  STROMMA: {
    icon: Tag,
    label: 'Stromma Branded',
    color: 'bg-purple-100 text-purple-600',
  },
};

export default function InventoryCounting() {
  const [, params] = useRoute<{ shopId: string }>("/count/:shopId");
  const { user } = useAuth();
  const { toast } = useToast();
  const [countLines, setCountLines] = useState<CountLine[]>([]);
  const [openCategories, setOpenCategories] = useState<Set<string>>(new Set(['ICECREAM']));
  const [lastSaved, setLastSaved] = useState<Date | null>(null);
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [isSaving, setIsSaving] = useState(false);

  const shopId = params?.shopId ? parseInt(params.shopId) : null;

  const { data: shop, isLoading: shopLoading, error: shopError } = useQuery<Shop>({
    queryKey: ['/api/shops', shopId],
    enabled: !!shopId,
  });


  const { data: items = [] } = useQuery<Item[]>({
    queryKey: ['/api/shops', shopId, 'items'],
    enabled: !!shopId,
  });

  const { data: activeSession } = useQuery<Session>({
    queryKey: ['/api/sessions/active'],
  });

  // Load existing count if available
  const { data: countData } = useQuery<{count: any, countLines: CountLine[]}>({
    queryKey: ['/api/counts', activeSession?.id, shopId],
    queryFn: async () => {
      if (!activeSession || !shopId) throw new Error('Missing session or shop');
      
      const url = `/api/counts?sessionId=${activeSession.id}&shopId=${shopId}`;
      
      const response = await fetch(url, {
        credentials: 'include',
      });
      
      if (!response.ok) {
        if (response.status === 404) {
          return { count: null, countLines: [] };
        }
        throw new Error('Failed to fetch count');
      }
      
      return response.json();
    },
    enabled: !!activeSession && !!shopId && !!user,
  });

  useEffect(() => {
    if (countData?.countLines && items.length > 0) {
      // Ensure all items have count lines, even if zero
      const completeCountLines = items.map(item => {
        const existingLine = countData.countLines.find(line => line.itemId === item.id);
        return existingLine || {
          itemId: item.id,
          boxes: 0,
          singles: 0,
        };
      });
      setCountLines(completeCountLines);
      setIsSubmitted(!!countData.count?.submittedAt);
    } else if (items.length > 0 && (!countData?.countLines || countData.countLines.length === 0)) {
      // Initialize with zeros for all items if no existing count
      const initialCountLines = items.map(item => ({
        itemId: item.id,
        boxes: 0,
        singles: 0,
      }));
      setCountLines(initialCountLines);
    }
  }, [countData, items]);

  // Auto-save functionality with proper serialization
  useEffect(() => {
    if (!activeSession || !shopId || !user || countLines.length === 0 || isSaving) return;

    const autoSave = async () => {
      try {
        await offlineStorage.saveCountDraft(
          activeSession.id,
          shopId,
          user.id,
          countLines
        );
        setLastSaved(new Date());
      } catch (error) {
        console.error('Auto-save failed:', error);
      }
    };

    const timeoutId = setTimeout(autoSave, 3000); // Auto-save after 3 seconds of inactivity
    return () => clearTimeout(timeoutId);
  }, [countLines, activeSession, shopId, user, isSaving]);

  const saveMutation = useMutation({
    mutationFn: async () => {
      if (!activeSession || !shopId) throw new Error('Missing session or shop');
      
      
      setIsSaving(true);
      
      // Pause background sync for this session/shop during manual save
      if (activeSession && shopId) {
        await offlineStorage.pauseSyncForKey(activeSession.id, shopId);
      }
      
      const response = await fetch('/api/counts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          sessionId: activeSession.id,
          shopId,
          countLines,
        }),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Save failed');
      }
      
      return response.json();
    },
    onSuccess: async () => {
      setIsSaving(false);
      setLastSaved(new Date());
      
      // Invalidate query to refetch count data with new ID
      queryClient.invalidateQueries({ queryKey: ['/api/counts', activeSession?.id, shopId] });
      
      // Force sync and resume background sync after successful manual save
      if (activeSession && shopId) {
        await offlineStorage.forceSyncForKey(activeSession.id, shopId);
        await offlineStorage.resumeSyncForKey(activeSession.id, shopId);
      }
      
      toast({
        title: "Saved",
        description: "Count has been saved successfully",
      });
    },
    onError: async () => {
      setIsSaving(false);
      
      // Resume background sync even on error
      if (activeSession && shopId) {
        await offlineStorage.resumeSyncForKey(activeSession.id, shopId);
      }
      
      toast({
        title: "Save failed",
        description: "Unable to save count. Changes saved locally.",
        variant: "destructive",
      });
    },
  });

  const submitMutation = useMutation({
    mutationFn: async (countId: string) => {
      const response = await fetch(`/api/counts/${countId}/submit`, {
        method: 'POST',
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error('Submit failed');
      }
      
      return response.json();
    },
    onSuccess: () => {
      setIsSubmitted(true);
      toast({
        title: "Submitted",
        description: "Count has been submitted successfully",
      });
    },
  });

  const updateCountLine = (itemId: number, field: 'boxes' | 'singles', value: number) => {
    setCountLines(prev => {
      const existing = prev.find(line => line.itemId === itemId);
      const newValue = Math.max(0, value);
      
      if (existing) {
        return prev.map(line =>
          line.itemId === itemId
            ? { ...line, [field]: newValue }
            : line
        );
      } else {
        return [
          ...prev,
          {
            itemId,
            boxes: field === 'boxes' ? newValue : 0,
            singles: field === 'singles' ? newValue : 0,
          },
        ];
      }
    });
  };

  const getCountLine = (itemId: number): CountLine => {
    return countLines.find(line => line.itemId === itemId) || {
      itemId,
      boxes: 0,
      singles: 0,
    };
  };

  const toggleCategory = (category: string) => {
    setOpenCategories(prev => {
      const newSet = new Set(prev);
      if (newSet.has(category)) {
        newSet.delete(category);
      } else {
        newSet.add(category);
      }
      return newSet;
    });
  };

  const getCategoryItems = (category: string) => {
    return items.filter(item => item.category === category);
  };

  const getCategoryTotal = (category: string) => {
    const categoryItems = getCategoryItems(category);
    return categoryItems.reduce((total, item) => {
      const countLine = getCountLine(item.id);
      return total + (countLine.boxes * item.unitsPerBox) + countLine.singles;
    }, 0);
  };

  const getTotalProgress = () => {
    const totalItems = items.length;
    // Only count items that have been actually counted (non-zero values)
    const countedItems = countLines.filter(line => line.boxes > 0 || line.singles > 0).length;
    return totalItems > 0 ? Math.round((countedItems / totalItems) * 100) : 0;
  };

  const getGrandTotal = () => {
    return countLines.reduce((total, line) => {
      const item = items.find(i => i.id === line.itemId);
      return total + (line.boxes * (item?.unitsPerBox || 1)) + line.singles;
    }, 0);
  };

  // Get user's assigned shops to check access
  const { data: userShops = [] } = useQuery<Shop[]>({
    queryKey: ['/api/me/shops'],
    enabled: !!user,
  });

  if (!shopId) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-2">Invalid shop ID</h2>
          <Link href="/shops">
            <a className="text-primary hover:underline">Return to shop selection</a>
          </Link>
        </div>
      </div>
    );
  }

  if (shopLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-2">Loading shop...</h2>
        </div>
      </div>
    );
  }

  if (shopError || !shop) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-2">Shop not found</h2>
          <p className="text-muted-foreground mb-4">
            Error: {shopError?.message || 'Shop data not available'}
          </p>
          <Link href="/shops">
            <a className="text-primary hover:underline">Return to shop selection</a>
          </Link>
        </div>
      </div>
    );
  }

  // Check if user has access to this shop (for employees)
  if (user?.role === 'EMPLOYEE' && !userShops.some(s => s.id === shopId)) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold mb-2">Access denied</h2>
          <p className="text-muted-foreground mb-4">
            You don't have access to this shop
          </p>
          <Link href="/shops">
            <a className="text-primary hover:underline">Return to shop selection</a>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pb-48 md:pb-40">
      {/* Header */}
      <header className="bg-card border-b border-border sticky top-0 z-10">
        <div className="max-w-md mx-auto px-4">
          <div className="flex items-center justify-between h-16">
            <Link href="/shops">
              <a className="w-10 h-10 bg-secondary rounded-lg flex items-center justify-center" data-testid="button-back">
                <ArrowLeft className="text-secondary-foreground" />
              </a>
            </Link>
            <div className="text-center">
              <h1 className="font-semibold" data-testid="text-shop-name">{shop.name}</h1>
              <p className="text-xs text-muted-foreground">Inventory Count</p>
            </div>
            <div className="flex items-center space-x-2">
              <CloudUpload 
                className={`text-sm ${lastSaved ? 'text-green-500' : 'text-muted-foreground'}`} 
              />
              <span className={`text-xs ${lastSaved ? 'text-green-600' : isSaving ? 'text-orange-600' : 'text-muted-foreground'}`} data-testid="text-save-status">
                {isSaving ? 'Saving...' : lastSaved ? 'Saved' : 'Not saved'}
              </span>
            </div>
          </div>
        </div>
      </header>

      {/* Progress Indicator */}
      <div className="max-w-md mx-auto px-4 py-3">
        <div className="flex justify-between text-sm text-muted-foreground mb-2">
          <span>Progress</span>
          <span data-testid="text-progress">{countLines.filter(line => line.boxes > 0 || line.singles > 0).length}/{items.length} items</span>
        </div>
        <Progress value={getTotalProgress()} className="w-full" />
      </div>

      {/* Category Accordions */}
      <div className="max-w-md mx-auto px-4 space-y-3 mb-6">
        {Object.entries(categoryConfig).map(([categoryKey, config]) => {
          const categoryItems = getCategoryItems(categoryKey);
          
          // Only render categories that have items for this shop
          if (categoryItems.length === 0) {
            return null;
          }
          
          const categoryTotal = getCategoryTotal(categoryKey);
          const countedInCategory = categoryItems.filter(item => 
            countLines.some(line => line.itemId === item.id && (line.boxes > 0 || line.singles > 0))
          ).length;
          const isOpen = openCategories.has(categoryKey);
          const IconComponent = config.icon;

          return (
            <Card key={categoryKey} className="overflow-hidden" data-testid={`category-${categoryKey}`}>
              <Collapsible open={isOpen} onOpenChange={() => toggleCategory(categoryKey)}>
                <CollapsibleTrigger asChild>
                  <Button 
                    variant="ghost" 
                    className="w-full p-2 sm:p-3 justify-between hover:bg-accent"
                    data-testid={`button-category-${categoryKey}`}
                  >
                    <div className="flex items-center space-x-2 sm:space-x-3">
                      <div className={`w-7 h-7 sm:w-8 sm:h-8 rounded-lg flex items-center justify-center ${config.color}`}>
                        <IconComponent className="w-3.5 h-3.5 sm:w-4 sm:h-4" />
                      </div>
                      <div className="text-left">
                        <h3 className="font-medium text-sm sm:text-base">{config.label}</h3>
                        <p className="text-xs sm:text-sm text-muted-foreground">
                          {countedInCategory}/{categoryItems.length} counted
                        </p>
                      </div>
                    </div>
                    <div className="flex items-center space-x-1 sm:space-x-2">
                      <span className="text-xs sm:text-sm text-muted-foreground" data-testid={`text-category-total-${categoryKey}`}>
                        {categoryTotal} units
                      </span>
                      {isOpen ? (
                        <ChevronDown className="text-muted-foreground w-3.5 h-3.5 sm:w-4 sm:h-4" />
                      ) : (
                        <ChevronRight className="text-muted-foreground w-3.5 h-3.5 sm:w-4 sm:h-4" />
                      )}
                    </div>
                  </Button>
                </CollapsibleTrigger>
                
                <CollapsibleContent>
                  <div className="border-t border-border pb-2">
                    {categoryItems.map((item) => {
                      const countLine = getCountLine(item.id);
                      const totalUnits = (countLine.boxes * item.unitsPerBox) + countLine.singles;
                      
                      return (
                        <div key={item.id} className="p-2 sm:p-3 border-b border-border last:border-b-0" data-testid={`item-${item.id}`}>
                          {/* Item Header */}
                          <div className="mb-2">
                            <h4 className="font-medium text-sm leading-tight" data-testid={`text-item-name-${item.id}`}>
                              {item.customName || item.defaultName}
                            </h4>
                            <p className="text-xs text-muted-foreground" data-testid={`text-item-units-${item.id}`}>
                              {item.packagingUnit || `${item.unitsPerBox} units per box`}
                            </p>
                          </div>
                          
                          {/* Counter Controls - Optimized for Mobile */}
                          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 sm:gap-4">
                            {/* Boxes */}
                            <div className="flex items-center gap-1 flex-1">
                              <span className="text-[10px] sm:text-xs text-muted-foreground w-9 sm:w-10 shrink-0">Boxes</span>
                              <Button
                                variant="outline"
                                className="!h-11 !w-11 sm:!h-12 sm:!w-12 p-0 touch-manipulation !min-h-[44px] !min-w-[44px] sm:!min-h-[48px] sm:!min-w-[48px]"
                                onClick={() => updateCountLine(item.id, 'boxes', countLine.boxes - 1)}
                                disabled={isSubmitted}
                                data-testid={`button-decrement-boxes-${item.id}`}
                              >
                                <Minus className="w-4 h-4" />
                              </Button>
                              <Input
                                type="number"
                                inputMode="numeric"
                                pattern="[0-9]*"
                                value={countLine.boxes}
                                onChange={(e) => updateCountLine(item.id, 'boxes', parseInt(e.target.value) || 0)}
                                className="w-12 sm:w-14 !h-11 sm:!h-12 text-center text-base font-semibold touch-manipulation !min-h-[44px] sm:!min-h-[48px]"
                                disabled={isSubmitted}
                                data-testid={`input-boxes-${item.id}`}
                              />
                              <Button
                                variant="outline"
                                className="!h-11 !w-11 sm:!h-12 sm:!w-12 p-0 touch-manipulation !min-h-[44px] !min-w-[44px] sm:!min-h-[48px] sm:!min-w-[48px]"
                                onClick={() => updateCountLine(item.id, 'boxes', countLine.boxes + 1)}
                                disabled={isSubmitted}
                                data-testid={`button-increment-boxes-${item.id}`}
                              >
                                <Plus className="w-4 h-4" />
                              </Button>
                            </div>
                            
                            {/* Singles */}
                            <div className="flex items-center gap-1 flex-1">
                              <span className="text-[10px] sm:text-xs text-muted-foreground w-9 sm:w-10 shrink-0">Singles</span>
                              <Button
                                variant="outline"
                                className="!h-11 !w-11 sm:!h-12 sm:!w-12 p-0 touch-manipulation !min-h-[44px] !min-w-[44px] sm:!min-h-[48px] sm:!min-w-[48px]"
                                onClick={() => updateCountLine(item.id, 'singles', countLine.singles - 1)}
                                disabled={isSubmitted}
                                data-testid={`button-decrement-singles-${item.id}`}
                              >
                                <Minus className="w-4 h-4" />
                              </Button>
                              <Input
                                type="number"
                                inputMode="numeric"
                                pattern="[0-9]*"
                                value={countLine.singles}
                                onChange={(e) => updateCountLine(item.id, 'singles', parseInt(e.target.value) || 0)}
                                className="w-12 sm:w-14 !h-11 sm:!h-12 text-center text-base font-semibold touch-manipulation !min-h-[44px] sm:!min-h-[48px]"
                                disabled={isSubmitted}
                                data-testid={`input-singles-${item.id}`}
                              />
                              <Button
                                variant="outline"
                                className="!h-11 !w-11 sm:!h-12 sm:!w-12 p-0 touch-manipulation !min-h-[44px] !min-w-[44px] sm:!min-h-[48px] sm:!min-w-[48px]"
                                onClick={() => updateCountLine(item.id, 'singles', countLine.singles + 1)}
                                disabled={isSubmitted}
                                data-testid={`button-increment-singles-${item.id}`}
                              >
                                <Plus className="w-4 h-4" />
                              </Button>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </CollapsibleContent>
              </Collapsible>
            </Card>
          );
        })}
      </div>

      {/* Sticky Footer */}
      <div className="fixed bottom-0 left-0 right-0 bg-card border-t border-border shadow-lg">
        <div className="max-w-md mx-auto p-4 sm:p-3 space-y-3 sm:space-y-2">
          {/* Status and Totals */}
          <div className="flex justify-between items-center text-sm">
            <div className="flex items-center space-x-2">
              <div className={`w-2 h-2 rounded-full ${lastSaved ? 'bg-green-500' : 'bg-yellow-500'}`}></div>
              <span className={`text-xs sm:text-sm ${lastSaved ? 'text-green-600' : 'text-yellow-600'}`}>
                {lastSaved ? 'Auto-saved' : 'Saving...'}
              </span>
            </div>
            <div className="text-right">
              <p className="text-xs text-muted-foreground">Total Items</p>
              <p className="font-bold text-base sm:text-lg" data-testid="text-grand-total">{getGrandTotal()} units</p>
            </div>
          </div>
          
          {/* Submit Button */}
          {isSubmitted ? (
            <div className="w-full py-3 sm:py-2.5 bg-green-100 text-green-800 rounded-lg text-center font-medium" data-testid="text-submitted">
              <Check className="w-4 h-4 inline mr-2" />
              Count Submitted
            </div>
          ) : (
            <>
              <Button
                onClick={() => saveMutation.mutate()}
                className="w-full !h-12 text-base touch-manipulation !min-h-[48px]"
                variant="outline"
                disabled={saveMutation.isPending || countLines.length === 0}
                data-testid="button-save"
              >
                {saveMutation.isPending ? 'Saving...' : 'Save Count'}
              </Button>
              
              <Button
                onClick={() => {
                  if (countData?.count?.id) {
                    submitMutation.mutate(countData.count.id);
                  }
                }}
                className="w-full !h-12 text-base touch-manipulation !min-h-[48px]"
                disabled={submitMutation.isPending || countLines.length === 0 || !countData?.count?.id}
                data-testid="button-submit"
              >
                <Check className="w-4 h-4 mr-2" />
                {submitMutation.isPending ? 'Submitting...' : 'Submit Count'}
              </Button>
            </>
          )}
          
          {/* Note for submission */}
          <p className="text-xs text-muted-foreground text-center leading-relaxed">
            Count will be locked after submission. Admin can reopen if needed.
          </p>
        </div>
      </div>
    </div>
  );
}
