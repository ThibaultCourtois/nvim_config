return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Votre ASCII art personnalisé (remplacez par le vôtre)
    dashboard.section.header.val = {
    "                         ++                        ",
    "                         ++                        ",
    "                     ++  ++  ++                    ",
    "                      ++++++++                     ",
    "               +        ++++        ++             ",
    "             ++         ++++         ++            ",
    "            +++         ++++          +++          ",
    "          ++++          +++++         ++++         ",
    "         ++++           +++++          +++++       ",
    "       ++++++           +++++           +++++      ",
    "      ++++++            +++++           +++++++    ",
    "     ++++++++           +++++          ++++++++    ",
    "       ++++++++         +++++         ++++++++     ",
    "         ++++++++       +++++       ++++++++       ",
    "          +++++++++     +++++     ++++++++         ",
    "            ++++++++    +++++   ++++++++           ",
    "              ++++++++  +++++ ++++++++             ",
    "                ++++++++++++++++++++               ",
    "                  ++++++++++++++++                 ",
    "                    +++++++++++++                  ",
    "                      +++++++++                    ",
    "                    ++++++++++++                   ",
    "                  ++++++++++++++++                 ",
    "                 +++++++++++++++++++               ",
    "               +++++++++++++++++++++++             ",
    "             +++++++++  +++++  ++++++++            ",
    "           +++++++++    +++++    ++++++++          ",
    "         +++++++++      +++++     +++++++++        ",
    "       +++++++++        +++++       +++++++++      ",
    "     +++++++++          +++++         +++++++++    ",
    "    ++++++++            +++++           +++++++++  ",
    "     ++++++++           +++++          +++++++++   ",
    "       ++++++++         +++++        +++++++++     ",
    "        +++++++++       +++++      +++++++++       ",
    "          +++++++++     +++++    +++++++++         ",
    "            +++++++++   +++++   ++++++++           ",
    "              ++++++++ ++++++ ++++++++             ",
    "                ++++++++++++++++++++               ",
    "                  ++++++++++++++++                 ",
    "                    +++++++++++++                  ",
    "                      +++++++++                    ",
    "                       ++++++                      ",
    "                         ++                        ",
}

    -- Section des raccourcis mise à jour
    local shortcuts = {
      "                           RACCOURCIS NEOVIM                            ",
      "      <C-n> Neo-tree    <Leader>fg Live Grep    <Leader>h Helper        ",
      }

    -- Définir les couleurs personnalisées
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#008b8b" })
    vim.api.nvim_set_hl(0, "AlphaShortcuts", { fg = "#008b8b" })

    -- Supprimer complètement la section boutons
    dashboard.section.buttons.val = {}

    -- Configurer uniquement header et footer
    dashboard.section.footer.val = shortcuts

    -- Configuration du layout sans boutons
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 3 },
      dashboard.section.footer,
      { type = "padding", val = 2 },
    }

    -- Appliquer les couleurs
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.footer.opts.hl = "AlphaShortcuts"

    -- Désactiver le folding sur le buffer alpha
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])

    alpha.setup(dashboard.config)
  end
}
