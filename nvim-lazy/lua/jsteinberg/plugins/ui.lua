-- =============================
-- =    Any overhauled UI elements
-- =============================

return {
	-- A "noicer" UI. TL;DR -- this looks cool
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
        -- stylua: ignore
		keys = {
			{
				"<S-Enter>",
				function() require("noice").redirect(vim.fn.getcmdline()) end,
				mode = "c", desc = "Redirect commandline",
			},
			{
				"<leader>snl",
				function() require("noice").cmd("last") end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function() require("noice").cmd("history") end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function() require("noice").cmd("all") end,
				desc = "Noice All",
			},
			{
				"<c-f>",
				function()
                    if not require("noice.lsp").scroll(4) then
                        return "<c-f>"
					end
				end,
				silent = true, expr = true,
				desc = "Scroll forward", mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
                    if not require("noice.lsp").scroll(-4) then
                        return "<c-b>"
                    end
                end,
				silent = true, expr = true,
				desc = "Scroll backward", mode = { "i", "n", "s" },
			},
		},
	},

	-- Better `vim.notify()`
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("jsteinberg.util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},
	{ -- A prettier nvim UI
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		-- Bufferline UI changes
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bn", "<CMD>BufferLineCycleNext<CR>", silent = true, desc = "[b]uffer [n]ext" },
			{ "<leader>bp", "<CMD>BufferLineCyclePrev<CR>", silent = true, desc = "[b]uffer [p]revious" },
			{ "<leader><C-W>", "<CMD>BufferLinePickClose<CR>", silent = true, desc = "Pick and close buffer" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("jsteinberg.config").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
	{
		-- add indent guides on bank lines
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			show_trailing_blankline_indent = false,
			show_current_context = false,
			filetype_exclude = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
			},
		},
	},
}
