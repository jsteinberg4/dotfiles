-- This file is adapted from:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/keymaps.lua
-- Keybindings may change, most other content has not.
local M = {}

---@type PluginLspKeys
M._keys = nil

-- Lazyily defines keymappings when they're accessed.
-- Reuses if called multiple times.
---@return (LazyKeys|{has?:string})[]
function M.get()
	local format = require("jsteinberg.plugins.lsp.format").format
	if not M._keys then
		---@class PluginLspKeys
		-- stlyua: ignore
		M._keys = {
			{ "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
			{ "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
			{ "gd", "<cm>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
			{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
			{ "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
			{ "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
			{ "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
			{ "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
			{ "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
			{ "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
			{ "<leader>cf", format, desc = "Format Document", has = "documentFormatting" },
			{ "<leader>cf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
			{
				"<leader>cA",
				function()
					vim.lsp.buf.code_action({
						context = {
							only = {
								"source",
							},
							diagnostics = {},
						},
					})
				end,
				desc = "Source Action",
				has = "codeAction",
			},
		}

		-- Setup symbol renaming
		if require("jsteinberg.util").has("inc-rename.nvim") then
			M._keys[#M._keys + 1] = {
				"<leader>cr",
				function()
					require("inc_rename")
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Rename",
				has = "rename",
			}
		else
			M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
		end
	end

	return M._keys
end

-- Wrapper for on_attach functionality
-- Defines keymaps when attaching to a buffer
function M.on_attach(client, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

	-- validation
	for _, value in ipairs(M.get()) do
		local keys = Keys.parse(value)
		if keys[2] == vim.NIL or keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end

	-- Set each keymapping for the given buffer
	for _, keys in pairs(keymaps) do
		if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
			local opts = Keys.opts(keys)
			---@diagnostic disable-next-line: no-unknown
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

-- Iterate over diagnostic messages
function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
