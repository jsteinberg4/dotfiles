-- =============================
-- =    Telescope.nvim
-- =============================
local Util = require("jsteinberg.util")

-- FIXME: find files stops working randomly
return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false,
	init = function() -- FIXME: check if this even works
		-- TODO: Incorporate extensions
		pcall(require("telescope").load_extension, "fzf")
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			-- Faster(?) fuzzy find algorithm
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = vim.fn.executable("make") == 1,
			cmd = "Telescope",
		},
		{ "nvim-tree/nvim-web-devicons" },
	},
	opts = {
		-- Config options
		defaults = {
			winblend = 15, -- Floating window transparency
			path_display = "smart", -- Only show path differneces
			-- From LazyVim:
			prompt_prefix = " ",
			selection_caret = " ",
		},
		mappings = {
			-- Normal mode mappings
			n = {
				["<ESC>"] = function(arg)
					require("telescope.actions").close(arg)
				end,
				["<C-c>"] = function(arg)
					require("telescope.actions").close(arg)
				end,
			},
			-- Insert mode mappings
			i = {
				["<C-c>"] = function(arg)
					require("telescope.actions").close(arg)
				end,
				-- ["<c-t>"] = function(...)
				-- 	return require("trouble.providers.telescope").open_with_trouble(...)
				-- end,
				-- ["<a-t>"] = function(...)
				-- 	return require("trouble.providers.telescope").open_selected_with_trouble(...)
				-- end,
				-- ["<a-i>"] = function()
				-- 	Util.telescope("find_files", { no_ignore = true })()
				-- end,
				-- ["<a-h>"] = function()
				-- 	Util.telescope("find_files", { hidden = true })()
				-- end,
				-- ["<C-Down>"] = function(...)
				-- 	return require("telescope.actions").cycle_history_next(...)
				-- end,
				-- ["<C-Up>"] = function(...)
				-- 	return require("telescope.actions").cycle_history_prev(...)
				-- end,
				-- ["<C-f>"] = function(...)
				-- 	return require("telescope.actions").preview_scrolling_down(...)
				-- end,
				-- ["<C-b>"] = function(...)
				-- 	return require("telescope.actions").preview_scrolling_up(...)
				-- end,
			},
		},
	},
	keys = { -- Keymaps
		-- Holdover from prev config. iffy difference on grep cmds
		-- -- Note :: ripgrep must be installed for this
		-- vim.keymap.set("n", "<leader>sw", function()
		--    builtin.grep_string({ search = vim.fn.input("Grep >") });
		-- end, { desc = "[S]earch [W]ord" })
		{ "<leader><space>", "<CMD>Telescope<CR>", silent = true, desc = "Find Files (root dir)" },
		{
			"<leader>,",
			Util.telescope("buffers", { show_all_buffers = true }),
			desc = "Switch buffer",
			silent = true,
		},
		{ "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
		-- { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		-- find
		{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
		{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
		{ "<leader>fr", Util.telescope("oldfiles"), desc = "[f]ind [r]ecently opened files" },
		-- git
		{ "<leader>gc", Util.telescope("git_commits"), desc = "[g]it [c]ommits" },
		{ "<leader>gs", Util.telescope("git_status"), desc = "[g]it [s]tatus" },
		-- search
		{ "<leader>sh", Util.telescope("help_tags"), desc = "[s]earch [h]elp pages" },
		{
			"<leader>sb",
			Util.telescope("current_buffer_fuzzy_find", { previewer = false }),
			desc = "Fuzzy [s]earch the current [b]uffer]",
		},
		{ "<leader>sc", Util.telescope("command_history"), desc = "[s]earch [c]ommand History" },
		{ "<leader>sC", Util.telescope("commands"), desc = "Commands" },
		{ "<leader>sd", Util.telescope("diagnostics"), desc = "[S]earch [D]iagnostics" },
		{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
		{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
		{ "<leader>sH", Util.telescope("highlights"), desc = "Search Highlight Groups" },
		{ "<leader>sk", Util.telescope("keymaps"), desc = "[S]earch [K]eymaps" },
		{ "<leader>sM", Util.telescope("man_pages"), desc = "Man Pages" },
		{ "<leader>sm", Util.telescope("marks"), desc = "Jump to Mark" },
		{ "<leader>so", Util.telescope("vim_options"), desc = "Options" },
		{ "<leader>sR", Util.telescope("resume"), desc = "[R]esume previous telescope command" },
		{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
		{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
		{ "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "[u]se [C]olorscheme" },
		{
			"<leader>ss",
			Util.telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "[s]earch [s]ymbol (current document)",
		},
		{
			"<leader>sS",
			Util.telescope("lsp_workspace_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "[s]earch [s]ymbol (Workspace)",
		},
	},
}
