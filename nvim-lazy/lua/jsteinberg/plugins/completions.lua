--     {
--         'VonHeikemen/lsp-zero.nvim',
--         event = { "BufReadPre", "BufNewFile" },
--         dependencies = {
--             -- Autocompletion
--
--             -- Snippets
--         }
--     },
return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp", -- Optional
		-- version = "<CurrentMajor>.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
        -- stylua: ignore
		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true, silent = true, mode = "i",
			},
			{
				"<tab>", function() require("luasnip").jump(1) end, mode = "s",
			},
			{
				"<S-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" },
			},
		},
	},
	{ -- Autocomplete
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
		},
		opts = function()
			-- See nvim-cmp docs for options
			local cmp = require("cmp")

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					-- Scroll through docs
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- Cancel
					["<C-e>"] = cmp.mapping.abort(),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.SelectBehavior.Replace,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "buffer" }, -- Words in the current buffer
					{ name = "luasnip" }, -- Lua snippets
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" }, -- Nvim Lua API completion
					{ name = "path" },
				}),
				formatting = {
					-- TODO: Get this icons thing setup
					-- format = function(_, item)
					-- 	local icons = require("lazyvim.config").icons.kinds
					-- 	if icons[item.kind] then
					-- 		item.kind = icons[item.kind] .. item.kind
					-- 	end
					-- 	return item
					-- end,
				},
				experimental = { -- TODO : What does this do?
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},
}
