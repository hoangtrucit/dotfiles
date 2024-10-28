return {
	"stevearc/aerial.nvim",
	event = "LazyFile",
	opts = function()
		local icons = vim.deepcopy(LazyVim.config.icons.kinds)

		-- HACK: fix lua's weird choice for `Package` for control
		-- structures like if/else/for/etc.
		icons.lua = { Package = icons.Control }

		---@type table<string, string[]>|false
		local filter_kind = false
		if LazyVim.config.kind_filter then
			filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
			filter_kind._ = filter_kind.default
			filter_kind.default = nil
		end

		local opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			show_guides = true,
			layout = {
				resize_to_content = true,
				win_opts = {
					winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
					signcolumn = "yes",
					statuscolumn = " ",
				},
				max_width = { 40, 0.2 },
				min_width = 200,
				default_direction = "float",
			},
			float = {
				-- Controls border appearance. Passed to nvim_open_win
				border = "rounded",

				-- Determines location of floating window
				--   cursor - Opens float on top of the cursor
				--   editor - Opens float centered in the editor
				--   win    - Opens float centered in the window
				relative = "win",

				-- These control the height of the floating window.
				-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_height and max_height can be a list of mixed types.
				-- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
				max_height = 0.9,
				height = nil,
				min_height = { 30, 0.4 },

				override = function(conf, source_winid)
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the layout
					return conf
				end,
			},
			icons = icons,
			filter_kind = filter_kind,
      -- stylua: ignore
      guides = {
        mid_item   = "├╴",
        last_item  = "└╴",
        nested_top = "│ ",
        whitespace = "  ",
      },
		}
		return opts
	end,
	keys = {
		{ "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
	},
}
