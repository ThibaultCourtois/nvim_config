return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = false,
      italic_comments = true,
      highlights = {
        -- Numéro de la ligne courante
        CursorLineNr = { fg = "#ff0000", bold = true, italic = true },
        -- Numéros des autres lignes
        LineNr = { fg = "#ffff00" },
        -- Ligne du curseur
        CursorLine = { bg = "#16213e" },
      }
    })
    vim.cmd("colorscheme cyberdream")

    -- Forcer les highlights après le chargement
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff0000", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffff00" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#16213e" })
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
