import { useState } from "react";
import { useQuery, useMutation } from "@tanstack/react-query";
import { queryClient, apiRequest } from "@/lib/queryClient";
import { useAuth } from "@/hooks/use-auth";
import { Link } from "wouter";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";
import {
  ArrowLeft,
  Download,
  Lock,
  TrendingUp,
  TrendingDown,
  AlertCircle,
  AlertTriangle,
  Info,
  BarChart3,
  Calendar,
  DollarSign
} from "lucide-react";

interface VarianceReport {
  summary: {
    totalCounts: number;
    totalVarianceLines: number;
    criticalVariances: number;
    warnVariances: number;
    infoVariances: number;
    totalVarianceCost: number;
  };
  variances: Array<{
    id: number;
    countId: number;
    shopId: number;
    shopName: string;
    itemId: number;
    itemName: string;
    itemSku: string;
    boxes: number;
    singles: number;
    countedQty: number;
    expectedQty: number | null;
    varianceQty: number | null;
    varianceCost: number | null;
    varianceSeverity: string | null;
    note: string | null;
    createdAt: string;
  }>;
  dateRange: {
    start: string;
    end: string;
  };
  shops: Array<{
    id: number;
    name: string;
  }>;
}

export default function Reports() {
  const { user } = useAuth();
  const { toast } = useToast();
  const [dateRange, setDateRange] = useState({
    startDate: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    endDate: new Date().toISOString().split('T')[0]
  });
  const [lockPeriod, setLockPeriod] = useState({
    shopId: '',
    startDate: '',
    endDate: ''
  });

  const { data: varianceReport, isLoading } = useQuery<VarianceReport>({
    queryKey: ["/api/reports/variance", { 
      startDate: dateRange.startDate, 
      endDate: dateRange.endDate 
    }]
  });

  const exportMutation = useMutation({
    mutationFn: async () => {
      const params = new URLSearchParams({
        startDate: dateRange.startDate,
        endDate: dateRange.endDate
      });
      
      const response = await fetch(`/api/exports/consolidated.xlsx?${params}`, {
        credentials: 'include'
      });
      
      if (!response.ok) {
        throw new Error('Export failed');
      }
      
      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `consolidated-report-${dateRange.startDate}-${dateRange.endDate}.xlsx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    },
    onSuccess: () => {
      toast({
        title: "Export Started",
        description: "Your report is downloading..."
      });
    },
    onError: () => {
      toast({
        title: "Export Failed",
        description: "Failed to generate export",
        variant: "destructive"
      });
    }
  });

  const lockPeriodMutation = useMutation({
    mutationFn: async (data: { shopId: number; startDate: string; endDate: string }) => {
      return await apiRequest("POST", "/api/periods/lock", data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/reports/variance"] });
      toast({
        title: "Period Locked",
        description: "The period has been locked successfully"
      });
      setLockPeriod({ shopId: '', startDate: '', endDate: '' });
    },
    onError: (error: any) => {
      toast({
        title: "Lock Failed",
        description: error.message || "Failed to lock period",
        variant: "destructive"
      });
    }
  });

  const handleExport = () => {
    exportMutation.mutate();
  };

  const handleLockPeriod = () => {
    if (!lockPeriod.shopId || !lockPeriod.startDate || !lockPeriod.endDate) {
      toast({
        title: "Invalid Input",
        description: "Please fill in all fields",
        variant: "destructive"
      });
      return;
    }

    lockPeriodMutation.mutate({
      shopId: parseInt(lockPeriod.shopId),
      startDate: lockPeriod.startDate,
      endDate: lockPeriod.endDate
    });
  };

  if (!user) {
    return <div></div>;
  }

  const isAdmin = user.role === 'OWNER';
  const topVariances = varianceReport?.variances.slice(0, 10) || [];

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="max-w-6xl mx-auto p-4 pb-40 sm:pb-32">
        {/* Header */}
        <div className="mb-6">
          <Link href="/shops">
            <Button variant="ghost" className="mb-4" data-testid="button-back">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Shops
            </Button>
          </Link>
          <h1 className="text-2xl font-semibold mb-2" data-testid="heading-reports">Reports Dashboard</h1>
          <p className="text-muted-foreground">Variance analysis and data exports</p>
        </div>

        {/* Date Range Filter */}
        <Card className="mb-6">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Calendar className="h-5 w-5" />
              Date Range
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
              <div>
                <Label htmlFor="start-date">Start Date</Label>
                <Input
                  id="start-date"
                  type="date"
                  value={dateRange.startDate}
                  onChange={(e) => setDateRange({ ...dateRange, startDate: e.target.value })}
                  data-testid="input-start-date"
                />
              </div>
              <div>
                <Label htmlFor="end-date">End Date</Label>
                <Input
                  id="end-date"
                  type="date"
                  value={dateRange.endDate}
                  onChange={(e) => setDateRange({ ...dateRange, endDate: e.target.value })}
                  data-testid="input-end-date"
                />
              </div>
              <div className="flex items-end">
                <Button 
                  onClick={() => queryClient.invalidateQueries({ queryKey: ["/api/reports/variance"] })}
                  className="w-full"
                  data-testid="button-refresh-report"
                >
                  <BarChart3 className="h-4 w-4 mr-2" />
                  Refresh Report
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Summary Cards */}
        {isLoading ? (
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
            {[1, 2, 3, 4].map((i) => (
              <Card key={i}>
                <CardContent className="pt-6">
                  <Skeleton className="h-12 w-full" />
                </CardContent>
              </Card>
            ))}
          </div>
        ) : varianceReport ? (
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
            <Card data-testid="card-total-counts">
              <CardContent className="pt-6">
                <div className="text-2xl font-bold">{varianceReport.summary.totalCounts}</div>
                <p className="text-xs text-muted-foreground">Total Counts</p>
              </CardContent>
            </Card>
            <Card data-testid="card-critical-variances">
              <CardContent className="pt-6">
                <div className="flex items-center gap-2">
                  <AlertCircle className="h-5 w-5 text-red-500" />
                  <div className="text-2xl font-bold text-red-600">
                    {varianceReport.summary.criticalVariances}
                  </div>
                </div>
                <p className="text-xs text-muted-foreground">Critical Variances</p>
              </CardContent>
            </Card>
            <Card data-testid="card-warn-variances">
              <CardContent className="pt-6">
                <div className="flex items-center gap-2">
                  <AlertTriangle className="h-5 w-5 text-yellow-500" />
                  <div className="text-2xl font-bold text-yellow-600">
                    {varianceReport.summary.warnVariances}
                  </div>
                </div>
                <p className="text-xs text-muted-foreground">Warning Variances</p>
              </CardContent>
            </Card>
            <Card data-testid="card-variance-cost">
              <CardContent className="pt-6">
                <div className="flex items-center gap-2">
                  {varianceReport.summary.totalVarianceCost > 0 ? (
                    <TrendingUp className="h-5 w-5 text-red-500" />
                  ) : (
                    <TrendingDown className="h-5 w-5 text-green-500" />
                  )}
                  <div className={`text-2xl font-bold ${
                    varianceReport.summary.totalVarianceCost > 0 ? 'text-red-600' : 'text-green-600'
                  }`}>
                    ${Math.abs(varianceReport.summary.totalVarianceCost).toFixed(2)}
                  </div>
                </div>
                <p className="text-xs text-muted-foreground">Total Variance Cost</p>
              </CardContent>
            </Card>
          </div>
        ) : null}

        {/* Export Button */}
        <Card className="mb-6">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Download className="h-5 w-5" />
              Export Data
            </CardTitle>
          </CardHeader>
          <CardContent>
            <Button 
              onClick={handleExport}
              disabled={exportMutation.isPending}
              className="w-full sm:w-auto"
              data-testid="button-export"
            >
              <Download className="h-4 w-4 mr-2" />
              {exportMutation.isPending ? 'Generating...' : 'Download Consolidated Report (Excel)'}
            </Button>
            <p className="text-sm text-muted-foreground mt-2">
              Includes 4 sheets: Inventory Snapshot, Variances, Wastage, and Audit Trail
            </p>
          </CardContent>
        </Card>

        {/* Variance Leaderboard */}
        <Card className="mb-6">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <BarChart3 className="h-5 w-5" />
              Top 10 Variances
            </CardTitle>
          </CardHeader>
          <CardContent>
            {isLoading ? (
              <div className="space-y-2">
                {[1, 2, 3, 4, 5].map((i) => (
                  <Skeleton key={i} className="h-16 w-full" />
                ))}
              </div>
            ) : topVariances.length === 0 ? (
              <div className="text-center py-8 text-muted-foreground" data-testid="text-no-variances">
                No variances found for the selected date range
              </div>
            ) : (
              <div className="space-y-2">
                {topVariances.map((variance, index) => (
                  <div 
                    key={variance.id} 
                    className="flex items-center gap-4 p-4 border rounded-lg"
                    data-testid={`variance-item-${index}`}
                  >
                    <div className="flex items-center justify-center w-8 h-8 rounded-full bg-gray-100 dark:bg-gray-800 font-semibold text-sm">
                      {index + 1}
                    </div>
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <span className="font-medium" data-testid={`variance-item-name-${index}`}>
                          {variance.itemName}
                        </span>
                        {variance.varianceSeverity === 'CRITICAL' && (
                          <Badge variant="destructive">Critical</Badge>
                        )}
                        {variance.varianceSeverity === 'WARN' && (
                          <Badge variant="outline" className="border-yellow-500 text-yellow-700">Warning</Badge>
                        )}
                        {variance.varianceSeverity === 'INFO' && (
                          <Badge variant="outline" className="border-blue-500 text-blue-700">Info</Badge>
                        )}
                      </div>
                      <div className="text-sm text-muted-foreground">
                        {variance.shopName} • SKU: {variance.itemSku}
                      </div>
                    </div>
                    <div className="text-right">
                      <div className={`font-semibold ${
                        (variance.varianceCost || 0) > 0 ? 'text-red-600' : 'text-green-600'
                      }`}>
                        ${Math.abs(variance.varianceCost || 0).toFixed(2)}
                      </div>
                      <div className="text-sm text-muted-foreground">
                        {variance.varianceQty !== null && (
                          <span>
                            {variance.varianceQty > 0 ? '+' : ''}{variance.varianceQty.toFixed(2)} units
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Period Lock Controls (Admin Only) */}
        {isAdmin && (
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Lock className="h-5 w-5" />
                Period Lock Controls
              </CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm text-muted-foreground mb-4">
                Lock a period to prevent modifications to counts within that date range
              </p>
              <div className="grid grid-cols-1 sm:grid-cols-4 gap-4">
                <div>
                  <Label htmlFor="lock-shop">Shop ID</Label>
                  <Input
                    id="lock-shop"
                    type="number"
                    min="1"
                    max="10"
                    placeholder="1-10"
                    value={lockPeriod.shopId}
                    onChange={(e) => setLockPeriod({ ...lockPeriod, shopId: e.target.value })}
                    data-testid="input-lock-shop"
                  />
                </div>
                <div>
                  <Label htmlFor="lock-start">Start Date</Label>
                  <Input
                    id="lock-start"
                    type="date"
                    value={lockPeriod.startDate}
                    onChange={(e) => setLockPeriod({ ...lockPeriod, startDate: e.target.value })}
                    data-testid="input-lock-start"
                  />
                </div>
                <div>
                  <Label htmlFor="lock-end">End Date</Label>
                  <Input
                    id="lock-end"
                    type="date"
                    value={lockPeriod.endDate}
                    onChange={(e) => setLockPeriod({ ...lockPeriod, endDate: e.target.value })}
                    data-testid="input-lock-end"
                  />
                </div>
                <div className="flex items-end">
                  <Button 
                    onClick={handleLockPeriod}
                    disabled={lockPeriodMutation.isPending}
                    className="w-full"
                    data-testid="button-lock-period"
                  >
                    <Lock className="h-4 w-4 mr-2" />
                    {lockPeriodMutation.isPending ? 'Locking...' : 'Lock Period'}
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
}
