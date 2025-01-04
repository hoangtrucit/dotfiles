return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source
	event = { "InsertEnter", "CmdLineEnter" },
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			cmdline = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		},
		completion = {
			list = { selection = "auto_insert" },
			accept = {
				create_undo_point = true,
				auto_brackets = { enabled = true },
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
			},
			ghost_text = { enabled = true },
		},
		signature = { enabled = true },
		keymap = {
			----preset = "enter",
			preset = "super-tab",
			cmdline = {
				preset = "super-tab",
			},
		},
	},
}
