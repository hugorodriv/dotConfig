-- bootstrap lazy.nvim, lazyvim and your plugins
require("config.lazy")
require("config.lualine")
require("lint").linters_by_ft = {
    bash = { "shellcheck" },
    sh = { "shellcheck" },
}

------------ Macros ------------

-- Custom
require("keymaps.yank_path_filename")
require("keymaps.js_console")
require("keymaps.open_git_modified")
require("keymaps.center-page-ctrl-d-u")

-- Plugin config
require("keymaps.plugins.editor-dial")
require("keymaps.plugins.yanky-put")

--------- Config ---------

-- Dont change root dir
require("lazyvim.util").get_root = vim.loop.cwd

--Disable animations globally
vim.g.snacks_animate = false

-- Colorscheme
vim.cmd("colorscheme kanagawa")

-- Tabs identation
vim.o.autoindent = true
vim.o.expandtab = false
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
