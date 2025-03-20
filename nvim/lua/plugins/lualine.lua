return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = true,
	lazy = false,
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	config = function()
		require("lualine").setup({
			options = {
				-- theme = "ayu_dark",
				theme = "rose-pine",
			},
			sections = {
				lualine_a = {
					{
						"fileformat",
						symbols = {
							unix = "", -- e712
							dos = "", -- e70f
							mac = "", -- e711
						},
					},
					"mode",
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", "filetype" },
				lualine_x = {
					"encoding",
					-- "filetype",
				},
				lualine_y = { "lsp_status" },
				lualine_z = { "location", "tabs" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
