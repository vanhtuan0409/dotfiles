vim.g.did_load_filetypes = 1

require("filetype").setup({
  overrides = {
    extensions = {
      nix = "nix",
      fish = "fish",
      tf = "terraform",
      toml = "toml",
    },
    literal = {
      ["Gopkg.lock"] = "toml",
      ["Cargo.lock"] = "toml",
      ["Pipfile"] = "toml",
    },
    complex = {
      [".*/.cargo/config"] = "toml",
      [".*/.cargo/credentials"] = "toml",
      [".*/.kube/config"] = "yaml",
    },
  },
})
