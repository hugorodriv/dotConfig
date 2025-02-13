-- Move line up
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down", noremap = true, silent = true })
-- Move line down
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line up", noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down", noremap = true, silent = true })
