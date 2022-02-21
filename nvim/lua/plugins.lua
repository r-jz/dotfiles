local packer = nil
local function init()
  if packer == nil then
    packer = require("packer")
    packer.init({
      disable_commands = true,
      display = {
        open_fn = require("packer.util").float,
      },
    })
  end

  local use = packer.use
  packer.reset()

  -- packer
  use({ "wbthomason/packer.nvim", opt = true })

  use({ "lewis6991/impatient.nvim" })

  -- colorsheme
  use({ "haishanh/night-owl.vim" })

  -- lsp config
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/nvim-lsp-installer",
      "hrsh7th/cmp-nvim-lsp",
    },
  })

  -- treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
    },
    config = [[require('config.cmp')]],
    event = "InsertEnter *",
  })

  -- telescope
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- null ls
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
