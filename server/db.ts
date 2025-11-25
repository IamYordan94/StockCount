import { Pool } from "pg";
import { drizzle } from "drizzle-orm/node-postgres";
import * as schema from "@shared/schema";
import { env } from "./env";

const shouldUseSSL =
  !env.DATABASE_URL.includes("localhost") &&
  !env.DATABASE_URL.includes("127.0.0.1");

export const pool = new Pool({
  connectionString: env.DATABASE_URL,
  ssl: shouldUseSSL ? { rejectUnauthorized: false } : false,
});

export const db = drizzle(pool, { schema });