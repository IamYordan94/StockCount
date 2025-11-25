import { useState } from "react";
import { useQuery, useMutation } from "@tanstack/react-query";
import { queryClient, apiRequest } from "@/lib/queryClient";
import { useAuth } from "@/hooks/use-auth";
import { Link } from "wouter";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Alert, AlertTitle, AlertDescription } from "@/components/ui/alert";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Collapsible, CollapsibleTrigger, CollapsibleContent } from "@/components/ui/collapsible";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import {
  CheckCircle,
  XCircle,
  AlertCircle,
  ChevronDown,
  ChevronUp,
  ArrowLeft,
  AlertTriangle,
  Info,
  Package,
  Calendar,
  User,
  TrendingUp,
  TrendingDown
} from "lucide-react";

type CountStatus = "DRAFT" | "SUBMITTED" | "APPROVED" | "REJECTED";

interface CountData {
  id: number;
  shopId: number;
  shopName: string;
  userId: string;
  userName: string;
  status: CountStatus;
  periodStart: string | null;
  periodEnd: string | null;
  createdAt: string;
  submittedAt: string | null;
  approvedAt: string | null;
  approvedBy: string | null;
  rejectedReason: string | null;
  lines: CountLine[];
}

interface CountLine {
  id: number;
  itemId: number;
  itemName: string;
  itemSku: string;
  category: string;
  boxes: number;
  singles: number;
  note: string | null;
  expectedQty: number | null;
  varianceQty: number | null;
  varianceCost: number | null;
  varianceSeverity: "INFO" | "WARN" | "CRITICAL" | null;
}

function getSeverityColor(severity: string | null): string {
  switch (severity) {
    case "CRITICAL":
      return "bg-red-500";
    case "WARN":
      return "bg-yellow-500";
    case "INFO":
      return "bg-blue-500";
    default:
      return "bg-gray-300";
  }
}

function getSeverityBorderColor(severity: string | null): string {
  switch (severity) {
    case "CRITICAL":
      return "border-l-red-500";
    case "WARN":
      return "border-l-yellow-500";
    case "INFO":
      return "border-l-blue-500";
    default:
      return "";
  }
}

function getSeverityBadge(severity: string | null) {
  switch (severity) {
    case "CRITICAL":
      return <Badge variant="destructive" data-testid="badge-critical">Critical</Badge>;
    case "WARN":
      return <Badge variant="outline" className="border-yellow-500 text-yellow-700" data-testid="badge-warn">Warning</Badge>;
    case "INFO":
      return <Badge variant="outline" className="border-blue-500 text-blue-700" data-testid="badge-info">Info</Badge>;
    default:
      return null;
  }
}

function getSeverityIcon(severity: string | null) {
  switch (severity) {
    case "CRITICAL":
      return <AlertCircle className="h-4 w-4 text-red-500" />;
    case "WARN":
      return <AlertTriangle className="h-4 w-4 text-yellow-500" />;
    case "INFO":
      return <Info className="h-4 w-4 text-blue-500" />;
    default:
      return null;
  }
}

function CountCard({ count, onApprove, onReject, currentUserId }: {
  count: CountData;
  onApprove: (id: number) => void;
  onReject: (id: number, reason: string) => void;
  currentUserId: string;
}) {
  const [isExpanded, setIsExpanded] = useState(false);
  const [rejectReason, setRejectReason] = useState("");
  const [showRejectForm, setShowRejectForm] = useState(false);

  const isSelfCount = count.userId === currentUserId;
  const hasVariances = count.lines.some(line => line.varianceSeverity);
  const criticalCount = count.lines.filter(line => line.varianceSeverity === "CRITICAL").length;
  const warnCount = count.lines.filter(line => line.varianceSeverity === "WARN").length;
  const infoCount = count.lines.filter(line => line.varianceSeverity === "INFO").length;
  const totalVarianceCost = count.lines.reduce((sum, line) => sum + (line.varianceCost || 0), 0);

  const handleApprove = () => {
    if (isSelfCount) {
      alert("You cannot approve your own count");
      return;
    }
    onApprove(count.id);
  };

  const handleReject = () => {
    if (isSelfCount) {
      alert("You cannot reject your own count");
      return;
    }
    if (!rejectReason.trim()) {
      alert("Please provide a reason for rejection");
      return;
    }
    onReject(count.id, rejectReason);
    setShowRejectForm(false);
    setRejectReason("");
  };

  return (
    <Card className="mb-4" data-testid={`card-count-${count.id}`}>
      <CardHeader>
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <CardTitle className="text-xl flex items-center gap-2">
              <Package className="h-5 w-5" />
              {count.shopName}
              {isSelfCount && (
                <Badge variant="secondary" data-testid="badge-self-count">
                  <User className="h-3 w-3 mr-1" />
                  Your Count
                </Badge>
              )}
            </CardTitle>
            <div className="flex flex-col gap-1 mt-2 text-sm text-muted-foreground">
              <div className="flex items-center gap-2">
                <User className="h-4 w-4" />
                <span>Counted by: {count.userName}</span>
              </div>
              {count.periodStart && count.periodEnd && (
                <div className="flex items-center gap-2">
                  <Calendar className="h-4 w-4" />
                  <span>
                    Period: {new Date(count.periodStart).toLocaleDateString()} - {new Date(count.periodEnd).toLocaleDateString()}
                  </span>
                </div>
              )}
              {count.submittedAt && (
                <div className="flex items-center gap-2">
                  <Calendar className="h-4 w-4" />
                  <span>Submitted: {new Date(count.submittedAt).toLocaleString()}</span>
                </div>
              )}
            </div>
          </div>
          <div className="flex flex-col gap-2 items-end">
            <Badge variant={count.status === "SUBMITTED" ? "default" : "secondary"} data-testid={`badge-status-${count.id}`}>
              {count.status}
            </Badge>
          </div>
        </div>

        {/* Variance Summary Heatmap */}
        {hasVariances && (
          <div className="mt-4 p-4 bg-gray-50 dark:bg-gray-800 rounded-lg" data-testid={`variance-summary-${count.id}`}>
            <div className="flex items-center justify-between mb-2">
              <h4 className="font-semibold text-sm">Variance Summary</h4>
              {totalVarianceCost !== 0 && (
                <div className="flex items-center gap-1">
                  {totalVarianceCost > 0 ? (
                    <TrendingUp className="h-4 w-4 text-red-500" />
                  ) : (
                    <TrendingDown className="h-4 w-4 text-green-500" />
                  )}
                  <span className={`font-semibold ${totalVarianceCost > 0 ? 'text-red-600' : 'text-green-600'}`}>
                    ${Math.abs(totalVarianceCost).toFixed(2)}
                  </span>
                </div>
              )}
            </div>
            <div className="flex gap-2">
              {criticalCount > 0 && (
                <div className="flex items-center gap-1 text-sm" data-testid={`count-critical-${count.id}`}>
                  <div className="w-3 h-3 rounded-full bg-red-500"></div>
                  <span>{criticalCount} Critical</span>
                </div>
              )}
              {warnCount > 0 && (
                <div className="flex items-center gap-1 text-sm" data-testid={`count-warn-${count.id}`}>
                  <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
                  <span>{warnCount} Warning</span>
                </div>
              )}
              {infoCount > 0 && (
                <div className="flex items-center gap-1 text-sm" data-testid={`count-info-${count.id}`}>
                  <div className="w-3 h-3 rounded-full bg-blue-500"></div>
                  <span>{infoCount} Info</span>
                </div>
              )}
            </div>
          </div>
        )}
      </CardHeader>

      <CardContent>
        <Collapsible open={isExpanded} onOpenChange={setIsExpanded}>
          <CollapsibleTrigger asChild>
            <Button variant="outline" className="w-full mb-4" data-testid={`button-toggle-details-${count.id}`}>
              {isExpanded ? (
                <>
                  <ChevronUp className="h-4 w-4 mr-2" />
                  Hide Details
                </>
              ) : (
                <>
                  <ChevronDown className="h-4 w-4 mr-2" />
                  Show Details ({count.lines.length} items)
                </>
              )}
            </Button>
          </CollapsibleTrigger>

          <CollapsibleContent>
            <div className="space-y-2 mb-4">
              {count.lines.map((line) => (
                <div
                  key={line.id}
                  className={`p-3 rounded-lg border ${line.varianceSeverity ? 'border-l-4' : ''} ${getSeverityBorderColor(line.varianceSeverity)}`}
                  data-testid={`line-item-${line.id}`}
                >
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <span className="font-medium" data-testid={`text-item-name-${line.id}`}>{line.itemName}</span>
                        {line.varianceSeverity && getSeverityBadge(line.varianceSeverity)}
                      </div>
                      <div className="text-sm text-muted-foreground">SKU: {line.itemSku}</div>
                      <div className="mt-1 text-sm">
                        <span className="font-medium">Counted:</span> {line.boxes} boxes, {line.singles} singles
                      </div>
                      {line.expectedQty !== null && (
                        <div className="text-sm">
                          <span className="font-medium">Expected:</span> {line.expectedQty.toFixed(2)}
                          {line.varianceQty !== null && (
                            <span className={`ml-2 ${(line.varianceQty || 0) > 0 ? 'text-red-600' : 'text-green-600'}`}>
                              ({line.varianceQty > 0 ? '+' : ''}{line.varianceQty.toFixed(2)})
                            </span>
                          )}
                        </div>
                      )}
                      {line.varianceCost !== null && (
                        <div className="text-sm">
                          <span className="font-medium">Cost Impact:</span>
                          <span className={`ml-1 ${line.varianceCost > 0 ? 'text-red-600' : 'text-green-600'}`}>
                            ${Math.abs(line.varianceCost).toFixed(2)} {line.varianceCost > 0 ? 'over' : 'under'}
                          </span>
                        </div>
                      )}
                      {line.note && (
                        <div className="mt-2 p-2 bg-gray-100 dark:bg-gray-700 rounded text-sm" data-testid={`note-${line.id}`}>
                          <span className="font-medium">Note:</span> {line.note}
                        </div>
                      )}
                    </div>
                    {line.varianceSeverity && (
                      <div className="ml-2">
                        {getSeverityIcon(line.varianceSeverity)}
                      </div>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </CollapsibleContent>
        </Collapsible>

        {/* Self-Approval Warning */}
        {isSelfCount && (
          <Alert variant="destructive" className="mb-4" data-testid={`alert-self-approval-${count.id}`}>
            <AlertCircle className="h-4 w-4" />
            <AlertTitle>Self-Approval Prevention</AlertTitle>
            <AlertDescription>
              You cannot approve or reject your own count. Please assign this to another supervisor or admin.
            </AlertDescription>
          </Alert>
        )}

        {/* Action Buttons */}
        {count.status === "SUBMITTED" && (
          <div className="flex gap-2 flex-col sm:flex-row">
            <Button
              onClick={handleApprove}
              disabled={isSelfCount}
              className="flex-1"
              data-testid={`button-approve-${count.id}`}
            >
              <CheckCircle className="h-4 w-4 mr-2" />
              Approve
            </Button>
            {!showRejectForm ? (
              <Button
                onClick={() => setShowRejectForm(true)}
                disabled={isSelfCount}
                variant="destructive"
                className="flex-1"
                data-testid={`button-show-reject-${count.id}`}
              >
                <XCircle className="h-4 w-4 mr-2" />
                Reject
              </Button>
            ) : (
              <div className="flex-1 space-y-2">
                <Textarea
                  placeholder="Reason for rejection..."
                  value={rejectReason}
                  onChange={(e) => setRejectReason(e.target.value)}
                  className="min-h-[80px]"
                  data-testid={`input-reject-reason-${count.id}`}
                />
                <div className="flex gap-2">
                  <Button onClick={handleReject} variant="destructive" data-testid={`button-confirm-reject-${count.id}`}>
                    Confirm Reject
                  </Button>
                  <Button onClick={() => setShowRejectForm(false)} variant="outline" data-testid={`button-cancel-reject-${count.id}`}>
                    Cancel
                  </Button>
                </div>
              </div>
            )}
          </div>
        )}

        {count.status === "REJECTED" && count.rejectedReason && (
          <Alert variant="destructive" data-testid={`alert-rejected-${count.id}`}>
            <XCircle className="h-4 w-4" />
            <AlertTitle>Rejected</AlertTitle>
            <AlertDescription>{count.rejectedReason}</AlertDescription>
          </Alert>
        )}

        {count.status === "APPROVED" && count.approvedAt && (
          <Alert data-testid={`alert-approved-${count.id}`}>
            <CheckCircle className="h-4 w-4" />
            <AlertTitle>Approved</AlertTitle>
            <AlertDescription>
              Approved on {new Date(count.approvedAt).toLocaleString()}
              {count.approvedBy && ` by user ${count.approvedBy}`}
            </AlertDescription>
          </Alert>
        )}
      </CardContent>
    </Card>
  );
}

export default function Approvals() {
  const { user } = useAuth();
  const { toast } = useToast();
  const [statusFilter, setStatusFilter] = useState<"SUBMITTED" | "APPROVED" | "REJECTED">("SUBMITTED");

  const { data: counts, isLoading } = useQuery<CountData[]>({
    queryKey: ["/api/counts/list", { status: statusFilter }]
  });

  const approveMutation = useMutation({
    mutationFn: async (countId: number) => {
      return await apiRequest("POST", `/api/counts/${countId}/approve`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/counts/list"] });
      toast({
        title: "Count Approved",
        description: "The count has been successfully approved."
      });
    },
    onError: (error: any) => {
      toast({
        title: "Approval Failed",
        description: error.message || "Failed to approve count",
        variant: "destructive"
      });
    }
  });

  const rejectMutation = useMutation({
    mutationFn: async ({ countId, reason }: { countId: number; reason: string }) => {
      return await apiRequest("POST", `/api/counts/${countId}/reject`, { reason });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/counts/list"] });
      toast({
        title: "Count Rejected",
        description: "The count has been rejected."
      });
    },
    onError: (error: any) => {
      toast({
        title: "Rejection Failed",
        description: error.message || "Failed to reject count",
        variant: "destructive"
      });
    }
  });

  if (!user) {
    return <div></div>;
  }

  const filteredCounts = counts?.filter(count => count.status === statusFilter) || [];

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="max-w-4xl mx-auto p-4 pb-40 sm:pb-32">
        {/* Header */}
        <div className="mb-6">
          <Link href="/shops">
            <Button variant="ghost" className="mb-4" data-testid="button-back">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Shops
            </Button>
          </Link>
          <h1 className="text-2xl font-semibold mb-2" data-testid="heading-approvals">Count Approvals</h1>
          <p className="text-muted-foreground">Review and approve submitted inventory counts</p>
        </div>

        {/* Status Tabs */}
        <Tabs value={statusFilter} onValueChange={(v) => setStatusFilter(v as any)} className="mb-6">
          <TabsList className="grid grid-cols-3 w-full" data-testid="tabs-status-filter">
            <TabsTrigger value="SUBMITTED" data-testid="tab-submitted">
              Pending
              {(counts?.filter(c => c.status === "SUBMITTED").length || 0) > 0 && (
                <Badge variant="secondary" className="ml-2">
                  {counts?.filter(c => c.status === "SUBMITTED").length || 0}
                </Badge>
              )}
            </TabsTrigger>
            <TabsTrigger value="APPROVED" data-testid="tab-approved">Approved</TabsTrigger>
            <TabsTrigger value="REJECTED" data-testid="tab-rejected">Rejected</TabsTrigger>
          </TabsList>

          <TabsContent value={statusFilter} className="mt-6">
            {isLoading ? (
              <div className="space-y-4">
                {[1, 2, 3].map((i) => (
                  <Card key={i}>
                    <CardHeader>
                      <Skeleton className="h-6 w-48" />
                      <Skeleton className="h-4 w-64 mt-2" />
                    </CardHeader>
                    <CardContent>
                      <Skeleton className="h-24 w-full" />
                    </CardContent>
                  </Card>
                ))}
              </div>
            ) : filteredCounts.length === 0 ? (
              <Card data-testid="card-empty-state">
                <CardContent className="py-12 text-center">
                  <Package className="h-12 w-12 mx-auto text-gray-400 mb-4" />
                  <h3 className="text-lg font-medium mb-2">No {statusFilter.toLowerCase()} counts</h3>
                  <p className="text-muted-foreground">
                    {statusFilter === "SUBMITTED"
                      ? "There are no pending counts waiting for approval"
                      : `There are no ${statusFilter.toLowerCase()} counts`}
                  </p>
                </CardContent>
              </Card>
            ) : (
              <div className="space-y-4">
                {filteredCounts.map((count) => (
                  <CountCard
                    key={count.id}
                    count={count}
                    onApprove={(id) => approveMutation.mutate(id)}
                    onReject={(id, reason) => rejectMutation.mutate({ countId: id, reason })}
                    currentUserId={user.id}
                  />
                ))}
              </div>
            )}
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
