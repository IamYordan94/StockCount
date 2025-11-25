CREATE TYPE "public"."category" AS ENUM('FOOD', 'DRINK', 'ICECREAM', 'STROMMA');--> statement-breakpoint
CREATE TYPE "public"."session_status" AS ENUM('OPEN', 'CLOSED');--> statement-breakpoint
CREATE TYPE "public"."user_role" AS ENUM('OWNER', 'ENGINEER', 'SUPERVISOR', 'EMPLOYEE');--> statement-breakpoint
CREATE TABLE "count_lines" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"count_id" varchar NOT NULL,
	"item_id" integer NOT NULL,
	"boxes" integer DEFAULT 0 NOT NULL,
	"singles" integer DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "counts" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" varchar NOT NULL,
	"shop_id" integer NOT NULL,
	"user_id" varchar NOT NULL,
	"submitted_at" timestamp,
	"reopen_reason" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "event_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar,
	"action" text NOT NULL,
	"payload" text,
	"timestamp" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "items" (
	"id" integer PRIMARY KEY NOT NULL,
	"default_name" text NOT NULL,
	"category" "category" NOT NULL,
	"units_per_box" integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sessions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"status" "session_status" DEFAULT 'OPEN' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"closed_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "shop_items" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"shop_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"active" boolean DEFAULT true NOT NULL
);
--> statement-breakpoint
CREATE TABLE "shops" (
	"id" integer PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"active" boolean DEFAULT true NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_shops" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"shop_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"username" text NOT NULL,
	"password" text NOT NULL,
	"must_reset_password" boolean DEFAULT true NOT NULL,
	"approved" boolean DEFAULT false NOT NULL,
	"role" "user_role" DEFAULT 'EMPLOYEE' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"last_login_at" timestamp,
	"login_attempts" integer DEFAULT 0 NOT NULL,
	"locked_until" timestamp,
	CONSTRAINT "users_username_unique" UNIQUE("username")
);
--> statement-breakpoint
ALTER TABLE "count_lines" ADD CONSTRAINT "count_lines_count_id_counts_id_fk" FOREIGN KEY ("count_id") REFERENCES "public"."counts"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "count_lines" ADD CONSTRAINT "count_lines_item_id_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "counts" ADD CONSTRAINT "counts_session_id_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "counts" ADD CONSTRAINT "counts_shop_id_shops_id_fk" FOREIGN KEY ("shop_id") REFERENCES "public"."shops"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "counts" ADD CONSTRAINT "counts_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "event_logs" ADD CONSTRAINT "event_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "shop_items" ADD CONSTRAINT "shop_items_shop_id_shops_id_fk" FOREIGN KEY ("shop_id") REFERENCES "public"."shops"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "shop_items" ADD CONSTRAINT "shop_items_item_id_items_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_shops" ADD CONSTRAINT "user_shops_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_shops" ADD CONSTRAINT "user_shops_shop_id_shops_id_fk" FOREIGN KEY ("shop_id") REFERENCES "public"."shops"("id") ON DELETE cascade ON UPDATE no action;