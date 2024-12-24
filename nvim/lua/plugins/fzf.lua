return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			fzf_opts = {
				["--layout"] = "default",
			},
			files = {
				fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude .DS_Store]],
				fzf_opts = {
					["--layout"] = "default",
				},
				cwd_prompt = false,
			},
		})
	end,
}
