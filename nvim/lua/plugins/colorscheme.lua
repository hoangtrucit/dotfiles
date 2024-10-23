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
				hl.Type = {
					fg = "#c0caf5",
				}
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
				colors.blue0 = "#60acd8"
				colors.blue1 = "#60acd8"
				-- colors.blue2 = "#7dcfff"
				-- colors.blue5 = "#7dcfff"
			end,
		},
	},
}
