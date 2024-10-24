-- return {
-- 	{
-- 		"telescope.nvim",
-- 		priority = 1000,
-- 		dependencies = {
-- 			{
-- 				"nvim-telescope/telescope-fzf-native.nvim",
-- 				build = "make",
-- 			},
-- 			"nvim-telescope/telescope-file-browser.nvim",
-- 			"folke/noice.nvim",
-- 		},
-- 		keys = {
-- 			{"<leader>/", false},
-- 			{
-- 				";f",
-- 				function()
-- 					local builtin = require("telescope.builtin")
-- 					builtin.find_files({
-- 						no_ignore = false,
-- 						hidden = true,
-- 					})
-- 				end,
-- 				desc = "Lists files in your current working directory, respects .gitignore",
-- 			},
-- 			{
-- 				";r",
-- 				function()
-- 					local builtin = require("telescope.builtin")
-- 					builtin.live_grep()
-- 				end,
-- 				desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
-- 			},
-- 			{
-- 				"\\\\",
-- 				function()
-- 					local builtin = require("telescope.builtin")
-- 					builtin.buffers()
-- 				end,
-- 				desc = "Lists open buffers",
-- 			},
-- 			-- {
-- 			-- 	";;",
-- 			-- 	function()
-- 			-- 		local builtin = require("telescope.builtin")
-- 			-- 		builtin.resume()
-- 			-- 	end,
-- 			-- 	desc = "Resume the previous telescope picker",
-- 			-- },
-- 			{
-- 				";e",
-- 				function()
-- 					local builtin = require("telescope.builtin")
-- 					builtin.diagnostics()
-- 				end,
-- 				desc = "Lists Diagnostics for all open buffers or a specific buffer",
-- 			},
-- 			{
-- 				";s",
-- 				function()
-- 					local builtin = require("telescope.builtin")
-- 					builtin.treesitter()
-- 				end,
-- 				desc = "Lists Function names, variables, from Treesitter",
-- 			},
-- 			{
-- 				"sf",
-- 				function()
-- 					local telescope = require("telescope")

-- 					local function telescope_buffer_dir()
-- 						return vim.fn.expand("%:p:h")
-- 					end

-- 					telescope.extensions.file_browser.file_browser({
-- 						path = "%:p:h",
-- 						cwd = telescope_buffer_dir(),
-- 						respect_gitignore = false,
-- 						hidden = true,
-- 						grouped = true,
-- 						previewer = false,
-- 						initial_mode = "normal",
-- 						layout_config = { height = 40 },
-- 					})
-- 				end,
-- 				desc = "Open File Browser with the path of the current buffer",
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			local telescope = require("telescope")
-- 			local actions = require("telescope.actions")
-- 			local fb_actions = require("telescope").extensions.file_browser.actions
-- 			print(fb_actions)

-- 			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
-- 				wrap_results = true,
-- 				layout_strategy = "horizontal",
-- 				layout_config = { prompt_position = "bottom" },
-- 				sorting_strategy = "ascending",
-- 				winblend = 0,
-- 				mappings = {
-- 					n = {},
-- 				},
-- 				file_ignore_patterns = {
-- 					"dist/",
-- 					".next/",
-- 					".git/",
-- 				},
-- 			})
-- 			opts.pickers = {
-- 				diagnostics = {
-- 					theme = "ivy",
-- 					initial_mode = "normal",
-- 					layout_config = {
-- 						preview_cutoff = 9999,
-- 					},
-- 				},
-- 				find_files = {
-- 					hidden = true,
-- 				},
-- 			}
-- 			opts.extensions = {
-- 				file_browser = {
-- 					theme = "dropdown",
-- 					-- disables netrw and use telescope-file-browser in its place
-- 					hijack_netrw = true,
-- 					mappings = {
-- 						-- your custom insert mode mappings
-- 						["n"] = {
-- 							-- your custom normal mode mappings
-- 							["N"] = fb_actions.create,
-- 							["h"] = fb_actions.goto_parent_dir,
-- 							["<C-u>"] = function(prompt_bufnr)
-- 								for i = 1, 10 do
-- 									actions.move_selection_previous(prompt_bufnr)
-- 								end
-- 							end,
-- 							["<C-d>"] = function(prompt_bufnr)
-- 								for i = 1, 10 do
-- 									actions.move_selection_next(prompt_bufnr)
-- 								end
-- 							end,
-- 						},
-- 					},
-- 				},
-- 			}
-- 			telescope.setup(opts)
-- 			require("telescope").load_extension("fzf")
-- 			require("telescope").load_extension("file_browser")
-- 			require("telescope").load_extension("noice")
-- 		end,
-- 	},
-- }
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = {
		"ThePrimeagen/harpoon",
		"nvim-lua/plenary.nvim",
		"joshmedeski/telescope-smart-goto.nvim",
	},
	keys = {
		{ "K", false },
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set(
			"n",
			"<leader>fg",
			"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			{ desc = "Live Grep" }
		)
		vim.keymap.set(
			"n",
			"<leader>fc",
			'<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}"})<CR>',
			{ desc = "Live Grep Code" }
		)
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
		vim.keymap.set("n", "<leader>fi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
		vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
		vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, { desc = "Search Git Commits for Buffer" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				layout_config = { width = 0.7 },
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		local telescope = require("telescope")
		local telescopeConfig = require("telescope.config")

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		-- I don't want to search in the `.git` directory.
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		local actions = require("telescope.actions")

		local select_one_or_multi = function(prompt_bufnr)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			local multi = picker:get_multi_selection()
			if not vim.tbl_isempty(multi) then
				require("telescope.actions").close(prompt_bufnr)
				for _, j in pairs(multi) do
					if j.path ~= nil then
						vim.cmd(string.format("%s %s", "edit", j.path))
					end
				end
			else
				require("telescope.actions").select_default(prompt_bufnr)
			end
		end

		telescope.setup({
			defaults = {
				-- `hidden = true` is not supported in text grep commands.
				vimgrep_arguments = vimgrep_arguments,
				path_display = { "truncate" },
				mappings = {
					n = {
						["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					i = {
						["<C-j>"] = actions.cycle_history_next,
						["<C-k>"] = actions.cycle_history_prev,
						["<CR>"] = select_one_or_multi,
						["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-S-d>"] = actions.delete_buffer,
						["<C-s>"] = actions.cycle_previewers_next,
						["<C-a>"] = actions.cycle_previewers_prev,
					},
				},
			},
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
			extensions = {
				undo = {
					use_delta = true,
					use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
					side_by_side = false,
					vim_diff_opts = { ctxlen = vim.o.scrolloff },
					entry_format = "state #$ID, $STAT, $TIME",
					mappings = {
						i = {
							["<C-cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<cr>"] = require("telescope-undo.actions").restore,
						},
					},
				},
			},
		})

		-- require("telescope").load_extension("neoclip")

		require("telescope").load_extension("fzf")

		require("telescope").load_extension("ui-select")
		vim.g.zoxide_use_select = true

		require("telescope").load_extension("undo")

		require("telescope").load_extension("advanced_git_search")

		require("telescope").load_extension("live_grep_args")

		require("telescope").load_extension("colors")

		require("telescope").load_extension("noice")

		require("telescope").load_extension("harpoon")
	end,
}
