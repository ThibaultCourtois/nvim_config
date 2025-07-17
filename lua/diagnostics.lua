-- lua/diagnostics.lua
local M = {}

function M.setup()
  -- Icônes JetBrains Nerd Font
  local signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "󰛨",
  }
vim.diagnostic.config({
    virtual_text = false,     -- Désactivé pour lsp_lines
    virtual_lines = true,     -- Pour lsp_lines
    signs = {
      text = signs,
    },
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      format = function(diagnostic)
        return string.format("%s (%s)", diagnostic.message, diagnostic.source)
      end,
    },
    update_in_insert = false,
  })
end
return M
