return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
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
			notifier = { enabled = true },
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
		},
		keys = {
			-- { "<leader>e",  function() Snacks.explorer() end,                                       desc = "File Explorer" },
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers",
			},
			{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
			{ "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
			{ "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
			-- LSP
			{ "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
			{ "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
			{ "gr",         function() Snacks.picker.lsp_references() end,                          nowait = true,                  desc = "References" },
			{ "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
			{ "gy",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
		},
	},
}
