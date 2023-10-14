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

local output_lines = {}
local job_id = nil
local function on_stdout(_, data, _)
  for _, line in ipairs(data) do
    local truncated_line = string.sub(line, 1, 80)
    table.insert(output_lines, truncated_line)
    if #output_lines >= 100 then
      vim.fn.jobstop(job_id)
      break
    end
  end
end

local function on_exit(_, _)
  local output_file = vim.fn.expand("%:p:h") .. "/output.txt"
  local file = io.open(output_file, "w")
  if file then
    file:write(table.concat(output_lines, "\n"))
    file:flush()
    file:close()

    -- Update the buffer if it's open
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(buf) == output_file then
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output_lines)
        vim.api.nvim_buf_set_option(buf, 'modified', false)
      end
    end
  end
end


function run_main()
  -- Start the job
  job_id = vim.fn.jobstart({ "/usr/local/bin/crun", "main.cpp" }, {
    on_stdout = on_stdout,
    on_exit = on_exit,
  })
  output_lines = {}
end

vim.api.nvim_create_autocmd({ 'BufAdd' }, {
  pattern = { "main.cpp" },
  callback = function()
    local projectName = vim.fn.expand("%:p:h:t")
    if projectName ~= "algorithms" then
      return
    end
    vim.api.nvim_command("Copilot disable")

    -- vim.cmd[[autocmd User JobActivity if mode() != 'c' | checktime | endif]]
    vim.keymap.set("n", "<leader>x", run_main, { silent = true, desc = "Run main.cpp" })
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
