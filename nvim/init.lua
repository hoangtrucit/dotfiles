if pcall(require, "nvim-treesitter.parsers") then
	local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
	parser_config.printf = {
		install_info = {
			url = "https://github.com/pstuifzand/tree-sitter-printf",
			files = { "src/parser.c" },
		},
		filetype = "printf",
	}
end

if vim.loader then
	vim.loader.enable()
end

-- _G.dd = function(...)
-- 	require("util.debug").dump(...)
-- end
-- vim.print = _G.dd

require("config.lazy")
require('config.remaps')

-- local lsp_zero = require('lsp-zero')
-- local abc = lsp_zero.gopls()
-- print(abc)
