return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,
      italic_comments = true,
      highlights = {
        -- Fond noir total
        Normal = { bg = "#000000" },
        NormalFloat = { bg = "#000000" },
        NormalNC = { bg = "#000000"},
        SignColumn = { bg = "#000000"},
        NeoTreeWinSeparator = { bg = "#000000"},
        NeoTreeFloatBorder = {bg = "#000000"},
        NeoTreeTitleBar = {bg = "#000000"},
        WhichKeyBorder = {bg = "#000000"},
        WhichKeyTitle = {bg = "#000000"},
        NeoTreeFloatTitle = {bg = "#000000"},
        NeoTreeVertSplit = {bg = "#000000"},
        NeoTreeStatusLine = {bg = "#000000"},
        NeoTreeStatusLineNC = {bg = "#000000"},
        NeoTreeTabActive = {bg = "#000000"},
        NeoTreeTabInactive = {bg = "#000000"},
        NeoTreeTabSeparatorInactive = {bg = "#000000"},
        WinBar = {bg = "#000000"},
        WinBarNC = {bg = "#000000"},
        WinSeparator = {bg = "#000000"},
        Title = {bg = "#000000"},
        VertSplit = {bg = "#000000"},
        BufferLineTab = {bg = "#000000"},
        BufferLineFill = {bg = "#000000"},
        TelescopeTitle = {bg = "#000000"},
        TelescopeBorder = {bg = "#000000"},
        Pmenu = {bg = "#000000"},
        PmenuSbar = {bg = "#000000"},

        -- Numéro de la ligne courante
        CursorLineNr = { fg = "#ff0000", bold = true, italic = true },
        -- Numéros des autres lignes
        LineNr = { fg = "#ffff00" },
        -- Ligne du curseur
        CursorLine = { bg = "#111111" },
      }
    })
    vim.cmd("colorscheme cyberdream")
    -- Forcer les highlights après le chargement
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff0000", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffff00" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#111111" })
      end,
    })
    -- S'assurer que cursorline est activé dans tous les buffers
    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,
}
