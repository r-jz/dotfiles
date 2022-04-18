local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<C-k>"] = function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ["<C-j>"] = function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
    ["<C-l>"] = function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice()
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
    { name = "path" },
    { name = "buffer" },
    { name = "nvim_lua" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        path = "[[Path]]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
      },
    }),
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

vim.cmd([[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]])
-- blue
vim.cmd([[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]])
vim.cmd([[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]])
-- light blue
vim.cmd([[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]])
vim.cmd([[highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE]])
vim.cmd([[highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE]])
-- pink
vim.cmd([[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]])
vim.cmd([[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]])
-- front
vim.cmd([[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]])
vim.cmd([[highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4]])
vim.cmd([[highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]])
