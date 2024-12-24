return {
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
			},
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "saghen/blink.cmp" }, -- Optional
		},
		config = function()
			local lsp = require("lsp-zero")

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.setloclist()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
			end)

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason").setup({})
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"ts_ls",
					"eslint",
					"lua_ls",
					"jsonls",
					"html",
					"tailwindcss",
					"tflint",
					"pylsp",
					"dockerls",
					"bashls",
					"marksman",
					"gopls",
					"astro",
				},
				handlers = {
					lsp.default_setup,
					lua_ls = function()
						local lua_opts = lsp.nvim_lua_ls()
						lua_opts.capabilities = capabilities
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
					ts_ls = function()
						require("lspconfig").ts_ls.setup({
							filetypes = {
								"javascript",
								"javascriptreact",
								"javascript.jsx",
								"typescript",
								"typescriptreact",
								"typescript.tsx",
							},
						})
					end,
				},
			})

			vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
				config = config or {}
				config.focus_id = ctx.method

				if not (result and result.contents) then
					return
				end

				local markdown_lines = vim.split(result.contents.value, "\n", { trimempty = false })

				if vim.tbl_isempty(markdown_lines) then
					return
				end

				return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
			end
		end,
	},
}
