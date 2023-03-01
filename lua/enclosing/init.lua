-- TODO: problem when enclosings are in a string
local utils = require("enclosing.utils")
local M = {}

M.close_enclosing = function ()

  local current_line = vim.api.nvim_get_current_line()

  local entries = utils.get_used_enclosings(current_line)

  local new_line = utils.append_enclosings(current_line, entries)

  vim.api.nvim_set_current_line(new_line)

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'i', false)
end

return M
