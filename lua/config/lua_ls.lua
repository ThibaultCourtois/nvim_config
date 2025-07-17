local M = {}
function M.setup()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require('keymaps').setup_lsp_keymaps(client, bufnr)
    end,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'undefined-global', 'deprecated' }
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
          checkThirdParty = false,
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        telemetry = {
          enable = false,
        },
      },
    },
    root_dir = require('lspconfig.util').root_pattern('.git'),
    single_file_support = true,
  })
end
return M
