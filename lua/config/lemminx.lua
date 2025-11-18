local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.lemminx.setup({
    capabilities = capabilities,
    cmd = {"lemminx"},
    on_attach = function(client, bufnr)
      require('keymaps').setup_lsp_keymaps(client, bufnr)
    end,
    filetypes = { "xml", "xsd", "mjcf", "xsl", "xslt", "svg"},
  })
end

return M

