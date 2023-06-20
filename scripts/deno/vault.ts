#!/bin/env -S deno run --allow-env --allow-run --allow-write=/tmp --allow-read=/tmp

import * as log from "std/log/mod.ts";
import * as fs from "std/fs/mod.ts";
import { BufReader } from "std/io/mod.ts";

const CONFIG = {
  logFile: "/tmp/vault-helper.log",
  tokenFile: "/tmp/vault-token",
};

log.setup({
  handlers: {
    console: new log.handlers.ConsoleHandler("DEBUG"),
    file: new log.handlers.FileHandler("DEBUG", {
      filename: CONFIG.logFile,
      mode: "a",
    }),
  },
  loggers: {
    default: {
      level: "DEBUG",
      handlers: ["file"],
    },
    debug: {
      level: "DEBUG",
      handlers: ["console", "file"],
    },
  },
});
const loggerType = Deno.env.has("DEBUG") ? "debug" : "default";
const logger = log.getLogger(loggerType);

async function main() {
  await fs.ensureFile(CONFIG.tokenFile);
  const tokens = await readTokenFile();
  const target = Deno.env.get("VAULT_ADDR");
  if (!target) {
    logger.warning("no vault address");
    Deno.exit(1);
  }
  logger.info(`Target: ${target}`);

  switch (Deno.args[0]) {
    case "get": {
      const token = tokens[target] || "";
      await Deno.stdout.write(new TextEncoder().encode(token));
      break;
    }

    case "store": {
      const reader = new BufReader(Deno.stdin);
      const storedToken = await reader.readString("\n");
      tokens[target] = storedToken || "";
      await Deno.writeTextFile(CONFIG.tokenFile, JSON.stringify(tokens));
      break;
    }

    case "erase": {
      delete tokens[target];
      await Deno.writeTextFile(CONFIG.tokenFile, JSON.stringify(tokens));
      break;
    }

    default: {
      logger.error("unknown command");
      Deno.exit(1);
    }
  }
}

async function readTokenFile(): Promise<{ [key: string]: string }> {
  try {
    const data = await Deno.readTextFile(CONFIG.tokenFile);
    return JSON.parse(data);
  } catch (err) {
    logger.warning(`unable to read token file ${err}`);
    return {};
  }
}

main();
