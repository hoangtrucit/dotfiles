return {
	-- tools
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = function()
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")
			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier",
					"prettierd",
					"eslint_d",
					"htmlbeautifier",
					"beautysh",
					"buf",
					"yamlfix",
					"shellcheck",
					"gopls",
					"astro-language-server",
					"stylua",
					"selene",
					"luacheck",
					"shfmt",
					"tailwindcss-language-server",
					"typescript-language-server",
					"css-lsp",
				},
			})
		end,
	},

	-- lsp servers
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		inlay_hints = { enabled = false },
	-- 		---@type lspconfig.options
	-- 		servers = {
	-- 			cssls = {},
	-- 			tailwindcss = {
	-- 				root_dir = function(...)
	-- 					return require("lspconfig.util").root_pattern(".git")(...)
	-- 				end,
	-- 			},
	-- 			tsserver = {
	-- 				root_dir = function(...)
	-- 					return require("lspconfig.util").root_pattern(".git")(...)
	-- 				end,
	-- 				single_file_support = false,
	-- 				settings = {
	-- 					typescript = {
	-- 						inlayHints = {
	-- 							includeInlayParameterNameHints = "literal",
	-- 							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	-- 							includeInlayFunctionParameterTypeHints = true,
	-- 							includeInlayVariableTypeHints = false,
	-- 							includeInlayPropertyDeclarationTypeHints = true,
	-- 							includeInlayFunctionLikeReturnTypeHints = true,
	-- 							includeInlayEnumMemberValueHints = true,
	-- 						},
	-- 					},
	-- 					javascript = {
	-- 						inlayHints = {
	-- 							includeInlayParameterNameHints = "all",
	-- 							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	-- 							includeInlayFunctionParameterTypeHints = true,
	-- 							includeInlayVariableTypeHints = true,
	-- 							includeInlayPropertyDeclarationTypeHints = true,
	-- 							includeInlayFunctionLikeReturnTypeHints = true,
	-- 							includeInlayEnumMemberValueHints = true,
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 			html = {},
	-- 			yamlls = {
	-- 				settings = {
	-- 					yaml = {
	-- 						keyOrdering = false,
	-- 					},
	-- 				},
	-- 			},
	-- 			lua_ls = {
	-- 				-- enabled = false,
	-- 				single_file_support = true,
	-- 				settings = {
	-- 					Lua = {
	-- 						workspace = {
	-- 							checkThirdParty = false,
	-- 						},
	-- 						completion = {
	-- 							workspaceWord = true,
	-- 							callSnippet = "Both",
	-- 						},
	-- 						misc = {
	-- 							parameters = {
	-- 								-- "--log-level=trace",
	-- 							},
	-- 						},
	-- 						hint = {
	-- 							enable = true,
	-- 							setType = false,
	-- 							paramType = true,
	-- 							paramName = "Disable",
	-- 							semicolon = "Disable",
	-- 							arrayIndex = "Disable",
	-- 						},
	-- 						doc = {
	-- 							privateName = { "^_" },
	-- 						},
	-- 						type = {
	-- 							castNumberToInteger = true,
	-- 						},
	-- 						diagnostics = {
	-- 							disable = { "incomplete-signature-doc", "trailing-space" },
	-- 							-- enable = false,
	-- 							groupSeverity = {
	-- 								strong = "Warning",
	-- 								strict = "Warning",
	-- 							},
	-- 							groupFileStatus = {
	-- 								["ambiguity"] = "Opened",
	-- 								["await"] = "Opened",
	-- 								["codestyle"] = "None",
	-- 								["duplicate"] = "Opened",
	-- 								["global"] = "Opened",
	-- 								["luadoc"] = "Opened",
	-- 								["redefined"] = "Opened",
	-- 								["strict"] = "Opened",
	-- 								["strong"] = "Opened",
	-- 								["type-check"] = "Opened",
	-- 								["unbalanced"] = "Opened",
	-- 								["unused"] = "Opened",
	-- 							},
	-- 							unusedLocalExclude = { "_*" },
	-- 						},
	-- 						format = {
	-- 							enable = false,
	-- 							defaultConfig = {
	-- 								indent_style = "space",
	-- 								indent_size = "2",
	-- 								continuation_indent_size = "2",
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		setup = {},
	-- 	},
	-- },

	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{
				"neovim/nvim-lspconfig",
			}, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
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

			require("mason").setup({})
			require("mason-lspconfig").setup({
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
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})

			local cmp_action = require("lsp-zero").cmp_action()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

			cmp.setup.cmdline(":", {
				-- mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			-- -- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- -- `:` cmdline setup.
			-- cmp.setup.cmdline(":", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources(
			-- 		{
			-- 			{ name = "path" },
			-- 		},
			-- 		{
			-- 			{
			-- 				name = "cmdline",
			-- 				option = {
			-- 					ignore_cmds = { "Man", "!" },
			-- 				},
			-- 			},
			-- 		}),
			-- })

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					-- ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-p>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					-- ["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				}),
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
			-- lsp
			-- local on_attach = require("plugins.configs.lspconfig").on_attach
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- local lspconfig = require("lspconfig")
			-- local util = require "lspconfig/util"

			-- lspconfig.gopls.setup {
			-- 	capabilities = capabilities,
			-- 	cmd = { "gopls" },
			-- 	filetypes = { "go", "gomod", "gowork", "gotmpl" },
			-- 	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			-- 	settings = {
			-- 		gopls = {
			-- 			completeUnimported = true,
			-- 			usePlaceholders = true,
			-- 			analyses = {
			-- 				unusedparams = true,
			-- 			},
			-- 		},
			-- 	},
			-- }
		end,
	},
}
