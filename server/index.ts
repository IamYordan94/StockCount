import { createServer } from "http";
import { setupVite, serveStatic } from "./vite";
import { log } from "./logger";
import { seedDatabase } from "./seed";
import { env } from "./env";
import { createApp } from "./app";

async function bootstrap() {
  const app = await createApp();
  const server = createServer(app);
  const port = env.PORT;

  server.listen(
    {
      port,
      host: "0.0.0.0",
      reusePort: true,
    },
    async () => {
      log(`Server listening on port ${port} - health checks ready`);

      try {
        if (app.get("env") === "development") {
          await setupVite(app, server);
        } else {
          serveStatic(app);
        }

        log(`Application routes registered and ready`);

        if (env.SEED_ON_START) {
          seedDatabase().catch((err) => {
            console.error("Database seeding failed:", err);
          });
        }
      } catch (error) {
        console.error("Failed to initialize application:", error);
        process.exit(1);
      }
    },
  );
}

bootstrap();
