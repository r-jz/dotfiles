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
    disable_format = true,
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          stubPath = os.getenv("HOME") .. "/typings",
          useLibraryCodeForTypes = false,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  hls = {
    settings = {
      haskell = {
        formattingProvider = "stylish-haskell",
      },
    },
  },
}

return server_configs
