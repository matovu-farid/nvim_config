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

vim.api.nvim_set_keymap("n", "%", ":lua new_file()<CR>", { noremap = true })

function delete_and_refresh()
  local filename = vim.fn.expand("%")
  vim.cmd("silent! delete " .. filename)
  vim.cmd("NvimTreeRefresh")
end

vim.api.nvim_set_keymap("n", "<leader>df", ":delete_and_refresh()<CR>", { noremap = true })
