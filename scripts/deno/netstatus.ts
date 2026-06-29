#!/bin/env -S deno run --allow-run=warp-cli,tailscale
// Connectivity status for waybar JSON custom modules.
//
//   netstatus.ts <service>
//
// Prints one JSON line ({alt, class, tooltip}) for a `return-type: json`
// custom module. `alt` selects the glyph via the module's format-icons map;
// `class` drives the CSS color. Each service only reports *state* -- the
// glyph and color live in the waybar config/CSS, so presentation stays out
// of here.
//
// To add a service: drop another entry in SERVICES below (and, if it shells
// out to a new binary, widen the --allow-run list in the shebang).

type Fields = { alt: string; class: string; tooltip: string };
type NetStatus = "up" | "down";

interface Service {
  // run the check and return a state key into `states`
  check: () => Promise<NetStatus>;
  // state key -> waybar fields
  states: Record<NetStatus, Fields>;
  // state key used when the check throws or returns an unknown key
  fallback: NetStatus;
}

// run a command, return its stdout (empty string if the binary is missing
// or it exits non-zero -- callers treat that as "down").
async function run(cmd: string, args: string[] = []): Promise<string> {
  try {
    const { stdout } = await new Deno.Command(cmd, {
      args,
      stdout: "piped",
      stderr: "null",
    }).output();
    return new TextDecoder().decode(stdout);
  } catch {
    return "";
  }
}

const SERVICES: Record<string, Service> = {
  warp: {
    fallback: "down",
    states: {
      up: { alt: "up", class: "up", tooltip: "WARP: connected" },
      down: { alt: "down", class: "down", tooltip: "WARP: disconnected" },
    },
    check: async () =>
      (await run("warp-cli", ["status"])).includes("Connected") ? "up" : "down",
  },

  tailscale: {
    fallback: "down",
    states: {
      up: { alt: "up", class: "up", tooltip: "Tailscale: running" },
      down: { alt: "down", class: "down", tooltip: "Tailscale: stopped" },
    },
    check: async () => {
      const out = await run("tailscale", ["status", "--json"]);
      if (!out) return "down";
      return JSON.parse(out)?.BackendState === "Running" ? "up" : "down";
    },
  },
};

async function main() {
  const name = Deno.args[0];
  const svc = SERVICES[name];
  if (!svc) {
    console.error(
      `netstatus: unknown service '${name ?? ""}'; known: ${Object.keys(
        SERVICES,
      ).join(", ")}`,
    );
    Deno.exit(1);
  }

  let status = svc.fallback;
  try {
    status = await svc.check();
  } catch {
    status = svc.fallback;
  }

  console.log(JSON.stringify(svc.states[status] ?? svc.states[svc.fallback]));
}

main();
