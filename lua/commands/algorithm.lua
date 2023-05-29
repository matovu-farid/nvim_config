local group = vim.api.nvim_create_augroup("PrintToOutput", {
  clear = true })
vim.api.nvim_create_autocmd({ 'BufAdd' }, {
  pattern = { "main.py" },
  callback = function()
    local projectName = vim.fn.expand("%:p:h:t")
    if projectName ~= "algorithms" then
      return
    end
    vim.api.nvim_command("NeoTreeClose")
    vim.api.nvim_command("Copilot disable")
        print('Algorithms are lit2')

    vim.schedule(function()
      local output = vim.fn.expand("%:p:h") .. "/output.txt"
      local splitnr = vim.fn.tabpagewinnr(1)
      if splitnr > 2 then
        return
      end
      vim.api.nvim_command("rightbelow vsplit " .. output)
      vim.api.nvim_command("wincmd h")
    end)
  end,
  group = group
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "main.py" },
  callback = function()
    local buffer_number = vim.fn.bufnr("output.txt")
    local filename = vim.fn.expand("%:p")
    local projectName = vim.fn.expand("%:p:h:t")
    if projectName ~= "algorithms" then
      return
    end

    vim.fn.jobstart({ "python3", filename }, {
      on_stdout = function(_, data, _)
        vim.api.nvim_buf_set_lines(buffer_number, 0, -1, false, { "Algorithms are lit" })
        vim.api.nvim_buf_set_lines(buffer_number, -1, -1, false, data)
      end,
      on_stderr = function(_, data, _)
        vim.api.nvim_buf_set_lines(buffer_number, -1, -1, false, { "" })
        vim.api.nvim_buf_set_lines(buffer_number, -1, -1, false, data)
      end,
      stdout_buffered = true,
      stderr_buffered = true,
    })
  end,
  group = group
})
