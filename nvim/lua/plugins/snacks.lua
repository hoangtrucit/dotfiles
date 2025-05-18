return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				sections = {
					{ section = "header" },
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript.sh -e square",
						height = 5,
						padding = 1,
					},
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
					-- {
					-- 	section = "terminal",
					-- 	-- cmd = "ascii-image-converter ~/.config/nvim/logo.png -C -c",
					-- 	-- cmd = "chafa ~/.config/nvim/logo.png --format symbols --symbols vhalf; sleep .1",
					-- 	cmd = "pokemon-colorscripts -r --no-title; sleep .1",
					-- 	random = 10,
					-- 	pane = 2,
					-- 	indent = 30,
					-- 	height = 30,
					-- },
				},
				preset = {
					header = [[
	██╗  ██╗ ██████╗ ██████╗ ███████╗██╗     ██╗███████╗███████╗
	██║ ██╔╝██╔═══██╗██╔══██╗██╔════╝██║     ██║██╔════╝██╔════╝
	█████╔╝ ██║   ██║██║  ██║█████╗  ██║     ██║█████╗  █████╗
	██╔═██╗ ██║   ██║██║  ██║██╔══╝  ██║     ██║██╔══╝  ██╔══╝
	██║  ██╗╚██████╔╝██████╔╝███████╗███████╗██║██║     ███████╗
	╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝╚═╝     ╚══════╝
		 ]],
				},
			},
			words = {
				enabled = true,
				debounce = 200, -- time in ms to wait before updating
				notify_jump = false, -- show a notification when jumping
				notify_end = true, -- show a notification when reaching the end
				foldopen = true, -- open folds after jumping
				jumplist = true, -- set jump point before jumping
				modes = { "n", "i", "c" }, -- modes to show references
			},
			explorer = { enabled = true },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						layout = {
							preview = true,
							reverse = false,
							preset = "telescope",
							layout = {
								width = 180,
								-- height = 50,
							},
						},
					},
				},
			},
			scope = { enabled = true },
			scroll = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000, -- default timeout in ms
				width = { min = 40, max = 0.4 },
				height = { min = 1, max = 0.6 },
				-- editor margin to keep free. tabline and statusline are taken into account automatically
				margin = { top = 0, right = 1, bottom = 0 },
				padding = true, -- add 1 cell of left/right padding to the notification window
				sort = { "level", "added" }, -- sort by level and time
				-- minimum log level to display. TRACE is the lowest
				-- all notifications are stored in history
				level = vim.log.levels.TRACE,
				icons = {
					error = " ",
					warn = " ",
					info = " ",
					debug = " ",
					trace = " ",
				},
				keep = function(notif)
					return vim.fn.getcmdpos() > 0
				end,
				---@type snacks.notifier.style
				style = "compact",
				top_down = true, -- place notifications from top to bottom
				date_format = "%R", -- time format for notifications
				-- format for footer when more lines are available
				-- `%d` is replaced with the number of lines.
				-- only works for styles with a border
				---@type string|boolean
				more_format = " ↓ %d lines ",
				refresh = 50, -- refresh at most every 50ms
			},
			image = {
				enabled = true,
				formats = {
					"png",
					"jpg",
					"jpeg",
					"gif",
					"bmp",
					"webp",
					"tiff",
					"heic",
					"avif",
					"mp4",
					"mov",
					"avi",
					"mkv",
					"webm",
					"pdf",
				},
			},
			-- animate = {
			-- 	duration = 20, -- ms per step
			-- 	easing = "linear",
			-- 	fps = 60, -- frames per second. Global setting for all animations
			-- },
			input = {
				enabled = true,
				backdrop = false,
				position = "float",
				border = "rounded",
				title_pos = "center",
				height = 1,
				width = 60,
				relative = "editor",
				noautocmd = true,
				row = 2,
				-- relative = "cursor",
				-- row = -3,
				-- col = 0,
				wo = {
					winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
					cursorline = false,
				},
				bo = {
					filetype = "snacks_input",
					buftype = "prompt",
				},
				--- buffer local variables
				b = {
					completion = true, -- disable blink completions in input
				},
				keys = {
					n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
					i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
					i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
					i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
					i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
					i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
					i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
					q = "cancel",
				},
			},
		},
		keys = {
			-- { "<leader>e",  function() Snacks.explorer() end,                                       desc = "File Explorer" },
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},
			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
		},
	},
}
