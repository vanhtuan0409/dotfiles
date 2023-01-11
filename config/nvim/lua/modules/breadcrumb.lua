vim.api.nvim_set_hl(0, "BreadcrumbText", { link = "LspCodeLens", default = true })
vim.api.nvim_set_hl(0, "BreadcrumbSep", { link = "WarningMsg", default = true })

require("winbar-breadcrumb").setup()
