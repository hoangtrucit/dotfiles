return {
	-- Hihglight colors
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {},
	},
	-- comment
	{
		"numToStr/Comment.nvim",
	},
	-- hop vim moving
	{
		"hadronized/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"hinell/duplicate.nvim"
	}
}
