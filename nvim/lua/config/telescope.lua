return {
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })
    telescope.load_extension("fzf")
  end,
  setup = function ()
    local silent = { silent = true }
    -- Navigate buffers and repos
    vim.keymap.set("n", "<Leader>fb", [[<cmd>Telescope buffers show_all_buffers=true<cr>]], silent)
    vim.keymap.set("n", "<Leader>fg", [[<cmd>Telescope git_files<cr>]], silent)
    vim.keymap.set("n", "<Leader>ff", [[<cmd>Telescope find_files<cr>]], silent)
    vim.keymap.set("n", "<Leader>fr", [[<cmd>Telescope live_grep<cr>]], silent)

-- lsp actions
    vim.keymap.set("n", "<Leader>flr", [[<cmd>Telescope lsp_references<cr>]], silent)
    vim.keymap.set("n", "<Leader>fld", [[<cmd>Telescope lsp_definitions<cr>]], silent)
  end
}
