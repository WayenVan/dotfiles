M = {}
-- =============================================================
-- LSP 结构 -> picker 条目
-- =============================================================
function M.LspToPicker(lsp_result, opts)
  opts = opts or {}
  local line_offset = opts.line_offset or 1 -- LSP 行 +1 → picker 行
  local col_offset = opts.col_offset or 0 -- LSP 列 +1 → picker 列
  local file = vim.uri_to_fname(lsp_result.targetUri)
  local s = lsp_result.targetSelectionRange.start
  local e = lsp_result.targetSelectionRange["end"]

  local picker = {
    _path = file,
    file = file,
    pos = { s.line + line_offset, s.character + col_offset },
    end_pos = { e.line + line_offset, e.character + col_offset },
    buf = vim.fn.bufnr(file) or vim.fn.bufadd(file),
    idx = 0,
    score = 1000,
    match_tick = 0,
    -- 从缓冲区读取当前行内容（若无缓冲区则回退）
    line = vim.api.nvim_buf_get_lines(vim.fn.bufnr(file), e.line, e.line + 1, false)[1] or "",
    -- 保持高亮数据简单或忽略
    _ = { ts = {} },
  }
  -- text 通常为 "路径 行内容"
  picker.text = picker.file .. " " .. picker.line

  return picker
end

-- =============================================================
-- picker 条目 -> LSP 结构
-- =============================================================
function M.PickerToLsp(picker_item, opts)
  opts = opts or {}
  local line_offset = opts.line_offset or -1 -- picker 行 -1 → LSP 行
  local col_offset = opts.col_offset or 0 -- picker 列 -1 → LSP 列

  if not picker_item.file then
    return {}
  end

  local s_line = picker_item.pos[1] + line_offset
  local s_char = picker_item.pos[2] + col_offset
  local e_line = picker_item.end_pos[1] + line_offset
  local e_char = picker_item.end_pos[2] + col_offset

  return {
    client_name = "", -- 可根据需要填写
    originSelectionRange = {
      start = { line = 0, character = 0 },
      ["end"] = { line = 0, character = 0 },
    },
    targetUri = vim.uri_from_fname(picker_item.file),
    targetRange = {
      start = { line = s_line, character = s_char },
      ["end"] = { line = e_line, character = e_char },
    },
    targetSelectionRange = {
      start = { line = s_line, character = s_char },
      ["end"] = { line = e_line, character = e_char },
    },
  }
end

return M
