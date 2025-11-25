import { config } from "dotenv";
import { z } from "zod";

// Load .env values during local development/testing.
// In managed hosts (Vercel, Supabase), variables are injected automatically.
if (process.env.NODE_ENV !== "production") {
  config();
} else {
  // In production we still allow dotenv to run if a file exists,
  // but we don't want errors if it doesn't.
  config({ override: false });
}

const envSchema = z.object({
  NODE_ENV: z.enum(["development", "test", "production"]).default("development"),
  DATABASE_URL: z.string().url(),
  SESSION_SECRET: z.string().min(16, "SESSION_SECRET must be at least 16 characters"),
  PORT: z.coerce.number().positive().default(5000),
  SEED_ON_START: z
    .union([z.boolean(), z.string()])
    .optional()
    .transform((value) => {
      if (typeof value === "boolean") return value;
      if (typeof value === "string") {
        return ["true", "1", "yes"].includes(value.toLowerCase());
      }
      return false;
    }),
});

const parsed = envSchema.safeParse(process.env);

if (!parsed.success) {
  console.error("❌ Invalid environment configuration:");
  console.error(parsed.error.flatten().fieldErrors);
  throw new Error("Environment validation failed");
}

export const env = parsed.data;
export const isProduction = env.NODE_ENV === "production";

