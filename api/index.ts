import type { VercelRequest, VercelResponse } from "@vercel/node";
import serverless from "serverless-http";
import { createApp } from "../server/app";

let cachedHandler: ReturnType<typeof serverless> | null = null;

async function getHandler() {
  if (!cachedHandler) {
    const app = await createApp();
    cachedHandler = serverless(app);
  }
  return cachedHandler;
}

export default async function handler(req: VercelRequest, res: VercelResponse) {
  const serverlessHandler = await getHandler();
  return serverlessHandler(req, res);
}

