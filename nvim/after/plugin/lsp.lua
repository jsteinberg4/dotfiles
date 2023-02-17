local lsp = require('lsp-zero')
lsp.preset("recommended")

-- Langauge servers to always install
lsp.ensure_installed({
    'pyright',
    'lua_ls',
    'bashls',
    'jsonls',
    'marksman',
    'yamlls',
    'html',
    'cssls',
})

-- Disable the global 'vim' error in lua conf files
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = { cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(), -- <C-Space> triggers complete
})

lsp.setup_nvim_cmp({
    -- See nvim-cmp docs for options
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'vim_lsp', keyword_length = 3 },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    }
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
    }
})

-- local null_ls = require('null-ls')
-- =====================
-- = Setup behavior on LSP attach
-- =====================
-- local lsp_signature_cfg = {
--     bind = true, -- This is mandatory, otherwise border config won't get registered.
--     -- If you want to hook lspsaga or other signature handler, pls set to false
--     doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
--     -- set to 0 if you DO NOT want any API comments be shown
--     -- This setting only take effect in insert mode, it does not affect signature help in normal
--     -- mode, 10 by default
--     max_height = 12, -- max height of signature floating_window
--     max_width = 80, -- max_width of signature floating_window
--     noice = false, -- set to true if you using noice to render markdown
--     wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
--     floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
--     floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
--     -- will set to true when fully tested, set to false will use whichever side has more space
--     -- this setting will be helpful if you do not want the PUM and floating win overlap
--     close_timeout = 2000, -- close floating window after ms when laster parameter is entered
--     fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
--     hint_enable = true, -- virtual hint enable
--     hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
--     hint_scheme = "String",
--     hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
--     handler_opts = {
--         border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
--     },
--     shadow_blend = 36, -- if you using shadow as border use this set the opacity
--     shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
--     always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
--     auto_close_after = 10, -- autoclose signature float win after x sec, disabled if nil.
--     timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
--     toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
--     select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
--     move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
-- }

local on_attach = function(_, bufnr)
    local bind = function(mode, keymap, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set(mode, keymap, func, {
            buffer = bufnr, remap = false, desc = desc
        })
    end

    -- require('lsp_signature').on_attach(lsp_signature_cfg, bufnr)

    -- LSP Buffer keybinds
    bind('n', "<leader>vrn", vim.lsp.buf.rename, "[V]ariable [R]e[n]ame")
    bind('n', "<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')
    bind('n', "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    bind('n', "gI", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    bind('n', "<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    bind('i', "<C-h>", vim.lsp.buf.signature_help, "<Ctrl> + Signature [H]elp")
    bind('n', "K", vim.lsp.buf.hover, 'Hover Documentation')
    bind('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Telescope LSP bindings
    local t_builtin = require('telescope.builtin')
    bind('n', "gr", t_builtin.lsp_references, "[G]oto [R]eferences")
    bind("n", "<leader>ds", t_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
    bind("n", "<leader>ws", t_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Diagnostics keybinds
    bind("n", "<leader>vd", vim.diagnostic.open_float, "Open [V]im [D]iagnostic")
    bind("n", "[d", vim.diagnostic.goto_next, "Next [D]iagnostic")
    bind("n", "]d", vim.diagnostic.goto_prev, "Prev [D]iagnostic")

    -- Setup code formatting capabilities
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "Format current buffer with LSP" })

    -- Automatically format the file when saving/writing
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
            vim.cmd("Format")
        end
    })
end

lsp.on_attach(on_attach)
-- null_ls.setup({
--     on_attach = on_attach,
--     sources = {
--         --[[ null_ls.builtins.formatting.stylua, ]]
--         null_ls.builtins.diagnostics.eslint,
--         null_ls.builtins.completion.spell,
--     },
-- })


-- ==============================
--      Run at End
-- ==============================
require('fidget').setup({})

lsp.setup() -- Run this at the end of file
vim.diagnostic.config({
    virtual_text = true, -- Floating diagnostic text @ end of line
})
