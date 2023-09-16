local toggleterm = require("toggleterm")

return {
  config = function()
    toggleterm.setup({
      -- size can be a number or function which is passed the current terminal
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
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
    })
  end,
  setup = function()
    local opts = { noremap = true, silent = true }
    function _G.set_terminal_keymaps()
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", opts)
    vim.keymap.set("n", "<C-t><C-a>", "<cmd>ToggleTermToggleAll<cr>", opts)
    vim.keymap.set("n", "<C-t><C-f>", "<cmd>ToggleTerm direction=float<cr>", opts)
    vim.keymap.set("n", "<C-t><C-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opts)
  end,
}
