return {
	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		dependencies = {
			"hrsh7th/cmp-cmdline",
		},
		-- opts = function(_, opts)
		-- 	local cmp = require("cmp")
		-- 	-- `:` cmdline setup.
		-- 	cmp.setup.cmdline(":", {
		-- 		-- mapping = cmp.mapping.preset.cmdline(),
		-- 		sources = cmp.config.sources(
		-- 			{
		-- 				{ name = "path" },
		-- 			},
		-- 			{
		-- 				{
		-- 					name = "cmdline",
		-- 					option = {
		-- 						ignore_cmds = { "Man", "!" },
		-- 					},
		-- 				},
		-- 			}),
		-- 	})
		-- 	--   cmp.setup({
		-- 	-- 	mapping = {
		-- 	-- 	  ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	-- 		if cmp.visible() then
		-- 	-- 		  local entry = cmp.get_selected_entry()
		-- 	-- 		  if not entry then
		-- 	-- 			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		-- 	-- 		  else
		-- 	-- 			cmp.confirm()
		-- 	-- 		  end
		-- 	-- 		else
		-- 	-- 		  fallback()
		-- 	-- 		end
		-- 	-- 	  end, { "i", "s", "c" }),
		-- 	-- 	},
		-- 	--   })
		-- end,
	},
}
