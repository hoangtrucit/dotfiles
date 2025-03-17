local keymap = vim.keymap
local opts = { noremap = true, silent = true, remap = true }

keymap.set("n", "x", '"_x')
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<leader>p", '"_dP')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":qa<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
-- keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
-- keymap.set("n", "<Leader>e", ":NvimTreeToggle<Return>", opts)
--
--keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", {})
-- keymap.set("n", "<leader>e", ":Neotree reveal<CR>", {})

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<a-tab>", ":tabnext<Return>", opts)
keymap.set("n", "tn", ":tabnew<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)
-- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)
keymap.set("n", "<tab>", ":bnext<Return>", opts)
keymap.set("n", "<D-;>", "<C-w>w", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")
keymap.set("n", "<C-S-y>", ":Cfp<CR>")

-- cursor moving
-- keymap.set("n", "ff", ":HopWord<CR>")

-- comment code
keymap.set("n", "<leader>/", ":normal gcc<CR><DOWN>")
keymap.set("n", "<leader>lg", "<cmd>lazygit<cr>")
keymap.set("v", "<leader>/", "<Esc>:normal gvgc<CR>")
keymap.set("n", "<leader>/", "<Esc>:normal gcc<CR>")
keymap.set("n", "<D-/>", "<Esc>:normal gcc<CR>")
keymap.set("v", "<D-/>", "<Esc>:normal gvgc<CR>")

-- dashboard
keymap.set("n", "<leader>cd", ":Dashboard<CR>")
keymap.set("n", "<C-;>", ":wincmd w<CR>")
keymap.set("n", "<leader>cd", ":lua Snacks.dashboard()<CR>")

keymap.set("i", "<D-i>", "<C-space>", { noremap = false, remap = true })

-- close buffer
-- vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>close<CR>", { desc = "Close Buffer" })

-- Diagnostics
-- keymap.set("n", "<D-j>", function()
-- 	vim.diagnostic.goto_next()
-- end, opts)
--
-- keymap.set("n", "<M-j>", function()
-- 	vim.diagnostic.goto_next()
-- end, opts)

-- keymap.set("n", "zR", require("ufo").openAllFolds)
-- keymap.set("n", "zM", require("ufo").closeAllFolds)
-- keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
-- keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

keymap.set("v", "zj", "<CMD>VisualDuplicate +1<CR>") -- closeAllFolds == closeFoldsWith(0)
keymap.set("n", "zj", "<CMD>LineDuplicate +1<CR>") -- closeAllFolds == closeFoldsWith(0)

keymap.set("n", "<leader>gn", ":lua require('neogen').generate()<CR>", opts)
keymap.set("n", "<leader>cp", ":lua require('project').create_floating_window()<CR>", opts)

keymap.set("n", "<C-r>", function()
	require("neogen").generate()
end)

--keymap.set("t", "<C-w>", "<C-\\><C-n>", { silent = true })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
