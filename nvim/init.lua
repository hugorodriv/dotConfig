-- bootstrap lazy.nvim, lazyvim and your plugins
require("config.lazy")
require("config.lualine")
require("lint").linters_by_ft = {
    bash = { "shellcheck" },
    sh = { "shellcheck" },
}

-- Dont change root dir
require("lazyvim.util").get_root = vim.loop.cwd

vim.g.snacks_animate = false --Disable animations globally

-- Colorscheme
vim.cmd("colorscheme kanagawa")

-- For some reason the ctrl-jk keys only work when "source $MYVIMRC" command is run. This is a janky way of doing it automatically
-- not directly sourcing $MYVIMRC because       1) it's probably stupid       2) kinda breaks the colorscheme (probably bc it's stupid)
vim.api.nvim_create_autocmd("BufAdd", { command = "source ~/.config/nvim/lua/config/lineshifter.lua" })

-- Custom macros
-- Transforms keys into actual terminal keys (needed for example for <ESC>)
local tc = function(keys)
    return vim.api.nvim_replace_termcodes(keys, true, true, true)
end
-- @d (with selected variable) inserts console.log("debug variable", variable)
vim.fn.setreg("d", tc([["zyoconsole.log("debug: <C-r>z", <C-r>z);<Esc>==]]))

-- @s (with selected variable) inserts console.log("debug variable")
vim.fn.setreg("s", tc([["zyoconsole.log("debug: <C-r>z"<Esc>==]]))

-- -- Normal: @D
-- vim.fn.setreg("D", [["zyiw<Esc>oconsole.log("debug: <C-r>z", <C-r>z);<Esc>]])

-- Tabs identation
vim.o.autoindent = true
vim.o.expandtab = false
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Spaces
-- vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
-- vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
-- vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
-- vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Yank current filename
vim.keymap.set("n", "<leader>yf", function()
    local fname = vim.fn.expand("%:t") -- just the file name
    vim.fn.setreg("+", fname)
    vim.notify("filename yanked: " .. fname, vim.log.levels.INFO, { title = "Clipboard" })
end, { desc = "Yank filename" })
-- Yank full path of current file
vim.keymap.set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p") -- full path
    if path == "" then
        vim.notify("No file path (empty buffer)", vim.log.levels.WARN, { title = "Clipboard" })
        return
    end
    vim.fn.setreg("+", path)
    vim.notify("path yanked: " .. path, vim.log.levels.INFO, { title = "Clipboard" })
end, { desc = "Yank full file path" })

-- Open all git-modified files, each in its own tab
vim.keymap.set("n", "<leader>og", function()
    local lines = vim.fn.systemlist({ "git", "status", "--porcelain" })
    if vim.v.shell_error ~= 0 then
        vim.notify("Not a git repository (or git error)", vim.log.levels.ERROR, { title = "Git" })
        return
    end

    local files_set = {}
    for _, l in ipairs(lines) do
        -- format: "XY path" or "R? old -> new"
        local status = l:sub(1, 2)
        local rest = vim.trim(l:sub(4))
        local arrow = rest:find(" -> ", 1, true)
        local path = arrow and rest:sub(arrow + 4) or rest

        -- Include Added or Modified in either column; skip deletes/untracked
        if status:match("[MA]") then
            files_set[path] = true
        end
    end

    local files = {}
    for f, _ in pairs(files_set) do
        if f ~= "" then
            table.insert(files, f)
        end
    end
    table.sort(files)

    if #files == 0 then
        vim.notify("No modified/added files found", vim.log.levels.INFO, { title = "Git" })
        return
    end

    local start_tab = vim.fn.tabpagenr()
    for i, f in ipairs(files) do
        local ef = vim.fn.fnameescape(f)
        if i == 1 then
            vim.cmd("edit " .. ef)
        else
            vim.cmd("tabnew " .. ef)
        end
    end
    -- Return to the original tab to avoid moving the user's focus
    vim.cmd(tostring(start_tab) .. "tabnext")

    vim.notify(("Opened %d git-modified files in tabs"):format(#files), vim.log.levels.INFO, { title = "Git" })
end, { desc = "Open all git-modified files in tabs" })

-- Ctr U/D page cenetring
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving down half-page" })
vim.keymap.set("n", "G", "Gzz", { desc = "Center cursor after moving down half-page" })

-- YankyPut
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- editor.dial
vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("v", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("v", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("v", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("v", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)
