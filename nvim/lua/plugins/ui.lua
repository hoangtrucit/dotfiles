return {
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	opts = {
	-- 		timeout = 3000,
	-- 		background_colour = "#000000",
	-- 		render = "wrapped-compact",
	-- 		stages = "slide",
	-- 		top_down = false,
	-- 	},
	-- },
	--
	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		opts = {
			options = {
				buffer_close_icon = "󰅖",
				modified_icon = "● ",
				close_icon = " ",
				left_trunc_marker = " ",
				right_trunc_marker = " ",
				separator_style = "slant",
				themable = true,
				indicator = {
					style = "underline",
				},
				color_icons = true,
				-- stylua: ignore
				close_command = function(n) LazyVim.ui.bufremove(n) end,
				-- stylua: ignore
				right_mouse_command = function(n) LazyVim.ui.bufremove(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				diagnostics_indicator = function(_, _, diag)
					local icons = LazyVim.config.icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				---@param opts bufferline.IconFetcherOpts
				get_element_icon = function(opts)
					return LazyVim.config.icons.ft[opts.filetype]
				end,
			},
		},
		config = function(_, opts)
			-- opts.options.highlight = require("rose-pine.plugins.bufferline")
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = {},
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local helpers = require("incline.helpers")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					local buffer = {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#363944",
					}
					return buffer
				end,
			})
		end,
	},

	-- LazyGit integration with Telescope
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{
				";c",
				":LazyGit<Return>",
				silent = true,
				noremap = true,
			},
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			local HEIGHT_RATIO = 0.8 -- You can change this
			local WIDTH_RATIO = 0.8 -- You can change this too
			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
				},
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					local function opts(desc)
						return {
							desc = "nvim-tree: " .. desc,
							buffer = bufnr,
							noremap = true,
							silent = true,
							nowait = true,
						}
					end

					-- default mappings
					api.config.mappings.default_on_attach(bufnr)

					-- custom mappings
					vim.keymap.set("n", "l", api.node.open.tab, opts("Tab"))
				end,
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
					relativenumber = true,
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
					custom = {
						-- "node_modules/.*",
					},
				},
				log = {
					enable = true,
					truncate = true,
					types = {
						diagnostics = true,
						git = true,
						profile = true,
						watcher = true,
					},
				},
			})

			-- if vim.fn.argc(-1) == 0 then
			-- 	vim.cmd("NvimTreeFocus")
			-- end
		end,
	},
	{
		"folke/snacks.nvim",
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
		},
	},
	"DaikyXendo/nvim-material-icon",
	"nanotee/zoxide.vim",
	"nvim-telescope/telescope-ui-select.nvim",
	"debugloop/telescope-undo.nvim",
	{
		"aaronhallaert/advanced-git-search.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"tpope/vim-fugitive",
			"tpope/vim-rhubarb",
		},
	},
	"nvim-telescope/telescope-live-grep-args.nvim",
	"brenoprata10/nvim-highlight-colors",
	{
		"exosyphon/telescope-color-picker.nvim",
		config = function()
			vim.keymap.set("n", "<leader>uC", "<cmd>Telescope colors<CR>", { desc = "Telescope Color Picker" })
		end,
	},
	{
		"danymat/neogen",
		config = true,
	},
}
