local M = {}

function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    on_attach = function(client, bufnr)
      -- Keymaps LSP communes
      require('keymaps').setup_lsp_keymaps(client, bufnr)
    end,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  })
end

return M
