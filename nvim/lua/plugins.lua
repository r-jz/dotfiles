return {
  -- colorsheme
  -- use({ "haishanh/night-owl.vim" })
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- use({ "shaunsingh/moonlight.nvim" })

  -- openbrowser
  {
    "tyru/open-browser.vim",
    cmd = { "OpenBrowser", "OpenBrowserSearch" },
    keys = { "<Plug>(openbrowser-smart-search)" },
    init = function()
      vim.g.netrw_nogx = 1
      local silent = { silent = true }
      vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", silent)
      vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", silent)
    end,
  },

  -- capture
  {
    "tyru/capture.vim",
    cmd = "Capture",
  },

  -- sandwich
  {
    "machakann/vim-sandwich",
    event = "InsertEnter",
  },

  -- trouble
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    opt = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
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
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    dependencies = { "ray-x/lsp_signature.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lsp = require("config.lsp")
      lsp.lsp_config()
    end,
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },

  -- which-key
  {
    'folke/which-key.nvim',
    lazy = true,
    cmd = {
        "WhichKey",
    },
    opts = {},
  },

  -- rust
  {
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
  },
  -- haskell
  {
  'mrcjkb/haskell-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function ()
      vim.g.haskell_tools = {
        tools = {
          repl = {
            handler = "toggleterm",
          }
        }
      }
  end,
  version = '^2', -- Recommended
  ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  },

  -- fidget
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("config.fidget")
    end,
  },
  -- aerial
  {
    'stevearc/aerial.nvim',
    opts = {},
    cmd = "AerialToggle",
    keys = {"<leader>a"},
    init = function ()
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end,
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },

  -- quickfix
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  { "gabrielpoca/replacer.nvim", ft = "qf" },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost" },
    config = function()
      require("config.treesitter")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "stirng", "source" },
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = true,
  },

  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
    dependencies = { "nvim-treesitter" },
  },

  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = { "InsertEnter" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- smart split
  {
    "mrjones2014/smart-splits.nvim",
    event = "WinEnter",
    config = function()
      require("config.smartsplits")
    end,
  },

  -- git-conflict
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({})
    end,
    event = "BufWinEnter",
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.lualine")
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "lukas-reineke/cmp-under-comparator" },
      { "onsails/lspkind-nvim" },
      { "rcarriga/cmp-dap" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lua" },
      { "saadparwaiz1/cmp_luasnip" },
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("config.luasnippet").config()
        end,
      },
    },
    config = function()
      require("config.cmp")
    end,
  },

  -- indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("config.indent_blankline")
    end,
  },

  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    -- lazy = true,
    cmd = "ToggleTerm",
    keys = {"<C-\\>"},
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      --start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = false,
      direction = "horizontal",
      close_on_exit = true, -- close the terminal window when the process exits
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        --| 'double' | 'shadow' | 'curved' | ... other options supported by win open
        winblen = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    init = function()
      local t_config = require("config.toggleterm")
      t_config.setup()
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    init = function()
      local telescope = require("config.telescope")
      telescope.setup()
    end,
    config = function()
      local telescope = require("config.telescope")
      telescope.config()
    end,
    cmd = { "Telescope" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = "telescope.nvim",
  },

  -- nvim-dap
  {
    "mfussenegger/nvim-dap",
    init = function()
      local dap = require("config.dap")
      dap.dap.setup()
    end,
    config = function()
      local dap = require("config.dap")
      dap.dap.config()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-dap",
    },
    config = function()
      local dap = require("config.dap")
      dap.ui.config()
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "nvim-dap" },
    config = function()
      local dap = require("config.dap")
      dap.dappy.config()
    end,
    ft = "python",
  },

  -- symbols outline
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    init = function()
      local silent = { silent = true }
      vim.keymap.set("n", "<C-n>", [[<cmd>NvimTreeToggle<cr>]], silent)
      vim.keymap.set("n", "<Leader>nr", [[<cmd>NvimTreeRefresh<cr>]], silent)
      vim.keymap.set("n", "<Leader>nf", [[<cmd>NvimTreeFindFile<cr>]], silent)
    end,
    opts = {
      hijack_unnamed_buffer_when_opening = true,
      disable_netrw = true
    },
  },

  -- conform
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "autopep8", "isort" },
        javascript = { { "prettierd", "prettier" } },
      },
      -- Set up format-on-save
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      vim.notify = require("notify")
    end,
  },
}
