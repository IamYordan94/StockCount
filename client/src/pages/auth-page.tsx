import { useState, useEffect } from "react";
import { Link, useLocation, Redirect } from "wouter";
import { useAuth } from "@/hooks/use-auth";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { insertUserSchema } from "@shared/schema";
import { z } from "zod";
import { ArrowLeft, Users, User, Package } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Alert, AlertDescription } from "@/components/ui/alert";

const loginSchema = insertUserSchema.pick({ username: true, password: true });

type LoginData = z.infer<typeof loginSchema>;

export default function AuthPage() {
  const [, setLocation] = useLocation();
  const { user, isLoading, loginMutation } = useAuth();
  const [roleType, setRoleType] = useState<'admin' | 'employee'>('employee');

  // Get role from URL params
  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);
    const role = urlParams.get('role');
    if (role === 'admin') {
      setRoleType('admin');
    } else {
      setRoleType('employee');
    }
  }, []);

  const loginForm = useForm<LoginData>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      username: "",
      password: "",
    },
  });


  // Redirect if already logged in - after all hooks
  if (user) {
    return <Redirect to={user.role === 'EMPLOYEE' ? '/shops' : '/admin'} />;
  }

  if (isLoading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-primary/10 to-accent/20 flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  const onLoginSubmit = (data: LoginData) => {
    loginMutation.mutate(data, {
      onSuccess: () => {
        setLocation(roleType === 'admin' ? '/admin' : '/shops');
      },
    });
  };


  const isAdmin = roleType === 'admin';
  const IconComponent = isAdmin ? Users : User;
  const roleTitle = isAdmin ? 'Admin Access' : 'Employee Access';
  const roleDescription = isAdmin ? 'Administrator credentials' : 'Employee credentials';

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/10 to-accent/20 flex">
      {/* Back Button */}
      <Link href="/" data-testid="button-back">
        <a className="absolute top-4 left-4 w-10 h-10 bg-secondary rounded-lg flex items-center justify-center hover:bg-accent transition-colors z-10">
          <ArrowLeft className="text-secondary-foreground" />
        </a>
      </Link>

      {/* Left Column - Form */}
      <div className="flex-1 flex items-center justify-center p-4">
        <div className="max-w-md w-full">
          <Card className="shadow-lg">
            <CardHeader className="text-center">
              <div className="w-12 h-12 bg-primary rounded-xl flex items-center justify-center mx-auto mb-4">
                <IconComponent className="text-primary-foreground" />
              </div>
              <CardTitle className="text-2xl font-bold">{roleTitle}</CardTitle>
              <CardDescription>
                Enter your {roleDescription}
              </CardDescription>
            </CardHeader>
            
            <CardContent>
              {
                <Form {...loginForm}>
                  <form onSubmit={loginForm.handleSubmit(onLoginSubmit)} className="space-y-4">
                    <FormField
                      control={loginForm.control}
                      name="username"
                      render={({ field }) => (
                        <FormItem>
                          <FormLabel>Username</FormLabel>
                          <FormControl>
                            <Input 
                              placeholder="Enter username" 
                              {...field} 
                              data-testid="input-login-username"
                            />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    
                    <FormField
                      control={loginForm.control}
                      name="password"
                      render={({ field }) => (
                        <FormItem>
                          <FormLabel>Password</FormLabel>
                          <FormControl>
                            <Input 
                              type="password" 
                              placeholder="Enter password" 
                              {...field}
                              data-testid="input-login-password"
                            />
                          </FormControl>
                          <FormMessage />
                        </FormItem>
                      )}
                    />
                    
                    <Button 
                      type="submit" 
                      className="w-full" 
                      disabled={loginMutation.isPending}
                      data-testid="button-login-submit"
                    >
                      {loginMutation.isPending ? 'Signing In...' : 'Sign In'}
                    </Button>
                  </form>
                </Form>
              }

              {/* Error Display */}
              {loginMutation.error && (
                <Alert variant="destructive" className="mt-4">
                  <AlertDescription>
                    {loginMutation.error.message}
                  </AlertDescription>
                </Alert>
              )}
            </CardContent>
          </Card>
        </div>
      </div>

      {/* Right Column - Hero */}
      <div className="hidden lg:flex flex-1 items-center justify-center p-8">
        <div className="max-w-md text-center">
          <div className="w-24 h-24 bg-primary/20 rounded-full flex items-center justify-center mx-auto mb-6">
            <Package className="w-12 h-12 text-primary" />
          </div>
          <h2 className="text-3xl font-bold text-foreground mb-4">
            Stock Intake Platform
          </h2>
          <p className="text-lg text-muted-foreground mb-6">
            Phone-friendly multi-location inventory management with offline autosave and Excel exports
          </p>
          <ul className="text-left space-y-2 text-muted-foreground">
            <li className="flex items-center space-x-2">
              <div className="w-2 h-2 bg-primary rounded-full"></div>
              <span>10 shop locations with role-based access</span>
            </li>
            <li className="flex items-center space-x-2">
              <div className="w-2 h-2 bg-primary rounded-full"></div>
              <span>Offline-capable counting interface</span>
            </li>
            <li className="flex items-center space-x-2">
              <div className="w-2 h-2 bg-primary rounded-full"></div>
              <span>Real-time progress tracking</span>
            </li>
            <li className="flex items-center space-x-2">
              <div className="w-2 h-2 bg-primary rounded-full"></div>
              <span>One-click Excel exports</span>
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
}
