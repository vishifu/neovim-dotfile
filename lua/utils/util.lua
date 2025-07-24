-- Utilities functions for config dotfile

local M = {}

-- local function to create a buffer opts noremap for keymap
local function bufopts(bufnr, desc, nowait)
  -- in default if `nowait` is nil it will be true, otherwise it can be true/false
  nowait = (nowait ~= nil) and nowait or true
  return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = nowait }
end

-- local function to create a opts noremap for keymap
local function opts(desc, nowait)
  nowait = (nowait ~= nil) and nowait or true
  return { desc = desc, noremap = true, silent = true, nowait = nowait }
end

-- bindings noremap
function M.bind_noremap(mode, lhs, rhs, desc, nowait)
  local opts = opts(desc, nowait)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- binding noremap into buffer
function M.bind_buf_noremap(mode, lhs, rhs, bufnr, desc, nowait)
  local opts = bufopts(bufnr, desc, nowait)
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.debug_log(msg)
  local file = io.open(vim.fn.stdpath("log") .. "./nvim_debug.log", "a")
  if file then
    file:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
    file:close()
  end
end

-- format display
local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match("[^/]+$")

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

function M.display_path(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == "" then
    return filename
  else
    return filename .. " ~ " .. stripped_path
  end
end

return M
