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

  -- openbrowser
  use({ "tyru/open-browser.vim", setup = [[require('config.openbrowser_setup')]] })

  -- capture
  use({ "tyru/capture.vim", cmd = { "Capture" } })

  -- sandwich
  use({ "machakann/vim-sandwich", event = "InsertEnter *" })

  -- trouble
  use({ "folke/trouble.nvim", requires = { "kyazdani42/nvim-web-devicons" } })

  -- lsp config
  use({
    "neovim/nvim-lspconfig",
    event = { "BufWinEnter" },
    requires = {
      "ray-x/lsp_signature.nvim",
      "williamboman/nvim-lsp-installer",
      "hrsh7th/cmp-nvim-lsp",
      "folke/trouble.nvim",
    },
    config = [[require('config.lsp')]],
  })
  use({ "j-hui/fidget.nvim", after = "nvim-lsp-installer", config = [[require('config.fidget')]] })

  -- rust-tools
  use({
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup()
    end,
  })

  -- quickfix
  use({
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    { "gabrielpoca/replacer.nvim", ft = "qf" },
  })

  -- iron repl
  use({ "hkupty/iron.nvim", config = [[require('config.iron')]], cmd = "IronRepl" })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    cmd = { "TSInstall", "TSInstallInfo", "TSInstallSync", "TSUpdate", "TSUpdateSync", "TSDisableAll", "TSEnableAll" },
    config = [[require('config.treesitter')]],
  })
  use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
  use({ "eddiebergman/nvim-treesitter-pyfold", ft = "python", after = "nvim-treesitter" })
  use({ "windwp/nvim-autopairs", event = "InsertEnter *", config = [[require('config.autopairs')]] })

  -- smart split
  use({ "mrjones2014/smart-splits.nvim", event = "WinEnter", config = [[require('config.smartsplits')]] })

  -- neogit
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = [[require('config.neogit')]],
  })

  -- git-conflict
  use({
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
    event = "BufWinEnter",
  })

  -- statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[require('config.lualine')]],
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

  -- indent blankline
  use({ "lukas-reineke/indent-blankline.nvim", event = "BufRead", config = [[require('config.indent_blankline')]] })

  -- toggleterm
  use({
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = [[require('config.toggleterm')]],
    setup = [[require('config.toggleterm_setup')]],
  })

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
    -- cmd = { "NvimTreeToggle" },
  })

  -- null ls
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
  -- notify
  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  })
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
