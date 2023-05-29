
local group = vim.api.nvim_create_augroup("AutoOpenMainFile", {
  clear = true })
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
      openExistingFile("src/pages/_app.jsx")
      openExistingFile("lib/main.dart")
      openExistingFile("main.py")
  end,
  group = group
})

