local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup({
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  auto_install = true,
  -- List of parsers to ignore installing
  ignore_install = {},

  context_commentstring = {
    enable = true,
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  pyfold = {
    enable = true,
    custom_foldtext = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  rainbow = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },

  autotag = {
    enable = true
  }
})

vim.wo.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
