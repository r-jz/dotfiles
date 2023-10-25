local util = require("lspconfig.util")
local server_configs = {
        -- lua lsp
        lua_ls = {
                settings = {
                        Lua = {
                                --        format = {
                                --          enable = true,
                                --          defaultConfig = {
                                --          indent_style = "space",
                                --          indent_size = "2",
                                --          }
                                --          },
                                diagnostics = {
                                        globals = { "vim", "use" },
                                },
                                runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
                                workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false,
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
        clangd = {
                settings = {},
        },
        tsserver = {
                settings = {},
        },
        cmake = {
                settings = {},
        },
        bashls = {
                settings = {},
        },
        svls = {
                settings = {
                        svls = {
                                root_dir = util.root_pattern(".svls.toml"),
                        },
                },
        },
        arduino_language_server = {
                settings = {},
        },
        yamlls = {
                settings = {
                        yaml = {
                                keyOrdering = false,
                        },
                },
        },
        ansiblels = {
                settings = {},
        },
}

return server_configs
