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
    if v == value or v[1] == value then
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
      table.insert(entries, {character, i})
    elseif M.contains_value(counter_enclosings, character) then
      for j = #entries, 1, -1 do
        if entries[j][1] == M.enclosing_mapping(character) then
          table.remove(entries, j)
          break
        end
      end
    end
  end
  return entries
end

M.append_enclosings = function(line, entries, cursor_col)
  local new_line = line
  for i = 1, #entries do
    local enclosing_col = entries[i][2]
    if(enclosing_col <= cursor_col) then
      local enclosing = entries[i][1]
      new_line = new_line:sub(1, cursor_col) .. tostring(M.enclosing_mapping(enclosing)) .. new_line:sub(cursor_col + 1)
    end
  end
  return new_line
end

return M
