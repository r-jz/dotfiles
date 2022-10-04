-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local trouble = require("trouble")
local lsp_signature = require("lsp_signature")
local server_configs = require("config.lsp.server_config")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

vim.keymap.set("n", "<Leader>xx", "<cmd>TroubleToggle<CR>", opts)
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)

-- setup trouble
trouble.setup({ mode = "document_diagnostics" })
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
--
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  lsp_signature.on_attach()

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<Leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<Leader>lf", function()
    vim.lsp.buf.format({ sync = true })
  end, bufopts)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

-- Change diagnosticIcon
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})
-- Float diahnostic window when
-- vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

mason.setup()
mason_lsp.setup()

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

for server_name, configs in pairs(server_configs) do
  local settings = configs["settings"]
  local flags = configs["flags"]
  if flags == nil then
    flags = {}
  end
  lspconfig[server_name].setup({
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
    settings = settings,
  })
end
-- rust
require("rust-tools").setup({
  server = {
    on_attach = on_attach,
  },
})

-- null-ls
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostic = null_ls.builtins.diagnostics

local sources = {
  formatting.autopep8.with({
    extra_args = { "-a", "--max-line-length", "110" },
  }),
  formatting.isort,
  formatting.stylua,
  formatting.cabal_fmt,
  --diagnostic.pylint,
}

null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = on_attach,
})
