local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.cmake.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require('keymaps').setup_lsp_keymaps(client, bufnr)
    end,
    filetypes = { "cmake" },
    init_options = {
      buildDirectory = "build",
    },
  })
end

return M
