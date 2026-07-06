-- lua/vimstar/blocks.lua
-- Persistent WordStar-style blocks for VimStar

local M = {}

local ns = vim.api.nvim_create_namespace("VimStarBlocks")
local highlight_ns = vim.api.nvim_create_namespace("VimStarBlockHighlight")
local state = {}

local function ensure_state(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not state[buf] then
    state[buf] = {
      current = { begin_id = nil, end_id = nil },
      previous = { begin_id = nil, end_id = nil },
      source_id = nil,
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

local function clear_all_highlights(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buf, highlight_ns, 0, -1)
end

function M.mark_begin()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)

  -- Clear old begin marker ONLY if we are re-marking the current block (no end yet)
  if s.current.begin_id and not s.current.end_id then
    clear_extmark(buf, s.current.begin_id)
    clear_all_highlights(buf)
  end

  -- Old current becomes previous
  s.previous = s.current
  s.current = { begin_id = nil, end_id = nil }

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  s.current.begin_id = vim.api.nvim_buf_set_extmark(buf, ns, row, col, {
    right_gravity = false,
    virt_text = { { " ⟪B⟫", "Comment" } },
    virt_text_pos = "inline",
  })

  M.update_highlight(buf)
end

function M.mark_end()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local cursor = vim.api.nvim_win_get_cursor(0)

  s.current.end_id = vim.api.nvim_buf_set_extmark(buf, ns, cursor[1] - 1, cursor[2], {
    right_gravity = true,
  })

  -- Remove begin marker
  if s.current.begin_id then
    local bpos = get_mark_pos(buf, s.current.begin_id)
    if bpos then
      clear_extmark(buf, s.current.begin_id)
      s.current.begin_id = vim.api.nvim_buf_set_extmark(buf, ns, bpos.row, bpos.col, {
        right_gravity = false,
      })
    end
  end

  M.update_highlight(buf)
end

function M.toggle_previous_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  s.current, s.previous = s.previous, s.current

  clear_all_highlights(buf)
  M.update_highlight(buf)

end

function M.update_highlight(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)


  clear_all_highlights(buf)

  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)


  if not (begin_pos and end_pos and s.visible) then
    return
  end

  vim.api.nvim_buf_set_extmark(buf, highlight_ns, begin_pos.row, begin_pos.col, {
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
end

function M.copy_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)

  local text, regtype = get_block_region(buf, begin_pos, end_pos, s.column_mode)
  insert_text_at_cursor(text, regtype)

  M.update_highlight(buf)
end

function M.unmark_block()
  local buf = vim.api.nvim_get_current_buf()
  M.clear_block(buf, false)
  clear_all_highlights(buf)
end

function M.move_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local c = s.current
  local begin_pos = get_mark_pos(buf, c.begin_id)
  local end_pos = get_mark_pos(buf, c.end_id)

  if not (begin_pos and end_pos) then
    vim.notify("No block marked", vim.log.levels.WARN)
    return
  end

  local text, regtype = get_block_region(buf, begin_pos, end_pos, s.column_mode)
  if #text == 0 then return end

  -- Remember source for Space-qv
  s.source_id = vim.api.nvim_buf_set_extmark(buf, ns, begin_pos.row, begin_pos.col, { id = s.source_id })

  -- Delete the original block
  vim.api.nvim_buf_set_text(buf, begin_pos.row, begin_pos.col, end_pos.row, end_pos.col, {})

  -- Record paste position *right before paste*
  local paste_start = vim.api.nvim_win_get_cursor(0)

  -- Paste
  insert_text_at_cursor(text, regtype)

  -- Cursor after paste
  local paste_end = vim.api.nvim_win_get_cursor(0)

  -- Clear old block (the one we moved from)
  M.clear_block(buf, true)   -- preserve source for qv

  -- Re-mark the pasted block as the new current
  vim.api.nvim_win_set_cursor(0, {paste_start[1], paste_start[2]})
  M.mark_begin()

  vim.api.nvim_win_set_cursor(0, {paste_end[1], paste_end[2]})
  M.mark_end()

end

function M.delete_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)

  if begin_pos and end_pos then
    local lines = vim.api.nvim_buf_get_lines(buf, end_pos.row, end_pos.row + 1, true)
    local max_col = lines[1] and #lines[1] or 0
    vim.api.nvim_buf_set_text(buf, begin_pos.row, begin_pos.col, end_pos.row, math.min(end_pos.col, max_col), {})
  end
  M.clear_block(buf)
end

function M.clear_block(buf, preserve_source)
  buf = buf or vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  clear_extmark(buf, s.current.begin_id)
  clear_extmark(buf, s.current.end_id)
  if not preserve_source then
    clear_extmark(buf, s.source_id)
    s.source_id = nil
  end
  s.current.begin_id, s.current.end_id = nil, nil
  clear_all_highlights(buf)
end

function M.jump_to_begin()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.current.begin_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

function M.jump_to_end()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.current.end_id)
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

-- Status for lualine / statusline
function M.get_status()
  local buf = vim.api.nvim_get_current_buf()
  local s = state[buf]
  if not s then return "" end

  local has_block = s.current.begin_id and s.current.end_id
  if not has_block then return "" end

  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)

  if begin_pos and end_pos then
    local lines = end_pos.row - begin_pos.row + 1
    return string.format("Block:%d", lines)  -- e.g. "Block:5"
  end
  return "Block"
end

return M
