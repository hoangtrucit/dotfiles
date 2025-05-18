return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		cmdline = {
			enabled = true,
			keymap = { preset = "inherit" },
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				-- if type == "/" or type == "?" then
				-- 	return { "buffer" }
				-- end
				-- Commands
				if type == ":" or type == "@" then
					return { "cmdline" }
				end
				return {}
			end,
			completion = {
				ghost = {
					enabled = true,
				},
				trigger = {
					show_on_blocked_trigger_characters = {},
					show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
				},
				menu = {
					auto_show = false, -- Inherits from top level `completion.menu.auto_show` config when not set
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
			-- preset = "super-tab",
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "cmdline", "omni" },
		},
		-- fuzzy = {
		-- 	-- Controls which implementation to use for the fuzzy matcher.
		-- 	--
		-- 	-- 'prefer_rust_with_warning' (Recommended) If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
		-- 	-- 'prefer_rust' If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
		-- 	-- 'rust' Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
		-- 	-- 'lua' Always use the Lua implementation, doesn't download any prebuilt binaries
		-- 	--
		-- 	-- See the prebuilt_binaries section for controlling the download behavior
		-- 	implementation = 'prefer_rust_with_warning',
		--
		-- 	-- Allows for a number of typos relative to the length of the query
		-- 	-- Set this to 0 to match the behavior of fzf
		-- 	-- Note, this does not apply when using the Lua implementation.
		-- 	max_typos = function(keyword) return math.floor(#keyword / 4) end,
		--
		-- 	-- Frecency tracks the most recently/frequently used items and boosts the score of the item
		-- 	-- Note, this does not apply when using the Lua implementation.
		-- 	use_frecency = true,
		--
		-- 	-- Proximity bonus boosts the score of items matching nearby words
		-- 	-- Note, this does not apply when using the Lua implementation.
		-- 	use_proximity = true,
		--
		-- 	-- UNSAFE!! When enabled, disables the lock and fsync when writing to the frecency database. This should only be used on unsupported platforms (i.e. alpine termux)
		-- 	-- Note, this does not apply when using the Lua implementation.
		-- 	use_unsafe_no_lock = false,
		--
		-- 	-- Controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
		-- 	-- You may pass a function instead of a string to customize the sorting
		-- 	sorts = {
		-- 		'exact',
		-- 		-- defaults
		-- 		'score',
		-- 		'sort_text',
		-- 	},
		--
		-- 	prebuilt_binaries = {
		-- 		-- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
		-- 		-- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
		-- 		-- Disabled by default when `fuzzy.implementation = 'lua'`
		-- 		download = true,
		--
		-- 		-- Ignores mismatched version between the built binary and the current git sha, when building locally
		-- 		ignore_version_mismatch = false,
		-- 	},
		-- }
	},
}
