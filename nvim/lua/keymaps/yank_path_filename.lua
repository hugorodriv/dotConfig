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
