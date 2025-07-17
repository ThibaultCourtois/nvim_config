local M = {}
function M.setup()
  local lspconfig = require('lspconfig')
  local util = require('lspconfig.util')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local bin_name = 'pyright-langserver'
  local cmd = { bin_name, '--stdio' }
  if vim.fn.has('win32') == 1 then
    cmd = { 'cmd.exe', '/C', bin_name, '--stdio' }
  end

  local root_files = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
  }

  lspconfig.pyright.setup({
    capabilities = capabilities,
    cmd = cmd,
    filetypes = { 'python' },
    root_dir = util.root_pattern(unpack(root_files)),
    single_file_support = true,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      local ok, common_lsp = pcall(require, 'keymaps')
      if ok then
        common_lsp.setup_lsp_keymaps(client, bufnr)
      end
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
          typeCheckingMode = "basic",
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalSubscript = "none",
            reportPrivateImportUsage = "none",
            reportUnusedImport = "information",
            reportUnusedVariable = "information",
            reportUnusedFunction = "information",
            reportMissingImports = "error",
            reportMissingTypeStubs = "none",
            reportIncompatibleMethodOverride = "warning",
            reportIncompatibleVariableOverride = "warning",
            reportOverlappingOverload = "warning",
            reportConstantRedefinition = "error",
            reportDuplicateImport = "warning",
            reportWildcardImportFromLibrary = "none",
            reportAbstractUsage = "none",
            reportArgumentType = "warning",
            reportAssertTypeFailure = "error",
            reportAttributeAccessIssue = "warning",
            reportCallInDefaultInitializer = "none",
            reportImplicitStringConcatenation = "none",
            reportInconsistentConstructor = "none",
            reportInvalidStringEscapeSequence = "warning",
            reportInvalidTypeVarUse = "warning",
            reportMatchNotExhaustive = "none",
            reportMissingParameterType = "none",
            reportMissingTypeArgument = "none",
            reportPrivateUsage = "none",
            reportTypeCommentUsage = "none",
            reportUnknownArgumentType = "none",
            reportUnknownLambdaType = "none",
            reportUnknownMemberType = "none",
            reportUnknownParameterType = "none",
            reportUnknownVariableType = "none",
            reportUnnecessaryCast = "none",
            reportUnnecessaryComparison = "none",
            reportUnnecessaryContains = "none",
            reportUnnecessaryIsInstance = "none",
            reportUnusedClass = "none",
            reportUnusedExpression = "none",
            reportUntypedBaseClass = "none",
            reportUntypedClassDecorator = "none",
            reportUntypedFunctionDecorator = "none",
            reportUntypedNamedTuple = "none",
          },
        },
      },
    }
  })

  local function organize_imports()
    local params = {
      command = 'pyright.organizeimports',
      arguments = { vim.uri_from_bufnr(0) },
    }
    vim.lsp.buf.execute_command(params)
  end

  vim.api.nvim_create_user_command('PyrightOrganizeImports', organize_imports, {
    desc = 'Organize Imports',
  })

  print("✅ Pyright configuré (sélectif)")
end

return M
