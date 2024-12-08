return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			light_style = "light", -- The theme is used when the background is set to light
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
			cache = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			day_brightness = 0.1,
			on_highlights = function(hl, c)
				hl.Keyword = {
					fg = "#9d7cd8",
					italic = true,
				}
				-- hl.Type = {
				-- 	fg = "#c0caf5",
				-- }
				hl["@lsp.type.event"] = {
					fg = "#db4b4b",
				}
				-- hl['@lsp.type.namespace']                    = {
				-- 	fg = "#db4b4b"
				-- }
				hl["@lsp.type.property"] = {
					fg = "#60acd8",
				}
				hl["@lsp.type.operator"] = {
					fg = "#db4b4b",
				}
				hl["@lsp.type.struct"] = {
					fg = "#9d7cd8",
				}
				-- hl['@lsp.type.type']                         = {
				-- 	fg = "#c0caf5"
				-- }
				-- hl['@lsp.type.typeParameter']                = {
				-- 	fg = "#c0caf5"
				-- }
				-- hl['@lsp.type.variable']                     = {
				-- 	fg = "#c0caf5"
				-- }
				-- hl['@lsp.type.parameter'] = {
				-- 	fg = "#db4b4b"
				-- }
				hl["@lsp.mod.async"] = {
					fg = "#7aa2f7",
				}
			end,
			on_colors = function(colors)
				colors.green = "#8eb960"
				-- colors.blue = "#60acd8"
				-- colors.blue = "#c0caf5"
				colors.blue1 = "#c0caf5"
				-- colors.blue2 = "#c0caf5"
				-- colors.blue5 = "#c0caf5"
				-- colors.blue6 = "#c0caf5"
				-- colors.blue7 = "#c0caf5"
				-- colors.blue2 = "#7dcfff"
				-- colors.blue5 = "#7dcfff"
			end,
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				palette = {
					-- Override the builtin palette per variant
					-- moon = {
					--     base = '#18191a',
					--     overlay = '#363738',
					-- },
				},

				highlight_groups = {
					-- Comment = { fg = "foam" },
					-- VertSplit = { fg = "muted", bg = "muted" },
				},

				before_highlight = function(group, highlight, palette)
					-- Disable all undercurls
					-- if highlight.undercurl then
					--     highlight.undercurl = false
					-- end
					--
					-- Change palette colour
					-- if highlight.fg == palette.pine then
					--     highlight.fg = palette.foam
					-- end
				end,
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
}
