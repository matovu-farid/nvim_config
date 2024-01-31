function new_file()
  local dirname = vim.fn.expand("%:p:h")
  local basename = vim.fn.input("New file name: ")
  if basename == "" then
    print("No file name given")
    return
  end
  local filename = dirname .. "/" .. basename
  vim.cmd("edit " .. filename)
  vim.cmd("saveas " .. filename)
end

function printTable(table)
  print(vim.inspect(table))
end

vim.api.nvim_set_keymap("n", "<leader>nf", "<cmd>AdvancedNewFile<CR>", { noremap = true })
