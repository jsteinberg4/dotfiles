-- Note: This file borrows heavily from:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/format.lua
local Util = require("lazy.core.util")

local M = { autoformat = true }

-- Toggle autoformatting on/off
function M.toggle()
	if vim.b.autoformat == false then
		vim.b.autoformat = nil
		M.autoformat = true
	else
		M.autoformat = not M.autoformat
	end
	-- Notify of change
	if M.autoformat then
		Util.info("Enabled format on save", { title = "Format" })
	else
		Util.warn("Disabled format on save", { title = "Format" })
	end
end

-- Formatter function
function M.format()
	-- Disable if autoformatting is off
	if not M.autoformat then
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	local filetype = vim.bo[buf].filetype
	-- At least 1 null-ls.nvim formatter available
	local have_nls = #require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING") > 0
	-- Apply formatting
	vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			-- TODO : Refactor. This if/else seems redundant
			if have_nls then
				return client.name == "null-ls"
			end
			return client.name ~= "null-ls"
		end,
	}, require("jsteinberg.util").opts("nvim-lspconfig").format or {}))
end

-- Wrapper for on_attach functionality
function M.on_attach(client, buf)
	-- dont format if client disabled it
	if
		client.config
		and client.config.capabilities
		and client.config.capabilities.documentFormattingProvider == false
	then
		return
	end

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
			buffer = buf,
			callback = function()
				if M.autoformat then
					M.format()
				end
			end,
		})
	end
end

return M
