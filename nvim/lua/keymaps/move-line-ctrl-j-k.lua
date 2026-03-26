vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })

vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
