import { useAuth } from "@/hooks/use-auth";
import { useQuery } from "@tanstack/react-query";
import { Redirect, Link } from "wouter";
import { Box, LogOut, ArrowRight } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

interface Shop {
  id: number;
  name: string;
  active: boolean;
  progress?: number;
  status?: 'NOT_STARTED' | 'IN_PROGRESS' | 'SUBMITTED';
  countedItems?: number;
  totalItems?: number;
  lastUpdated?: string | null;
  submittedAt?: string | null;
}

interface Session {
  id: string;
  name: string;
  status: string;
  createdAt: string;
}

export default function ShopSelection() {
  const { user, logoutMutation } = useAuth();

  if (!user || user.role !== 'EMPLOYEE') {
    return <Redirect to="/" />;
  }

  const { data: assignedShops = [], isLoading: shopsLoading } = useQuery<Shop[]>({
    queryKey: ['/api/me/shops'],
  });

  const { data: activeSession } = useQuery<Session>({
    queryKey: ['/api/sessions/active'],
  });

  const handleLogout = () => {
    logoutMutation.mutate();
  };

  if (shopsLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="bg-card border-b border-border sticky top-0 z-10">
        <div className="max-w-md mx-auto px-4 flex items-center justify-between h-16">
          <div className="flex items-center space-x-3">
            <div className="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
              <Box className="text-primary-foreground text-sm" />
            </div>
            <div>
              <h1 className="font-semibold" data-testid="text-shop-selection-title">Select Shop</h1>
              <p className="text-xs text-muted-foreground" data-testid="text-welcome-user">
                Welcome, {user.name}
              </p>
            </div>
          </div>
          <Button 
            variant="ghost" 
            size="sm"
            onClick={handleLogout} 
            className="text-muted-foreground hover:text-foreground"
            data-testid="button-logout"
          >
            <LogOut className="w-4 h-4" />
          </Button>
        </div>
      </header>

      {/* Session Info */}
      <div className="max-w-md mx-auto p-4">
        {activeSession ? (
          <div className="bg-primary/10 border border-primary/20 rounded-lg p-4 mb-6" data-testid="card-active-session">
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 bg-green-500 rounded-full"></div>
              <div>
                <p className="font-medium text-primary">Active Session</p>
                <p className="text-sm text-primary/80" data-testid="text-session-name">
                  {activeSession.name}
                </p>
              </div>
            </div>
          </div>
        ) : (
          <div className="bg-destructive/10 border border-destructive/20 rounded-lg p-4 mb-6" data-testid="card-no-session">
            <div className="flex items-center space-x-2">
              <div className="w-3 h-3 bg-destructive rounded-full"></div>
              <div>
                <p className="font-medium text-destructive">No Active Session</p>
                <p className="text-sm text-destructive/80">
                  Contact admin to start an inventory session
                </p>
              </div>
            </div>
          </div>
        )}

        {/* Shop Cards */}
        <div className="space-y-4">
          {assignedShops.length === 0 ? (
            <div className="text-center py-8" data-testid="text-no-shops">
              <div className="w-16 h-16 bg-muted rounded-full flex items-center justify-center mx-auto mb-4">
                <Box className="w-8 h-8 text-muted-foreground" />
              </div>
              <h3 className="text-lg font-medium text-foreground mb-2">No Shops Assigned</h3>
              <p className="text-muted-foreground">
                Contact your administrator to be assigned to shops for inventory counting.
              </p>
            </div>
          ) : (
            assignedShops.map((shop) => {
              const progress = shop.progress || 0;
              const status: 'COMPLETE' | 'IN PROGRESS' | 'NOT STARTED' = 
                shop.status === 'SUBMITTED' ? 'COMPLETE' : 
                shop.status === 'IN_PROGRESS' ? 'IN PROGRESS' : 
                'NOT STARTED';
              const countedItems = shop.countedItems || 0;
              const totalItems = shop.totalItems || 0;
              
              return (
                <Link key={shop.id} href={`/count/${shop.id}`} data-testid={`link-shop-${shop.id}`}>
                  <a>
                    <Card className="hover:bg-accent transition-colors">
                      <CardContent className="p-4">
                        <div className="flex items-center justify-between mb-2">
                          <h3 className="font-semibold" data-testid={`text-shop-name-${shop.id}`}>
                            {shop.name}
                          </h3>
                          <div className="flex items-center space-x-2">
                            <Badge 
                              variant={
                                status === 'COMPLETE' ? 'default' : 
                                status === 'IN PROGRESS' ? 'secondary' : 
                                'outline'
                              }
                              data-testid={`badge-shop-status-${shop.id}`}
                            >
                              {status}
                            </Badge>
                            <ArrowRight className="w-4 h-4 text-muted-foreground" />
                          </div>
                        </div>
                        
                        <div className="space-y-2">
                          <div className="flex justify-between text-sm text-muted-foreground">
                            <span>Progress</span>
                            <span data-testid={`text-shop-progress-${shop.id}`}>
                              {progress}% ({countedItems}/{totalItems})
                            </span>
                          </div>
                          <Progress value={progress} className="w-full" />
                          <p className="text-xs text-muted-foreground" data-testid={`text-shop-status-${shop.id}`}>
                            {status === 'COMPLETE' 
                              ? 'Completed and submitted'
                              : status === 'IN PROGRESS' 
                              ? 'Draft saved, continue counting'
                              : 'Ready to start counting'
                            }
                          </p>
                        </div>
                      </CardContent>
                    </Card>
                  </a>
                </Link>
              );
            })
          )}
        </div>

        {!activeSession && assignedShops.length > 0 && (
          <div className="mt-6 p-4 bg-muted rounded-lg text-center" data-testid="text-session-required">
            <p className="text-sm text-muted-foreground">
              An active inventory session is required to start counting.
              Please wait for an administrator to create a new session.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
