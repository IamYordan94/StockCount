import { Link, Redirect } from "wouter";
import { useAuth } from "@/hooks/use-auth";
import { Package, Users } from "lucide-react";

export default function LandingPage() {
  const { user, isLoading } = useAuth();

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary/10 to-accent/20 flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  // If user is logged in, redirect them automatically based on role
  if (user) {
    // OWNER and SUPERVISOR go to admin dashboard
    if (user.role === 'OWNER' || user.role === 'SUPERVISOR') {
      return <Redirect to="/admin" />;
    }
    // EMPLOYEE goes to shops
    return <Redirect to="/shops" />;
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/10 to-accent/20 flex flex-col items-center justify-center p-4">
      <div className="max-w-md w-full space-y-8">
        {/* Header */}
        <div className="text-center">
          <div className="w-16 h-16 bg-primary rounded-2xl flex items-center justify-center mx-auto mb-4">
            <Package className="text-2xl text-primary-foreground" />
          </div>
          <h1 className="text-3xl font-bold text-foreground">Stock Intake</h1>
          <p className="text-muted-foreground mt-2">Select your access level to continue</p>
        </div>
        
        {/* Role Selection Cards */}
        <div className="space-y-4">
          <Link href="/auth?role=admin" data-testid="button-owner-admin">
            <div className="w-full p-6 bg-card rounded-lg border border-border hover:bg-accent/50 transition-colors text-left group block cursor-pointer">
              <div className="flex items-center space-x-4">
                <div className="w-12 h-12 bg-primary/10 rounded-lg flex items-center justify-center">
                  <Users className="text-primary text-xl" />
                </div>
                <div>
                  <h3 className="font-semibold text-card-foreground group-hover:text-accent-foreground">Owner Admin</h3>
                  <p className="text-sm text-muted-foreground">Full system access</p>
                </div>
              </div>
            </div>
          </Link>
          
          <Link href="/auth?role=employee" data-testid="button-employee-admin">
            <div className="w-full p-6 bg-card rounded-lg border border-border hover:bg-accent/50 transition-colors text-left group block cursor-pointer">
              <div className="flex items-center space-x-4">
                <div className="w-12 h-12 bg-secondary/50 rounded-lg flex items-center justify-center">
                  <Users className="text-secondary-foreground text-xl" />
                </div>
                <div>
                  <h3 className="font-semibold text-card-foreground group-hover:text-accent-foreground">Employee Admin</h3>
                  <p className="text-sm text-muted-foreground">Inventory counting access</p>
                </div>
              </div>
            </div>
          </Link>
        </div>
      </div>
    </div>
  );
}
