require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- load lazygit
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })

-- Move lines
map("x", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("x", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Toggle Term
-- map('i', '<A-3>', '<Esc>:ToggleTerm<CR>', opts)
-- map('n', '<A-3>', ':ToggleTerm<CR>', opts)
--
-- Comment
map("n", "gc", "<Plug>(comment_toggle_linewise)", opts)
map("x", "gc", "<Plug>(comment_toggle_linewise_visual)", opts)
map("n", "gb", "<Plug>(comment_toggle_blockwise)", opts)
map("x", "gb", "<Plug>(comment_toggle_blockwise_visual)", opts)
