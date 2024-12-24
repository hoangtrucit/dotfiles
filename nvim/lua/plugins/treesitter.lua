return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- branch = "master",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"css",
				"gitignore",
				"graphql",
				"http",
				"json",
				"scss",
				"sql",
				"vim",
				"lua",
				"python",
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		},
		config = function(_, opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.printf = {
				install_info = {
					url = "https://github.com/pstuifzand/tree-sitter-printf",
					files = { "src/parser.c" },
				},
				filetype = "printf",
			}
		end,
	},
}
