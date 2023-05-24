local dap = require('dap')
dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or '127.0.0.1'

    cb({
      type = 'server',
      request = 'attach',
      host = host,
      port = port,
      options = {
        sourceFiletype = 'python',
      },
    })
  else
    local cwd = vim.fn.getcwd()
    cb({
      type = 'executable',
      command = cwd .. '/venv/bin/python3',
      args = { '-m', 'debugpy.adapter' },
      options = {
        sourceFiletype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
  },
}

local dapui = require("dapui")
dapui.setup()

-- Open DAPUI after initialization
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Close DAPUI before termination
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

-- Close DAPUI before exit
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
require("nvim-dap-virtual-text").setup {
  commented = true,
}
