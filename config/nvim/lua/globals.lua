CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH   = vim.fn.stdpath("data")
CACHE_PATH  = vim.fn.stdpath("cache")

PACKER_INSTALL_PATH  = DATA_PATH .. "/site/pack/packer/opt/packer.nvim"
PACKER_COMPILED_PATH = DATA_PATH .. "/site/plugin/packer_compiled.vim"
LOCAL_PLUGS_PATH = CONFIG_PATH .. "/localplugs"
