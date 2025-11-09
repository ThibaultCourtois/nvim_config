-- ~/.config/nvim/lua/keymaps.lua
local M = {}

-- Keymaps généraux
function M.setup_general_keymaps()
  local opts = { silent = true }

  -- NAVIGATION FENÊTRES
  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Fenêtre gauche' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Fenêtre bas' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Fenêtre haut' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Fenêtre droite' })

  -- BUFFERS
  vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Buffer suivant' })
  vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Buffer précédent' })

  vim.keymap.set('n', '<leader>x', function()
    local current_buf = vim.api.nvim_get_current_buf()
    local normal_buffers = {}
    for _, buf in ipairs(vim.fn.getbufinfo({buflisted = 1})) do
      local bufname = buf.name
      if not bufname:match("neo%-tree") then
        table.insert(normal_buffers, buf.bufnr)
      end
    end
    if #normal_buffers > 1 then
      vim.cmd('bprevious')
      vim.cmd('bdelete ' .. current_buf)
    else
      vim.cmd('Alpha')
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(current_buf) then
          vim.api.nvim_buf_delete(current_buf, {force = true})
        end
      end, 10)
    end
  end, { desc = 'Fermer buffer' })

  vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Sauvegarder' })
  vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quitter' })

  -- CHEAT SHEET
  vim.keymap.set('n', '<leader>h', function()
    M.show_cheatsheet()
  end, { desc = 'Cheat sheet' })
end

-- Keymaps diagnostics (simplifiés)
function M.setup_diagnostic_keymaps()
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Voir diagnostic' })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic précédent' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic suivant' })
end

-- Keymaps LSP
function M.setup_lsp_keymaps(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Aller à définition' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Voir références' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Documentation' }))
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Renommer' }))
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Actions' }))
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', opts, { desc = 'Formater' }))
end

-- Keymaps plugins
function M.setup_plugin_keymaps()
  -- NEO-TREE
  vim.keymap.set('n', '<C-n>', '<cmd>Neotree filesystem toggle<cr>', { desc = 'Toggle explorateur' })

  -- TELESCOPE
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Chercher fichiers' })
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Chercher contenu' })
  vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Voir buffers' })
  vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Fichiers récents' })

  -- GIT (optionnel - garde seulement si tu utilises)
  vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', { desc = 'Git status' })
  vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = 'Git commit' })
end

-- CHEAT SHEET
function M.show_cheatsheet()
  local cheatsheet = {
    "═══════════════════════════════════════════════════════════════════",
    "                       NEOVIM CHEAT SHEET                        ",
    "═══════════════════════════════════════════════════════════════════",
    "",
    " FICHIERS & NAVIGATION",
    "  <C-n>         Ouvrir/Fermer l'explorateur de fichiers",
    "  <Leader>ff    Chercher un fichier par nom",
    "  <Leader>fg    Chercher dans le contenu des fichiers",
    "  <Leader>fb    Liste des fichiers ouverts (buffers)",
    "  <Leader>fr    Fichiers récents",
    "",
    " FENÊTRES",
    "  <C-h/j/k/l>   Naviguer entre fenêtres (←↓↑→)",
    "  <Tab>         Buffer suivant",
    "  <S-Tab>       Buffer précédent",
    "  <Leader>x     Fermer le buffer actuel",
    "",
    " CODE (LSP)",
    "  gd            Aller à la définition",
    "  gr            Voir toutes les références",
    "  K             Voir la documentation",
    "  <Leader>r     Renommer (refactor)",
    "  <Leader>a     Actions disponibles (corrections)",
    "  <Leader>f     Formater le code",
    "",
    " DIAGNOSTICS",
    "  <Leader>d     Voir l'erreur détaillée",
    "  ]d            Erreur suivante",
    "  [d            Erreur précédente",
    "",
    " ESSENTIELS",
    "  <Leader>w     Sauvegarder",
    "  <Leader>q     Quitter",
    "  <Leader>h     Afficher cette aide",
    "",
    "═══════════════════════════════════════════════════════════════════",
    "  Leader = <Space>  |  Fermer cette fenêtre : q ou <Esc>",
    "═══════════════════════════════════════════════════════════════════",
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, cheatsheet)

  -- Configuration du buffer
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_name(buf, 'Cheat Sheet')

  vim.cmd('tabsplit')
  vim.api.nvim_win_set_buf(0, buf)

  -- Fermer avec q ou Esc
  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })

  vim.api.nvim_set_hl(0, 'CheatsheetText', { fg = '#008b8b' })
  vim.api.nvim_win_set_option(0, 'winhl', 'Normal:CheatsheetText')
end

function M.setup()
  M.setup_general_keymaps()
  M.setup_plugin_keymaps()
  M.setup_diagnostic_keymaps()
end

return M
