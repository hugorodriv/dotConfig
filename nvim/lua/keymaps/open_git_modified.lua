-- Open all git-modified/added files as buffers (no tabs), keep focus in current window
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

        -- Include tracked modified/added files and brand new untracked files; skip deletes.
        if status == "??" or status:match("[MARC]") then
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

    Snacks.bufdelete.all()
    if vim.bo[0].modified then
        return
    end

    -- Open first file in current window, add the rest to buffer list
    for i, f in ipairs(files) do
        local ef = vim.fn.fnameescape(f)
        if i == 1 then
            vim.cmd("edit " .. ef)
        else
            vim.cmd("badd " .. ef) -- adds to :ls without changing the current window
        end
    end

    -- Remove the placeholder listed buffer that can be left behind after reloading Git files.
    Snacks.bufdelete(function(buf)
        return vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and not vim.bo[buf].modified and vim.api.nvim_buf_get_name(buf) == ""
    end)

    vim.notify(("Opened %d files into buffers"):format(#files), vim.log.levels.INFO, { title = "Git" })
end, { desc = "Open all git-modified files" })
