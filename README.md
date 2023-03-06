# Enclosing

A plugin to close enclosings on the same line.

## Enclosing-Pairs

- []
- {}
- ()
- ""

## Usage

### Close the enclosings of the current line
```lua
  vim.keymap.set("i", "<C-l>", "<cmd>lua require('enclosing').close_enclosing()<cr>")
```
