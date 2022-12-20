local lsp = require('lsp-zero')
lsp.preset("recommended")

-- Langauge servers to always install
lsp.ensure_installed({
    'pyright',
    'sumneko_lua',
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
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({ -- See nvim-cmp docs for options
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'vim_lsp', keyword_length = 3 },
        { name = 'buffer', keyword_length = 3 },
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

-- =====================
-- = Setu behavior on LSP attach
-- =====================
lsp.on_attach(function(_, bufnr)
    local bind = function(mode, keymap, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set(mode, keymap, func, {
            buffer = bufnr, remap = false, desc = desc
        })
    end

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
end)

-- ==============================
--      Run at End
-- ==============================
require('fidget').setup({})

lsp.setup() -- Run this at the end of file
vim.diagnostic.config({
    virtual_text = true, -- Floating diagnostic text @ end of line
})
