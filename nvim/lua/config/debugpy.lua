local dap_python = require("dap-python")
local dap = require("dap")

dap_python.test_runner = "pytest"
dap_python.setup("~/.venv/debugpy/bin/python")

table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "Debug Module",
  module = function()
    return vim.fn.input("Module Name: ")
  end,
})
table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "Debug Module with Args",
  args = function()
    local args_string = vim.fn.input("Args: ")
    return vim.split(args_string, " +")
  end,
  module = function()
    return vim.fn.input("Module Name: ")
  end,
})
