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

  -- sticky
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },

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
    cmd = { "Trouble" },
    opt = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<Leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)
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
    config = function()
      require("config.lsp")
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
  },

  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "stylua", "bashls", "pyright", "clangd" },
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  -- which-key
  {
    "folke/which-key.nvim",
    cmd = {
      "WhichKey",
    },
    opts = {},
  },

  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup({--[[ your config ]]
      })
    end,
  },
  -- haskell
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      vim.g.haskell_tools = {
        tools = {
          repl = {
            handler = "toggleterm",
          },
        },
      }
    end,
    version = "^2", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
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
    "stevearc/aerial.nvim",
    opts = {},
    cmd = "AerialToggle",
    init = function()
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- quickfix
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  { "gabrielpoca/replacer.nvim", ft = "qf" },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
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
    keys = { "<C-\\>" },
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
      local function open_nvim_tree(data)
        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
          return
        end

        -- change to the directory
        vim.cmd.cd(data.file)

        -- open the tree
        require("nvim-tree.api").tree.open()
      end
      local silent = { silent = true }
      vim.keymap.set("n", "<C-n>", [[<cmd>NvimTreeToggle<cr>]], silent)
      vim.keymap.set("n", "<Leader>nr", [[<cmd>NvimTreeRefresh<cr>]], silent)
      vim.keymap.set("n", "<Leader>nf", [[<cmd>NvimTreeFindFile<cr>]], silent)
      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
    opts = {
      hijack_unnamed_buffer_when_opening = true,
      disable_netrw = true,
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

  -- markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = { enabled = filetype == "markdown", completions = { lsp = { enabled = true } } },
    ft = { "markdown", "codecompanion" },
    cmd = { "RenderMarkdown" },
    keys = { { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "toggle render-markdown" } },
  },
  {
    "milanglacier/minuet-ai.nvim",
    cond = vim.env.OLLAMA_API_KEY ~= nil,
    cmd = { "Minuet" },
    config = function()
      require("minuet").setup({
        provider = "openai_compatible",
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        request_timeout = 10,
        provider_options = {
          openai_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = "OLLAMA_API_KEY",
            name = "Ollama",
            stream = false,
            end_point = "http://172.17.200.5:11434/v1/chat/completions",
            model = "qwen2.5-coder:7b",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },
        notify = "debug",
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = "<A-A>",
            -- accept one line
            accept_line = "<A-a>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cond = vim.env.OLLAMA_API_KEY ~= nil,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
    keys = {
      { "<Space>cc", "<Cmd>CodeCompanionChat Toggle<CR>", mode = { "n" } },
      { "<Space>cc", "<Cmd>CodeCompanionChat<CR>", mode = { "v" } },
      { "<Space>ca", "<Cmd>CodeCompanionActions<CR>", mode = { "n", "x" } },
    },
    opts = {
      strategies = {
        chat = {
          adapter = {
            name = "ollama",
            model = "gpt-oss:120b",
          },
          keymaps = {
            close = {
              modes = { n = "<C-/>", i = "<C-/>" },
            },
          },
        },
        inline = {
          adapter = { name = "ollama", model = "gpt-oss:120b" },
        },
        cmd = {
          adapter = {
            name = "ollama",
            model = "gpt-oss:120b",
          },
        },
      },
      adapters = {

        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://172.17.200.5:11434",
                api_key = "OLLAMA_API_KEY",
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = {
                sync = true,
              },
            })
          end,
        },
      },
      opts = {
        log_level = "TRACE", -- or "TRACE"
      },
    },
  },
}
