return {
  dap = {
    setup = function()
      -- setkeymapping for dap
      local opt = { silent = true, noremap = true }
      vim.keymap.set("n", "<F9>", [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], opt)
      vim.keymap.set("n", "<F5>", [[<cmd>lua require'dap'.continue()<CR>]], opt)
      vim.keymap.set("n", "<F10>", [[<cmd>lua require'dap'.step_over()<CR>]], opt)
      vim.keymap.set("n", "<F11>", [[<cmd>lua require'dap'.step_into()<CR>]], opt)
      -- F23 measn Shift + F11
      vim.keymap.set("n", "<F23>", [[<cmd>lua require'dap'.step_out()<CR>]], opt)
    end,
    config = function()
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }

      dap.configurations.rust = {
        {
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          terminal = "integrated",
          sourceLanguages = { "rust" },
          stopOnEntry = true,
        },
      }
    end,
  },

  ui = {
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  dappy = {
    config = function()
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
    end,
  },
}
