local smart_splits = require("smart-splits")
smart_splits.setup({
  -- Ignored filetypes (only while resizing)
  ignored_filetypes = {
    "nofile",
    "quickfix",
    "prompt",
  },
  -- Ignored buffer types (only while resizing)
  ignored_buftypes = { "NvimTree" },
  -- when moving cursor between splits left or right,
  -- place the cursor on the same row of the *screen*
  -- regardless of line numbers. False by default.
  -- Can be overridden via function parameter, see Usage.
  move_cursor_same_row = false,
  -- resize mode options
  resize_mode = {
    -- key to exit persistent resize mode
    quit_key = "<ESC>",
    -- set to true to silence the notifications
    -- when entering/exiting persistent resize mode
    silent = false,
    -- must be functions, they will be executed when
    -- entering or exiting the resize mode
    hooks = {
      on_enter = nil,
      on_leave = nil,
    },
  },
})

--local amount = 3
-- resizing splits
-- amount defaults to 3 if not specified
-- use absolute values, no + or -
--smart_splits.resize_up(amount)
--smart_splits.resize_down(amount)
--smart_splits.resize_left(amount)
--smart_splits.resize_right(amount)
-- moving between splits
-- pass same_row as a boolean to override the default
-- for the move_cursor_same_row config option.
-- See Configuration.
--smart_splits.move_cursor_up()
--smart_splits.move_cursor_down()
--smart_splits.move_cursor_left()
--smart_splits.move_cursor_right()
-- persistent resize mode
-- temporarily remap 'h', 'j', 'k', and 'l' to
-- smart resize left, down, up, and right, respectively,
-- press <ESC> to stop resize mode (unless you've set a different key in config)
-- smart_splits.start_resize_mode()

-- recommended mappings
-- resizing splits
vim.keymap.set("n", "<A-h>", smart_splits.resize_left)
vim.keymap.set("n", "<A-j>", smart_splits.resize_down)
vim.keymap.set("n", "<A-k>", smart_splits.resize_up)
vim.keymap.set("n", "<A-l>", smart_splits.resize_right)
-- moving between splits
-- vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
-- vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
-- vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
-- vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)
