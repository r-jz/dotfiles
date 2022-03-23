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
  use({ "nathom/filetype.nvim" })

  -- colorsheme
  use({ "haishanh/night-owl.vim" })
  use({ "folke/tokyonight.nvim" })
  use({ "shaunsingh/moonlight.nvim" })

  -- lexima
  use({ "cohama/lexima.vim", event = "InsertEnter *" })

  -- openbrowser
  use({ "tyru/open-browser.vim", setup = [[require('config.openbrowser_setup')]] })

  -- sandwich
  use({ "machakann/vim-sandwich", event = "InsertEnter *" })

  -- trouble
  use({ "folke/trouble.nvim", requires = { "kyazdani42/nvim-web-devicons" } })

  -- lsp config
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "ray-x/lsp_signature.nvim",
      "williamboman/nvim-lsp-installer",
      "hrsh7th/cmp-nvim-lsp",
      "folke/trouble.nvim",
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
      "saadparwaiz1/cmp_luasnip",
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    },
    config = function()
      require("config.cmp")
      require("config.luasnippet")
    end,
    event = "InsertEnter *",
  })

  -- toggleterm
  use({ "akinsho/toggleterm.nvim" })

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    setup = [[require('config.telescope_setup')]],
    config = [[require('config.telescope')]],
    cmd = { "Telescope" },
    module = { "telescope" },
  }, { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cmd = { "Telescope" }, module = { "telescope" } })

  -- nvim-dap
  use({
    {
      "mfussenegger/nvim-dap",
      setup = [[require('config.dap_setup')]],
      config = [[require('config.nvimdap')]],
      module = { "dap" },
    },
    {
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      after = { "nvim-dap" },
      config = [[require('config.dapui')]],
    },
    {
      "mfussenegger/nvim-dap-python",
      requires = { "mfussenegger/nvim-dap" },
      after = { "nvim-dap" },
      config = [[require('config.debugpy')]],
      ft = "python",
    },
  })

  -- nvim-tree
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    setup = [[require('config.nvim_tree_setup')]],
    config = [[require('config.nvim_tree')]],
    cmd = { "NvimTreeToggle" },
  })

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
