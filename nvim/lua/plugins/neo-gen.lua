return {
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip", input_after_comment = true })
		end,
	},
}
