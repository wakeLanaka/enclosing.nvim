local M = {}

local enclosings = {
  "{",
  "(",
  "[",
  "\"",
}

local counter_enclosings = {
  "}",
  ")",
  "]",
  "\"",
}

M.contains_value = function(array, value)
  for _, v in pairs(array) do
    if value == v then
      return true
    end
  end
  return false
end

M.enclosing_mapping = function(character)
  for i in pairs(enclosings) do
    if character == enclosings[i] then
      return counter_enclosings[i]
    elseif character == counter_enclosings[i] then
      return enclosings[i]
    end
  end
end

M.get_used_enclosings = function(current_line)
  local entries = {}
  for i = 1, #current_line do
    local character = current_line:sub(i,i)
    if M.contains_value(enclosings, character) and not M.contains_value(entries, M.enclosing_mapping(character)) then
      table.insert(entries, character)
    elseif M.contains_value(counter_enclosings, character) then
      for j = #entries, 0, -1 do
        if entries[j] == M.enclosing_mapping(character) then
          table.remove(entries, j)
          break
        end
      end
    end
  end
  return entries
end

M.append_enclosings = function(line, entries)
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
  local new_line = line
  for i = 1, #entries do
    local enclosing = entries[i]
    new_line = new_line:sub(1, cursor_col) .. tostring(M.enclosing_mapping(enclosing)) .. new_line:sub(cursor_col + 1)
  end
  return new_line
end

return M
