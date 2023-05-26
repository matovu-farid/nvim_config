-- Change the appearance of the completion menu
vim.cmd([[highlight Pmenu guifg=#ffffff guibg=#4b5263]])
vim.cmd([[highlight PmenuSel guifg=#ffffff guibg=#61afef]])
vim.cmd([[highlight PmenuSbar guifg=#ffffff guibg=#3e4451]])
vim.cmd([[highlight PmenuThumb guifg=#ffffff guibg=#61afef]])

vim.cmd('filetype plugin indent on')
vim.cmd [[
  let g:closetag_filetypes = 'jsx'
  let g:closetag_xhtml_filetypes = 'jsx'
  let g:closetag_regions = {'jsx': 'javascript.jsx'}
  let g:closetag_filenames = '*.jsx,*.js'
]]

vim.api.nvim_create_augroup("PrintToOutput", {
  clear = false
})
local function get_buffer_number(file_name)
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer)
    if buffer_name == file_name then
      return buffer
    end
  end
  return -1 -- Return -1 if buffer is not found
end


-- local group = vim.api.nvim_create_augroup("RunMain", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   pattern = { "main.py" },
--   callback = function(ev)
--     print "Running main.py"
--     local filename = vim.fn.expand("%")
--     vim.api.nvim_command("!python3 " .. filename)
--
--   end
-- })
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
    vim.schedule(function()
      local output = vim.fn.expand("%:p:h") .. "/output.txt"
      local splitnr = vim.fn.tabpagewinnr(1)
      if splitnr > 2 then
        return
      end

      vim.api.nvim_command("rightbelow vsplit " .. output)

      vim.api.nvim_command("wincmd h")
      vim.api.nvim_command("vertical resize +30")
    end)
  end,
  group = group
})
local function fileExists(path)
  local file = io.open(path, "r")
  if file then
    io.close(file)
    return true
  else
    return false
  end
end

local function openExistingFile(name)
  local projectPath = vim.fn.expand("%:p:h")
  local projectFilePath = projectPath .. "/" .. name
  if fileExists(projectFilePath) then
    vim.api.nvim_command("edit " .. projectFilePath)
  else
    return
  end
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  pattern = { "*" },
  callback = function()
    vim.schedule(function()

      openExistingFile("main.py")
      openExistingFile("src/pages/_app.jsx")
      openExistingFile("lib/main.dart")
    end)
  end
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "main.py" },
  callback = function()
    local buffer_number = vim.api.nvim_get_current_buf() + 1
    local filename = vim.fn.expand("%:p")
    local projectName = vim.fn.expand("%:p:h:t")
    if projectName ~= "algorithms" then
      return
    end

    vim.fn.jobstart({ "python3", filename }, {
      on_stdout = function(_, data, _)
        vim.api.nvim_buf_set_lines(buffer_number, 0, -1, false, { "Printing from main.py" })
        vim.api.nvim_buf_set_lines(buffer_number, -1, -1, false, data)
        vim.api.nvim_command("wincmd l")
        vim.api.nvim_command("write")
        vim.api.nvim_command("wincmd h")
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
