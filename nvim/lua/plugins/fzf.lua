return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>/", vim.NIL },
	},
	config = function()
		require("fzf-lua").setup({
			fzf_opts = {
				["--layout"] = "default",
			},
			files = {
				fd_opts =
				[[--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude .DS_Store --exclude gRPC --exclude dist]],
				fzf_opts = {
					["--layout"] = "default",
				},
				cwd_prompt = false,
				multiprocess = true, -- run command in a separate process
				git_icons = true, -- show git icons?
				file_icons = true, -- show file icons (true|"devicons"|"mini")?
				color_icons = true,
			},
		})
	end,
}
