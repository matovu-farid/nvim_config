local Split = require("nui.split")
local event = require("nui.utils.autocmd").event
-- Set the key mapping
local group = vim.api.nvim_create_augroup("algorithms", {
  clear = true })




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







local function on_exit(output)
  return function()
    local output_file = vim.fn.expand("%:p:h") .. "/output.txt"
    vim.api.nvim_buf_set_lines(output, 0, -1, false, output_lines)
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
end
local function clone_input(input_bfr)
  local input_file = vim.fn.expand("%:p:h") .. "/.input"
  local file = io.open(input_file, "w")
  if file then
    local lines = vim.api.nvim_buf_get_lines(input_bfr, 0, -1, false)
    file:write(table.concat(lines, "\n"))
    file:flush()
    file:close()
  end
end

-- bufs - {input, output}




-- timeout jobs at 5s with gtimeout

local jobs = {
  { "crun", "main.cpp" },
  { "prun", "main.py" },
}
local projectNames = {
  "algorithms",

}
local function show_split(split, main_buf)
  split:mount()

  vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
    buffer = main_buf,
    callback = function()
      split:unmount()
    end
  })
end

local function create_splits(main)
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
local function close_other_buffers(main)
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    local exception = buf == main
    if not exception then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  create_splits(main)
end
local function run_main(job, bufs)
  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    buffer = bufs.input,
    callback = function()
      clone_input(bufs.input)
    end
  })
  vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    buffer = bufs.main,
    callback = function()
      close_other_buffers(bufs.main)
    end

  })
  -- Start the job
  return function()
    job_id = vim.fn.jobstart(job, {
      on_stdout = on_stdout,
      on_exit = on_exit(bufs.output),
      on_error = on_stdout,
    })
    output_lines = {}
  end
end
local function create_job_command(job)
  vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    pattern = { job[2] },
    callback = function()
      local projectName = vim.fn.expand("%:p:h:t")

      local isRegisteredProject = false
      for _, name in ipairs(projectNames) do
        if name == projectName then
          isRegisteredProject = true
        end
      end
      if not isRegisteredProject then
        return
      end
      local main_file = vim.api.nvim_get_current_buf()


      vim.api.nvim_command("Copilot disable")


      vim.keymap.set("n", "<leader>x", run_main(job, create_splits(main_file)),
        { silent = true, desc = "Run main.cpp" })
    end,
    group = group
  })
end

for _, job in ipairs(jobs) do
  create_job_command(job)
end
