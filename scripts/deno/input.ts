#!/bin/env -S deno run --allow-env --allow-run

const CONFIG = {
  display: {
    "xkb:us::eng": "en",
    "BambooUs": "en",
    "Bamboo": "vi",
  },
  cycle: ["xkb:us::eng", "Bamboo"],
};

const decoder = new TextDecoder();

async function main() {
  switch (Deno.args[0]) {
    case "show": {
      await show();
      break;
    }
    case "next": {
      await next();
      break;
    }
    default: {
      await show();
    }
  }
}

async function show() {
  const engine = await currentEngine().catch((_) => "");
  const display: string = (<any> CONFIG.display)[engine] || "unknown";
  console.log(display);
}

async function next() {
  const engine = await currentEngine();
  const index = CONFIG.cycle.findIndex((it) => it === engine);
  const nextIndex = (index + 1) % CONFIG.cycle.length;
  const nextEngine = CONFIG.cycle[nextIndex];
  await setEngine(nextEngine);
}

async function currentEngine(): Promise<string> {
  const cmd = new Deno.Command("ibus", { args: ["engine"] });
  const resp = await cmd.output();
  if (!resp.success) {
    throw new Error(decoder.decode(resp.stderr));
  }
  return decoder.decode(resp.stdout).trim();
}

async function setEngine(engine: string) {
  const cmd = new Deno.Command("ibus", { args: ["engine", engine] });
  await cmd.output();
}

main();
