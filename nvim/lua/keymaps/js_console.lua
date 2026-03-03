-- Transforms keys into actual terminal keys (needed for example for <ESC>)
local tc = function(keys)
    return vim.api.nvim_replace_termcodes(keys, true, true, true)
end
-- @d (with selected variable) inserts console.log("debug variable", variable)
vim.fn.setreg("d", tc([["zyoconsole.log("debug: <C-r>z", <C-r>z);<Esc>==]]))

-- @s (with selected variable) inserts console.log("debug variable")
vim.fn.setreg("s", tc([["zyoconsole.log("debug: <C-r>z"<Esc>==]]))
