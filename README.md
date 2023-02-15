# Enclosing

A plugin to close enclosings on the same line.

## Usage

#### Close the enclosings of the current file
```lua
  vim.keymap.set("i", "<C-l>", "<cmd>lua require('enclosing').close_enclosing()<cr>")

```
