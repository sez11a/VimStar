-- lua/vimstar/blocks.lua
-- Persistent WordStar-style blocks for VimStar

local M = {}

local ns = vim.api.nvim_create_namespace("VimStarBlocks")
local state = {}  -- per-buffer state

local function get_buf_key(buf)
  return buf or vim.api.nvim_get_current_buf()
end

local function ensure_state(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not state[buf] then
    state[buf] = {
      begin_id = nil,   -- extmark id
      end_id = nil,
      source_id = nil,  -- for ^QV after move
      visible = true,
      column_mode = false,
    }
  end
  return state[buf]
end

local function clear_extmark(buf, id)
  if id then
    pcall(vim.api.nvim_buf_del_extmark, buf, ns, id)
  end
end

local function get_mark_pos(buf, id)
  if not id then return nil end
  local mark = vim.api.nvim_buf_get_extmark_by_id(buf, ns, id, { details = true })
  if mark and #mark > 0 then
    return { row = mark[1], col = mark[2] }
  end
  return nil
end

function M.mark_begin()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local cursor = vim.api.nvim_win_get_cursor(0)

  clear_extmark(buf, s.begin_id)
  s.begin_id = vim.api.nvim_buf_set_extmark(buf, ns, cursor[1] - 1, cursor[2], {
    id = s.begin_id,
    right_gravity = false,
  })
  M.update_highlight(buf)
  vim.notify("Block begin marked", vim.log.levels.INFO)
end

function M.mark_end()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local cursor = vim.api.nvim_win_get_cursor(0)

  clear_extmark(buf, s.end_id)
  s.end_id = vim.api.nvim_buf_set_extmark(buf, ns, cursor[1] - 1, cursor[2], {
    id = s.end_id,
    right_gravity = true,
  })
  M.update_highlight(buf)
  vim.notify("Block end marked", vim.log.levels.INFO)
end

function M.update_highlight(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)

  -- Clear previous highlight extmarks (we'll use a dedicated range one if needed)
  -- For simplicity, we'll set a range highlight on the end mark or use a separate one
  -- Alternative: use vim.highlight.range for quick updates, but extmark range is more persistent

  local begin_pos = get_mark_pos(buf, s.begin_id)
  local end_pos = get_mark_pos(buf, s.end_id)

  if not (begin_pos and end_pos and s.visible) then
    return
  end

  -- Simple range highlight using extmark (reuses Visual)
  vim.api.nvim_buf_set_extmark(buf, ns, begin_pos.row, begin_pos.col, {
    end_row = end_pos.row,
    end_col = end_pos.col,
    hl_group = "Visual",
    priority = 150,
    strict = false,
  })
end

function M.toggle_visibility()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  s.visible = not s.visible
  M.update_highlight(buf)
  vim.notify("Block display " .. (s.visible and "ON" or "OFF"), vim.log.levels.INFO)
end

function M.toggle_column_mode()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  s.column_mode = not s.column_mode
  vim.notify("Column mode " .. (s.column_mode and "ON" or "OFF"), vim.log.levels.INFO)
end

local function get_block_region(buf, begin_pos, end_pos, column_mode)
  if not (begin_pos and end_pos) then 
    print("BLOCK DEBUG: No valid begin/end positions")
    vim.notify("No valid positions", vim.log.levels.WARN)
    return {}, nil 
  end

  -- Normalize so begin is before end
  local start_row, start_col = begin_pos.row, begin_pos.col
  local end_row, end_col = end_pos.row, end_pos.col
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, start_col, end_row, end_col = end_row, end_col, start_row, start_col
  end

  local text = {}
  if column_mode then
    -- TODO: rectangular support (keep getregion for now or implement later)
    text = vim.fn.getregion({start_row + 1, start_col + 1}, {end_row + 1, end_col + 1}, { type = "b", trim = false })
  else
    -- Charwise: use nvim_buf_get_text (very reliable)
    text = vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})
  end

  return text, column_mode and "b" or "c"
end

local function insert_text_at_cursor(text, regtype)
  if #text == 0 then 
    vim.notify("No text to insert", vim.log.levels.WARN)
    return 
  end
  vim.api.nvim_put(text, regtype, true, true)  -- after=true, follow=true
  vim.notify("Inserted " .. #text .. " lines", vim.log.levels.INFO)
end

function M.copy_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.begin_id)
  local end_pos = get_mark_pos(buf, s.end_id)

  local text, regtype = get_block_region(buf, begin_pos, end_pos, s.column_mode)
  insert_text_at_cursor(text, regtype)

  M.update_highlight(buf)
end

function M.move_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.begin_id)
  local end_pos = get_mark_pos(buf, s.end_id)

  if not (begin_pos and end_pos) then
    vim.notify("No block marked", vim.log.levels.WARN)
    return
  end

  local text, regtype = get_block_region(buf, begin_pos, end_pos, s.column_mode)

  -- Remember source
  s.source_id = vim.api.nvim_buf_set_extmark(buf, ns, begin_pos.row, begin_pos.col, { id = s.source_id })

  -- Delete original (safe columns)
  local lines = vim.api.nvim_buf_get_lines(buf, end_pos.row, end_pos.row + 1, true)
  local max_col = lines[1] and #lines[1] or 0
  vim.api.nvim_buf_set_text(buf, begin_pos.row, begin_pos.col, end_pos.row, math.min(end_pos.col, max_col), {})

  -- Insert
  insert_text_at_cursor(text, regtype)

  -- Re-mark roughly at new location
  local new_cursor = vim.api.nvim_win_get_cursor(0)
  local buf_line_count = vim.api.nvim_buf_line_count(buf)
  local start_line = math.max(1, math.min(new_cursor[1] - #text + 1, buf_line_count))

  vim.api.nvim_win_set_cursor(0, { start_line, 0 })
  M.mark_begin()
  vim.api.nvim_win_set_cursor(0, new_cursor)

  M.update_highlight(buf)
end

function M.delete_block()
  -- (unchanged from previous safe version)
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.begin_id)
  local end_pos = get_mark_pos(buf, s.end_id)

  if begin_pos and end_pos then
    local lines = vim.api.nvim_buf_get_lines(buf, end_pos.row, end_pos.row + 1, true)
    local max_col = lines[1] and #lines[1] or 0
    vim.api.nvim_buf_set_text(buf, begin_pos.row, begin_pos.col, end_pos.row, math.min(end_pos.col, max_col), {})
  end
  M.clear_block(buf)
  vim.notify("Block deleted", vim.log.levels.INFO)
end

function M.clear_block(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  clear_extmark(buf, s.begin_id)
  clear_extmark(buf, s.end_id)
  clear_extmark(buf, s.source_id)
  s.begin_id, s.end_id, s.source_id = nil, nil, nil
end

function M.jump_to_begin()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.begin_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

function M.jump_to_end()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.end_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

function M.jump_to_source()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.source_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

-- Auto-update highlight on certain events (optional)
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if state[buf] then
      M.update_highlight(buf)
    end
  end,
})

return M
