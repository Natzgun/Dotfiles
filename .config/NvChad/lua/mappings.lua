require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Grupo CMake: Prefijo <leader> + k

map("n", "<leader>kb", "<cmd>CMakeBuild<CR>", { desc = " CMake Build" })
map("n", "<leader>kr", "<cmd>CMakeRun<CR>", { desc = " CMake Run" })
map("n", "<leader>kc", "<cmd>CMakeClean<CR>", { desc = " CMake Clean" })
map("n", "<leader>kh", "<cmd>CMakeCloseRunner<CR>", { desc = "CM Hide Runner" })
map("n", "<leader>ko", "<cmd>CMakeOpenRunner<CR>", { desc = "CM Open Runner" })
map("n", "<leader>ks", "<cmd>CMakeStopRunner<CR>", { desc = "CM Stop Runner" })

--  Terminal mode  --
map("t", "jk", "<C-\\><C-n>", { desc = "Terminal Normal Mode" })
