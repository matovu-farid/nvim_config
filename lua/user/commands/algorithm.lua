local Split = require("nui.split")
local event = require("nui.utils.autocmd").event
local group = vim.api.nvim_create_augroup("algorithms", {
  clear = true })

vim.api.nvim_set_hl(0, "AlgoError", { fg = "red", bg = "none" })
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
local function on_error(output)
  return function(_, data, _)
    if data then
      for _, line in ipairs(data) do
        table.insert(output_lines, line)
      end
    end
  end
end


local function on_exit(output)
  return function()
    vim.api.nvim_buf_set_lines(output, 0, -1, false, output_lines)
  end
end
local function cache_input(input_bfr)
  local input_file = vim.fn.expand("%:p:h") .. "/.input"
  local file = io.open(input_file, "w")
  if file then
    local lines = vim.api.nvim_buf_get_lines(input_bfr, 0, -1, false)
    file:write(table.concat(lines, "\n"))
    file:flush()
    file:close()
  end
end
local function clone_input(input_bfr)
  local input_file = vim.fn.expand("%:p:h") .. "/.input"
  local file = io.open(input_file, "r")
  if file then
    local lines = {}
    for line in file:lines() do
      table.insert(lines, line)
    end
    vim.api.nvim_buf_set_lines(input_bfr, 0, -1, false, lines)
    file:close()
  end
end

local function show_split(split, main_buf)
  split:mount()

  vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
    buffer = main_buf,
    callback = function()
      split:unmount()
    end
  })
end
local function close_other_buffers(main)
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    local exception = buf == main
    if not exception then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end
local function create_splits(main)
  close_other_buffers(main)
  local input = Split({
    relative = "editor",
    position = "right",
    size = "20%",
    enter = false
  })
  show_split(input, main)
  local output = Split({
    relative = {
      type = "win",
      winid = input.winid,
    },
    position = "bottom",
    size = "50%",
    enter = false
  })
  show_split(output, main)
  return { input = input.bufnr, output = output.bufnr, main = main }
end

local function run_main(job, bufs)
  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    buffer = bufs.input,
    callback = function()
      cache_input(bufs.input)
    end
  })
  clone_input(bufs.input)

  return function()
    job_id = vim.fn.jobstart(job, {
      on_stdout = on_stdout,
      on_exit = on_exit(bufs.output),
      on_stderr = on_error(bufs.output),
    })
    output_lines = {}
  end
end


local function create_runner(job)
  local function close_runner(bufs)
  return function()
    vim.api.nvim_buf_delete(bufs.output, { force = true })
    vim.api.nvim_buf_delete(bufs.input, { force = true })
    vim.keymap.del("n", "<leader>.")
    vim.keymap.set("n", "<leader>x",
      create_runner(job)
      , { silent = true, desc = "Run" })
  end
end
  return function()
    local main_file = vim.api.nvim_get_current_buf()
    vim.api.nvim_command("Copilot disable")
    local splits = create_splits(main_file)
    local run = run_main(job, splits)
    vim.keymap.set("n", "<leader>x", run,
      { silent = true, desc = "Run file" })
    vim.keymap.set("n", "<leader>.", close_runner(splits),
      { silent = true, desc = "Close Runner" })
    run()
  end
end
local function init_algo()
  local file_extension = vim.fn.expand("%:e")
  local file_name = vim.fn.expand("%:t")
  local jobs = {
    cpp = { "crun", file_name},
    c = { "crun", file_name},
    py = { "prun", file_name },
  }
  local job = jobs[file_extension]

  if job then
    vim.keymap.set("n", "<leader>x",
      create_runner(job)
      , { silent = true, desc = "Run" })
  end
end
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = init_algo,
})
