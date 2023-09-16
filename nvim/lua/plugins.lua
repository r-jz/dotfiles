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
  -- use({ "haishanh/night-owl.vim" })
  use({ "folke/tokyonight.nvim" })
  -- use({ "shaunsingh/moonlight.nvim" })

  -- openbrowser
  use({
    "tyru/open-browser.vim",
    cmd = { "OpenBrowser", "OpenBrowserSearch" },
    keys = { "<Plug>(openbrowser-smart-search)" },
    setup = function()
      vim.g.netrw_nogx = 1
      local silent = { silent = true }
      vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", silent)
      vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", silent)
    end,
  })
  -- capture
  use({ "tyru/capture.vim", cmd = { "Capture" } })

  -- sandwich
  use({ "machakann/vim-sandwich", event = "InsertEnter *" })

  -- trouble
  use({
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    opt = true,
    requires = { "nvim-tree/nvim-web-devicons" },
    setup = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Leader>xx", "<cmd>TroubleToggle<CR>", opts)
      vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
      vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
      vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
      vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
    end,
    config = function()
      require("trouble").setup({ mode = "document_diagnostics" })
    end,
  })

  -- lsp config
  use({
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      local lsp = require("config.lsp")
      lsp.lsp_config()
    end,
  })
  use({
    "williamboman/mason.nvim",
    opt = false,
    requires = "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  })
  use({ "ray-x/lsp_signature.nvim", opt = true, after = "nvim-lspconfig" })

  -- rust
  use({
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      local rt = require("rust-tools")
      local lsp = require("config.lsp")
      rt.setup({
        server = {
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<Ctrl-k>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            lsp.on_attach(client, bufnr)
          end,
        },
      })
    end,
  })
  -- haskell
  use({
    "mrcjkb/haskell-tools.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
  })

  -- fidget
  use({ "j-hui/fidget.nvim", opt = true, event = "BufReadPost", config = [[require('config.fidget')]] })

  -- quickfix
  use({
    { "kevinhwang91/nvim-bqf",     ft = "qf" },
    { "gabrielpoca/replacer.nvim", ft = "qf" },
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost" },
    config = [[require('config.treesitter')]],
  })
  --use({ "HiPhish/nvim-ts-rainbow2", opt = true, after = "nvim-treesitter" })
  --use({ "eddiebergman/nvim-treesitter-pyfold", ft = "python", after = "nvim-treesitter" })
  use({ "windwp/nvim-autopairs", event = "InsertEnter *", config = [[require('config.autopairs')]] })
  use({ "windwp/nvim-ts-autotag", opt = true, after = "nvim-treesitter" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", opt = true, after = "nvim-treesitter" })
  use({
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
    after = "nvim-treesitter",
  })

  -- ansible
  --use({ "mfussenegger/nvim-ansible" })
  use({ "pearofducks/ansible-vim" })
  -- colorizer
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })
  -- Comment
  use({
    "numToStr/Comment.nvim",
    event = { "InsertEnter" },
    config = function()
      require("Comment").setup()
    end,
  })

  -- smart split
  use({ "mrjones2014/smart-splits.nvim", event = "WinEnter", config = [[require('config.smartsplits')]] })

  -- git-conflict
  use({
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({})
    end,
    event = "BufWinEnter",
  })

  -- statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = [[require('config.lualine')]],
  })

  -- completion
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    requires = {
      { "lukas-reineke/cmp-under-comparator" },
      { "onsails/lspkind-nvim",              module = { "lspkind" } },
      { "rcarriga/cmp-dap",                  after = "cmp-buffer" },
      { "hrsh7th/cmp-buffer",                after = "cmp-path" },
      { "hrsh7th/cmp-nvim-lsp",              after = "cmp_luasnip" },
      { "hrsh7th/cmp-cmdline",               after = "cmp-dap" },
      { "hrsh7th/cmp-path",                  after = "cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lua",              after = "cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip",          after = "LuaSnip" },
    },
    config = function()
      require("config.cmp")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require("config.luasnippet").config()
    end,
  })

  -- indent blankline
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = [[require('config.indent_blankline')]],
  })

  -- toggleterm
  use({
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function()
      local t_config = require("config.toggleterm")
      t_config.config()
    end,
    setup = function()
      local t_config = require("config.toggleterm")
      t_config.setup()
    end,
  })

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    setup = function()
      local telescope = require("config.telescope")
      telescope.setup()
    end,
    config = function()
      local telescope = require("config.telescope")
      telescope.config()
    end,
    cmd = { "Telescope" },
    module = { "telescope" },
  }, { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true, after = "telescope.nvim" })

  -- nvim-dap
  use({
    {
      "mfussenegger/nvim-dap",
      setup = function()
        local dap = require("config.dap")
        dap.dap.setup()
      end,
      config = function()
        local dap = require("config.dap")
        dap.dap.config()
      end,
      module = { "dap" },
    },
    {
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      after = { "nvim-dap" },
      config = function()
        local dap = require("config.dap")
        dap.ui.config()
      end,
    },
    {
      "mfussenegger/nvim-dap-python",
      requires = { "mfussenegger/nvim-dap" },
      after = { "nvim-dap" },
      config = function()
        local dap = require("config.dap")
        dap.dappy.config()
      end,
      ft = "python",
    },
  })
  -- symbols outline
  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  })

  -- nvim-tree
  use({
    "nvim-tree/nvim-tree.lua",
    opt = true,
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    setup = function()
      local silent = { silent = true }
      vim.keymap.set("n", "<C-n>", [[<cmd>NvimTreeToggle<cr>]], silent)
      vim.keymap.set("n", "<Leader>nr", [[<cmd>NvimTreeRefresh<cr>]], silent)
      vim.keymap.set("n", "<Leader>nf", [[<cmd>NvimTreeFindFile<cr>]], silent)
    end,
    config = [[require('config.nvim_tree')]],
  })

  -- null-ls
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    event = { "FocusLost", "CursorHold" },
    config = function()
      local lsp = require("config.lsp")
      lsp.null_ls_config()
    end,
  })
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
