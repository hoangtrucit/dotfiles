vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = "a"
vim.opt.cursorline = false
vim.opt.termguicolors = true

vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldclose = "all" -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[
nnoremap d "_d
nnoremap D "_D
nnoremap p "_p
nnoremap x "_x
nnoremap x "_x
nnoremap "*d "*d
nnoremap "*D "*D
nnoremap y "*y
nnoremap Y "*Y
vnoremap y "*y
vnoremap Y "*Y
nnoremap p "*p
nnoremap P "*P
noremap  p "*p
noremap  P "*P
vnoremap y "*y
vnoremap Y "*Y
vnoremap p "*p
vnoremap P "*P
]])

vim.cmd("source ~/.config/nvim/after/duplicate/duplicate.vim")
vim.g["duplicate-nvim-config"] = {
	visual = {
		selectAfter = true, -- true to select duplicated text
		block = true, -- true to enable block-wise duplication
	},
}

vim.api.nvim_create_user_command("Cfp", function()
	local relative_filepath = vim.fn.expand("%:.")
	vim.fn.setreg("+", relative_filepath)
end, {})
