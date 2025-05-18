return {
	"stevearc/aerial.nvim",
	event = "LazyFile",
	opts = function()
		local icons = vim.deepcopy(LazyVim.config.icons.kinds)

		-- HACK: fix lua's weird choice for `Package` for control
		-- structures like if/else/for/etc.
		icons.lua = { Package = icons.Control }

		---@type table<string, string[]>|false
		-- local filter_kind = false
		-- if LazyVim.config.kind_filter then
		-- 	filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
		-- 	filter_kind._ = filter_kind.default
		-- 	filter_kind.default = nil
		-- end
		-- local filter_kind1 = vim.deepcopy(LazyVim.config.kind_filter)
		-- print(vim.fn.json_encode(filter_kind1))
		local filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Method",
			"Interface",
			"Module",
			"Method",
			"Struct",
			"Function",
			"Constant",
		}

		local opts = {
			attach_mode = "window",
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
				min_width = 150,
				default_direction = "float",
			},
			float = {
				-- Controls border appearance. Passed to nvim_open_win
				border = "rounded",

				-- Determines location of floating window
				--   cursor - Opens float on top of the cursor
				--   editor - Opens float centered in the editor
				--   win    - Opens float centered in the window
				relative = "editor",

				-- These control the height of the floating window.
				-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_height and max_height can be a list of mixed types.
				-- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
				max_height = 0.9,
				height = nil,
				min_height = { 27, 0.4 },

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
			manage_folds = false,
			link_folds_to_tree = false,
			link_tree_to_folds = false,
			autojump = true,
			on_attach = function(bufnr)
				local function start_up_func()
					require("aerial").tree_set_collapse_level(bufnr, 1)
				end
				local timer = vim.loop.new_timer()
				timer:start(200, 0, vim.schedule_wrap(start_up_func))
			end,
			lazy_load = true,
		}
		return opts
	end,
	keys = {
		{ "<leader>cs", "<cmd>AerialOpen<cr>", desc = "Aerial (Symbols)" },
	},
}
