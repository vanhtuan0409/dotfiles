#!/bin/env -S deno run --allow-env --allow-run

const CONFIG = {
  normalIcon: " ",
  mutedIcon: "",
};

const re = new RegExp(
  "Volume: (?<volume>[0-9\\.]+)\\s*(?<status>\\[MUTED\\])?",
);
const defaultResp = { icon: "", value: 0, display: "" };
const mutedResp = { icon: CONFIG.mutedIcon, value: 0, display: "muted" };
const dataResp = (volRaw: string) => {
  const vol = parseFloat(volRaw);
  if (isNaN(vol)) return defaultResp;
  return {
    icon: CONFIG.normalIcon,
    value: vol,
    display: `${vol * 100}%`,
  };
};

const handleData = (resp: any) => console.log(JSON.stringify(resp));
const handleErr = () => handleData(defaultResp);

async function status() {
  const cmd = new Deno.Command("wpctl", {
    args: ["get-volume", "@DEFAULT_AUDIO_SINK@"],
  });
  const resp = await cmd.output();
  if (!resp.success) {
    handleErr();
    return;
  }
  const data = new TextDecoder().decode(resp.stdout);
  const matches = data.trim().match(re);
  const groups = matches?.groups;
  if (!groups) {
    handleErr();
    return;
  }

  if (groups.status) {
    handleData(mutedResp);
    return;
  }
  handleData(dataResp(groups.volume));
}

async function main() {
  await status();
}

main();
