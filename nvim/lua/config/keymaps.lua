-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override LazyVim's default <C-j>/<C-k> window navigation with line move mappings.
require("keymaps.move-line-ctrl-j-k")
