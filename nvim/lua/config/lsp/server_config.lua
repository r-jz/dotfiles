local server_configs = {
  -- lua lsp
  sumneko_lua = {
    opts = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use" },
          },
          runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        },
      },
    },
    disable_format = true,
  },
  pyright = {
    opts = {
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
  },
  pylsp = {
    disable_format = true,
  },
  hls = {
    opts = {
      settings = {
        haskell = {
          formattingProvider = "stylish-haskell",
        },
      },
    },
  },
}

return server_configs
