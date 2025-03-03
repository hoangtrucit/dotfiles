return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		cmdline = {
			enabled = true,
			keymap = nil, -- Inherits from top level `keymap` config when not set
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" or type == "@" then
					return { "cmdline" }
				end
				return {}
			end,
			completion = {
				trigger = {
					show_on_blocked_trigger_characters = {},
					show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
				},
				menu = {
					auto_show = nil, -- Inherits from top level `completion.menu.auto_show` config when not set
					draw = {
						columns = { { "label", "label_description", gap = 1 } },
					},
				},
			},
		},
		completion = {
			keyword = { range = "full" },

			accept = { auto_brackets = { enabled = true } },

			list = { selection = { preselect = true, auto_insert = true } },

			menu = {
				enabled = true,
			},
		},
		signature = { enabled = true },
		keymap = {
			preset = "super-tab",
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer', "cmdline" },
		},
	},
}
