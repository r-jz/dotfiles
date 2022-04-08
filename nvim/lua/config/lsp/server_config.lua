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
            typeCheckingMode = "off",
          },
        },
      },
    },
  },
}

return server_configs
