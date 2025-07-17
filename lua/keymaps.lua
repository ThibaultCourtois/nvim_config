-- ~/.config/nvim/lua/keymaps.lua
local M = {}

-- Keymaps généraux (non-LSP)
function M.setup_general_keymaps()
  local opts = { silent = true }

  -- Navigation entre fenêtres
  vim.keymap.set('n', '<C-h>', '<C-w>h', vim.tbl_extend('force', opts, { desc = 'Move to left window' }))
  vim.keymap.set('n', '<C-j>', '<C-w>j', vim.tbl_extend('force', opts, { desc = 'Move to bottom window' }))
  vim.keymap.set('n', '<C-k>', '<C-w>k', vim.tbl_extend('force', opts, { desc = 'Move to top window' }))
  vim.keymap.set('n', '<C-l>', '<C-w>l', vim.tbl_extend('force', opts, { desc = 'Move to right window' }))

  -- Navigation entre buffers
  vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', vim.tbl_extend('force', opts, { desc = 'Next buffer' }))
  vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', vim.tbl_extend('force', opts, { desc = 'Previous buffer' }))

  -- Fermer buffer actuel sans fermer la fenêtre
  vim.keymap.set('n', '<leader>x', ':BufferLinePickClose<CR>', vim.tbl_extend('force', opts, { desc = 'Close buffer' }))

  -- Raccourcis pratiques
  vim.keymap.set('n', '<leader>w', ':w<CR>', vim.tbl_extend('force', opts, { desc = 'Save file' }))
  vim.keymap.set('n', '<leader>q', ':q<CR>', vim.tbl_extend('force', opts, { desc = 'Quit' }))

  -- Which-key helper
  vim.keymap.set('n', '<leader>?', function()
    require("which-key").show({ global = true })
  end, vim.tbl_extend('force', opts, { desc = 'Show all keymaps' }))
end

-- Keymaps diagnostics
function M.setup_diagnostic_keymaps()
  local opts = { silent = true }

  -- Navigation diagnostics
  vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float,
    vim.tbl_extend('force', opts, { desc = 'Show line diagnostics' }))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
  vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist,
    vim.tbl_extend('force', opts, { desc = 'Diagnostics loclist' }))

  vim.keymap.set('n', '<leader>dcy', function()
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
    if #diagnostics > 0 then
      local messages = {}
      for _, diag in ipairs(diagnostics) do
        table.insert(messages, diag.message)
      end
      vim.fn.setreg('+', table.concat(messages, '\n'))
      vim.notify('Diagnostic(s) de la ligne copiés dans le presse-papier')
    else
      vim.notify('Aucun diagnostic sur cette ligne')
    end
  end, vim.tbl_extend('force', opts, { desc = 'Copy line diagnostics' }))

  vim.keymap.set('n', '<leader>dcY', function()
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics > 0 then
      local messages = {}
      for _, diag in ipairs(diagnostics) do
        table.insert(messages, string.format("Ligne %d: %s", diag.lnum + 1, diag.message))
      end
      vim.fn.setreg('+', table.concat(messages, '\n'))
      vim.notify(string.format('%d diagnostic(s) copiés dans le presse-papier', #diagnostics))
    else
      vim.notify('Aucun diagnostic dans ce fichier')
    end
  end, vim.tbl_extend('force', opts, { desc = 'Copy all diagnostics' }))

  vim.keymap.set('n', '<leader>dcf', function()
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
    if #diagnostics > 0 then
      local messages = {}
      for _, diag in ipairs(diagnostics) do
        table.insert(messages, diag.message)
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, messages)
      vim.api.nvim_open_win(buf, true, {
        relative = 'cursor',
        width = math.min(80, vim.o.columns - 4),
        height = math.min(#messages, 10),
        row = 1,
        col = 0,
        border = 'rounded',
        title = 'Diagnostics (sélectionnables)',
        title_pos = 'center',
      })
      vim.cmd('normal! gg')
    else
      vim.notify('Aucun diagnostic sur cette ligne')
    end
  end, vim.tbl_extend('force', opts, { desc = 'Show diagnostics in float' }))

  vim.keymap.set('n', '<leader>dcT', function()
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics > 0 then
      local lines = {}
      local filename = vim.fn.expand('%:t')

      table.insert(lines, string.format('=== DIAGNOSTICS POUR %s ===', filename))
      table.insert(lines, string.format('Généré le: %s', os.date('%Y-%m-%d %H:%M:%S')))
      table.insert(lines, string.format('Total: %d diagnostic(s)', #diagnostics))
      table.insert(lines, '')

      local by_severity = {}
      for _, diag in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diag.severity]
        if not by_severity[severity] then
          by_severity[severity] = {}
        end
        table.insert(by_severity[severity], diag)
      end

      local severity_order = { 'ERROR', 'WARN', 'INFO', 'HINT' }
      for _, severity in ipairs(severity_order) do
        if by_severity[severity] then
          table.insert(lines, string.format('--- %s (%d) ---', severity, #by_severity[severity]))
          for _, diag in ipairs(by_severity[severity]) do
            table.insert(lines, string.format('Ligne %d: %s', diag.lnum + 1, diag.message))
            if diag.code then
              table.insert(lines, string.format('  Code: %s', diag.code))
            end
            if diag.source then
              table.insert(lines, string.format('  Source: %s', diag.source))
            end
            table.insert(lines, '')
          end
        end
      end

      vim.cmd('tabnew')
      local buf = vim.api.nvim_get_current_buf()

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_buf_set_name(buf, string.format('Diagnostics_%s_%s', filename, os.date('%H%M%S')))
      vim.bo[buf].filetype = 'text'
      vim.bo[buf].buftype = 'nofile'
      vim.bo[buf].bufhidden = 'wipe'
      vim.bo[buf].swapfile = false

      vim.cmd('normal! gg')
      vim.notify(string.format('Diagnostics ouverts dans un nouvel onglet (%d erreurs)', #diagnostics))
    else
      vim.notify('Aucun diagnostic dans ce fichier')
    end
  end, vim.tbl_extend('force', opts, { desc = 'Open diagnostics in tab' }))
end

-- Keymaps LSP
function M.setup_lsp_keymaps(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- Keymaps LSP communes
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Show references' }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover documentation' }))
  vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code actions' }))
  vim.keymap.set('n', '<leader>lf', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', opts, { desc = 'Format code' }))
end

-- Keymaps pour les plugins spécifiques
function M.setup_plugin_keymaps()
  local opts = { silent = true }

  -- Telescope - groupe "f" pour find
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>',
    vim.tbl_extend('force', opts, { desc = 'Find files' }))
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', vim.tbl_extend('force', opts, { desc = 'Live grep' }))
  vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>',
    vim.tbl_extend('force', opts, { desc = 'Find buffers' }))
  vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', vim.tbl_extend('force', opts, { desc = 'Help tags' }))
  vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>',
    vim.tbl_extend('force', opts, { desc = 'Recent files' }))

  -- Neo-tree
  vim.keymap.set('n', '<C-n>', '<cmd>Neotree filesystem toggle<cr>',
    vim.tbl_extend('force', opts, { desc = 'Toggle Neotree' }))
  vim.keymap.set('n', '<leader>e', '<cmd>Neotree filesystem focus<cr>',
    vim.tbl_extend('force', opts, { desc = 'Focus Neotree' }))

  -- Git - groupe "g" pour git
  vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', vim.tbl_extend('force', opts, { desc = 'Git status' }))
  vim.keymap.set('n', '<leader>gd', '<cmd>Gdiffsplit<cr>', vim.tbl_extend('force', opts, { desc = 'Git diff' }))
  vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>', vim.tbl_extend('force', opts, { desc = 'Git commit' }))
  vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>', vim.tbl_extend('force', opts, { desc = 'Git push' }))
  vim.keymap.set('n', '<leader>gl', '<cmd>Git pull<cr>', vim.tbl_extend('force', opts, { desc = 'Git pull' }))
  vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>', vim.tbl_extend('force', opts, { desc = 'Git blame' }))

  -- LSP-specific - groupe "l" pour lsp
  vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', vim.tbl_extend('force', opts, { desc = 'LSP Info' }))
  vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<cr>', vim.tbl_extend('force', opts, { desc = 'LSP Restart' }))
end

function M.setup()
  M.setup_general_keymaps()
  M.setup_plugin_keymaps()
  M.setup_diagnostic_keymaps()
end

return M
