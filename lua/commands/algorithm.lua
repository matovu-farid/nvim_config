
-- Set the key mapping

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
    vim.api.nvim_command("!source venv/bin/activate")

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



vim.api.nvim_create_autocmd({ 'BufAdd' }, {
  pattern = { "main.cpp" },
  callback = function()
    local projectName = vim.fn.expand("%:p:h:t")
    if projectName ~= "algorithms" then
      return
    end
    vim.api.nvim_command("Copilot disable")

    -- vim.cmd[[autocmd User JobActivity if mode() != 'c' | checktime | endif]]
    vim.keymap.set("n", "<leader>r", ":silent !crun main.cpp<CR>", {silent = true,})
    vim.schedule(function()
      local output = vim.fn.expand("%:p:h") .. "/output.txt"
      local input = vim.fn.expand("%:p:h") .. "/input.txt"
      vim.api.nvim_command("rightbelow vsplit " .. input)
      io.open(output, "w"):close()
      vim.api.nvim_command("rightbelow split " .. output)
      vim.api.nvim_command("wincmd h")

      vim.api.nvim_command("vertical resize 85")
    end)
  end,
  group = group
})


-- In a separate Lua file or within your init.lua
-- Create a module 'myjobstart' with a function 'run_command'


