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
keymap.set("n", "<leader>e", ":Neotree reveal<CR>", {})

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<a-tab>", ":tabnext<Return>", opts)
keymap.set("n", "tn", ":tabnew<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)
-- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)
keymap.set("n", "<tab>", ":bnext<Return>", opts)
keymap.set("n", "<D-;>", "<C-w>w", opts)
keymap.set("n", "<M-;>", "<C-w>w", opts)

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
keymap.set("i", "<D-.>", "<C-space>", { noremap = false, remap = true })

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
-- keymap.set("n", "<leader>cp", ":lua require('project').create_floating_window()<CR>", opts)
keymap.set("n", "<leader>cp", ":lua require('project').search_projects()<CR>", opts)

keymap.set("n", "<C-r>", function()
	require("neogen").generate()
end)

--keymap.set("t", "<C-w>", "<C-\\><C-n>", { silent = true })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("t", "<D-k>", function()
	vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear\n")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<D-k>", function()
	if vim.bo.buftype == "terminal" then
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear\n")
	end
end, { noremap = true, silent = true, desc = "Clear terminal (Cmd+K)" })

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
