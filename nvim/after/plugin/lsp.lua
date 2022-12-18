-- Function to run whenver an LSP connects to a buffer
local on_attach = function(client, bufnr)
  -- This function does some configuration on LSP specific
  -- mappings in a reusable way.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  local t_builtin = require('telescope.builtin')

  nmap("<leader>vrn", vim.lsp.buf.rename, "[V]ariable [R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", t_builtin.lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", t_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", t_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  nmap("K", vim.lsp.buf.hover, 'Hover Documentation')
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "LSP: Signature Recommendation"
  })

  -- Lesser-used functions
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Create command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format current buffer with LSP" })
  nmap("<C-L>", vim.cmd("Format"), "Format current buffer with LSP (IntelliJ Binding)")
end

-- Setup mason to manage external tooling
require('mason').setup({
  pip = {
    -- Upgrade venv PIP before installing any packages
    upgrade_pip = true,
  },
})

-- List of LSP servers to install and configure
-- This list will be automatically installed, always.
local lsp_servers = {
  'pyright',
  'sumneko_lua',
  'marksman',
}

-- Install the sserver list
require('mason-lspconfig').setup({
  ensure_installed = lsp_servers
})


-- Enable additional completion capabilities from nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(lsp_servers) do
  require('lspconfig')[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end


-- Turns on LSP status info
require('fidget').setup()


-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      -- workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- workspace = { library = vim.cmd('pwd') },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.diagnostic.config({
  virtual_text = true,
})

-- Modeline (see: `help modeline`)
-- vim: ts=2 sts=2 sw=2 et
