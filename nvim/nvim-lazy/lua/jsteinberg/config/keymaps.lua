local function map(mode, lhs, rhs, opts)
	--	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	--	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
	opts = opts or {}
	opts.silent = opts.silent ~= false -- Silent by default
	vim.keymap.set(mode, lhs, rhs, opts)
	--	end
end

-- Make space do nothing in normal/vis modes
map({ "n", "v" }, "<Space>", "<Nop>")

-- Add CTRL+S to save b/c of muscle memory for other apps
map({ "n", "v", "i" }, "<C-s>", vim.cmd.write, { desc = "Save document" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- FIXME: I think this blocks registers/macros?
map("v", "q", "<Esc>", { desc = "q to exit visual mode" })

-- Join line w/o moving cursor
map("n", "J", "mzJ`z")

map("n", "Q", "<nop>")

-- Use 'q' to cancel visual mode, instead of just Escape
-- FIXME: I think this blocks registers/macros?
map("v", "q", "<Esc>")

-- #####################
-- Always keep cursor centered!
-- #####################
map("n", "gg", "ggzz", { desc = "GOTO top, center cursor" })
map("n", "G", "Gzz", { desc = "GOTO bottom, center cursor" })
map("n", "<C-d>", "<C-d>zz", { desc = "Page down, center cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Page up, center cursor" })
map("n", "n", "nzzzv", { desc = "Keep cursor centered while searching" })
map("n", "N", "Nzzzv", { desc = "Center cursor while searching" })
