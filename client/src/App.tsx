import { Switch, Route } from "wouter";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import { AuthProvider } from "@/hooks/use-auth";
import { ProtectedRoute } from "@/lib/protected-route";
import LandingPage from "@/pages/landing-page";
import AuthPage from "@/pages/auth-page";
import AdminDashboard from "@/pages/admin-dashboard";
import ShopSelection from "@/pages/shop-selection";
import InventoryCounting from "@/pages/inventory-counting";
import Approvals from "@/pages/approvals";
import Reports from "@/pages/reports";
import CostManagement from "@/pages/cost-management";
import NotFound from "@/pages/not-found";

function Router() {
  return (
    <Switch>
      <Route path="/" component={LandingPage} />
      <Route path="/auth" component={AuthPage} />
      <ProtectedRoute path="/admin" component={AdminDashboard} />
      <ProtectedRoute path="/shops" component={ShopSelection} />
      <ProtectedRoute path="/approvals" component={Approvals} />
      <ProtectedRoute path="/reports" component={Reports} />
      <ProtectedRoute path="/costs" component={CostManagement} />
      <ProtectedRoute path="/count/:shopId" component={InventoryCounting} />
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <AuthProvider>
        <TooltipProvider>
          <Toaster />
          <Router />
        </TooltipProvider>
      </AuthProvider>
    </QueryClientProvider>
  );
}

export default App;
