local util = require("lspconfig.util")
local server_configs = {
  -- lua lsp
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "use" },
        },
        runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          stubPath = os.getenv("HOME") .. "/typings",
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  hls = {
    settings = {
      haskell = {
        formattingProvider = "ormolu",
      },
    },
  },
  clangd = {
    settings = {},
  },
  tsserver = {
    settings = {},
  },
  cmake = {
    settings = {},
  },
  svls = {
    settings = {
      svls = {
        root_dir = util.root_pattern(".svls.toml"),
      },
    },
  },
}

return server_configs
