return {
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enable = true,
				snippet_engine = "luasnip",
				input_after_comment = true,
				languages = {
					['typescript.tsdoc'] = require('neogen.configurations.typescript')
				}
			})
		end,
	},
}
