local nmap = function(key, cb)
  vim.keymap.set('n', key, cb, {  silent = true})
end
nmap('<F5>', ':lua require"dap".continue()<CR>')
nmap('<F10>', ':lua require"dap".step_over()<CR>')
nmap('<F11>', ':lua require"dap".step_into()<CR>')
nmap('<F12>', ':lua require"dap".step_out()<CR>')
nmap('<F6>', ':lua require"dap".toggle_breakpoint()<CR>')
nmap('<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
nmap('<leader>lp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
nmap('<leader>dr', ':lua require"dap".repl.open()<CR>')
nmap('<leader>dl', ':lua require"dap".run_last()<CR>')

