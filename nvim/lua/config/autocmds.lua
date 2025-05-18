vim.api.nvim_create_autocmd("FileType", {
	pattern = "proto",
	callback = function()
		for _, client in pairs(vim.lsp.get_active_clients()) do
			if client.name == "clangd" then
				vim.notify("Stopping clangd for .proto file", vim.log.levels.WARN)
				vim.lsp.stop_client(client.id)
			end
		end
	end,
})
