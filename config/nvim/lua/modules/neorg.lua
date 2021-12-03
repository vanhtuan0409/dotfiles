require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      }
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          gtd = "~/Dropbox/neorgs/gtd"
        }
      }
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd",
      }
    },
  },
}
