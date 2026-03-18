vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })

vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
