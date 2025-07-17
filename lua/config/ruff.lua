local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.ruff.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.completionProvider = false
      local ok, common_lsp = pcall(require, 'keymaps')
      if ok then
        common_lsp.setup_lsp_keymaps(client, bufnr)
      end
    end,
  })
end

return M
