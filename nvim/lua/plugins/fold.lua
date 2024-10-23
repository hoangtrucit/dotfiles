return {
	{
		"kevinhwang91/promise-async"
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = false,
		config = function()
			-- vim.o.foldcolumn = "1" -- '0' is not bad
			-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			-- vim.o.foldlevelstart = 99
			-- vim.o.foldenable = true

			-- show amount of folded lines instead of default thing
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end
			local ftMap = {
				vim = 'indent',
				python = { 'indent' },
				typescript = { 'indent', },
				typescriptreact = { 'indent', },
				git = ''
			}
			vim.cmd([[
				highlight UfoFoldedFg ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
				highlight UfoFoldedBg ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
				highlight Folded ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
			]])
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}
			local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
				require('lspconfig')[ls].setup({
					capabilities = capabilities
					-- you can add other fields for setting up lsp server in this table
				})
			end
			require('ufo').setup({
				open_fold_hl_timeout = 150,
				close_fold_kinds_for_ft = {
					default = {},
					typescript = { 'imports', 'comment', 'region', 'method', 'function', 'class' },
					typescriptreact = { 'imports', 'comment', 'region', 'method', 'function', 'class' },
					json = { 'array' },
					c = { 'comment', 'region' }
				},
				preview = {
					win_config = {
						border = { '', '─', '', '', '', '─', '', '' },
						winhighlight = 'Normal:Folded',
						winblend = 0
					},
					mappings = {
						scrollU = '<C-u>',
						scrollD = '<C-d>',
						jumpTop = '[',
						jumpBot = ']'
					}
				},
				fold_virt_text_handler = handler,
				-- provider_selector = function(bufnr, filetype, buftype)
				-- 	-- print(filetype)
				-- 	-- if you prefer treesitter provider rather than lsp,
				-- 	-- return ftMap[filetype] or {'treesitter', 'indent'}
				-- 	return ftMap[filetype]
				-- 	-- return ftMap[filetype]
				-- 	-- return { 'treesitter', 'indent' }

				-- 	-- refer to ./doc/example.lua for detail
				-- end
			})
		end,
	}
}
