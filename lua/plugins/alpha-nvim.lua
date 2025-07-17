return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Votre ASCII art personnalisé (remplacez par le vôtre)
    dashboard.section.header.val = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢀⡄⣠⢄⣴⣠⣶⣠⣾⣤⣀⣴⣠⢄⣠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      " ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣄⣀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣷⣿⣿⣿⣿⠏⣿⣿⣿⡿⢏⣽⢋⡟⣹⣿⣿⢿⢿⣿⣿⣿⣿⣿⣷⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠙⣿⡟⣿⠘⣿⣩⣿⣠⣾⣿⣿⣿⣿⣿⣿⣶⣿⡧⠞⣿⣿⣿⣿⣿⣿⣶⠆⠀⠀⠀⠀⠀⠀⠀",
      "  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣼⣿⣾⣷⣿⣿⡿⣿⡏⢻⣏⠁⠻⣯⠙⢿⣿⣿⣿⣯⣉⣻⣿⣿⣿⣿⣿⣏⡀⠀⠀⠀⠀⠀",
      "⣀⣠⣀⡀⠀⠀⠀⠀⠀⠀⠀⣰⢿⣿⣿⣿⢿⣿⢿⡿⠉⣿⠀⢻⣇⠀⠙⢆⠀⢻⡄⠘⢿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⡷⠂⠀⠀⠀⠀",
      "⡽⣿⠹⡉⠓⢦⠀⠀⠀⠀⠀⠃⣾⢿⢿⡏⢸⡇⠸⡇⠀⠙⢆⣀⣽⡶⠶⠾⢷⣾⡧⠀⠈⠻⣿⣿⣟⣻⣿⣿⣿⣿⣿⣿⣷⡃⠀⠀⠀⠀",
      "⡖⣿⣇⢣⠀⠘⡄⠀⠀⠀⠀⠀⣯⡼⠈⢇⠈⠻⣤⣽⣦⡶⠟⢋⣁⣀⣀⣀⣠⠞⠀⠀⠀⠀⢿⣿⣯⢷⣾⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀",
      "⠤⠉⣿⡾⢦⣤⡇⠀⠀⠀⠀⠀⠸⣿⠒⠚⢿⠀⠈⠙⠿⣶⣿⣿⠿⠿⠿⠭⠛⠀⠀⠀⠀⠀⢸⣿⣿⣿⢿⣟⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀",
      "⣦⣼⢷⣾⠯⠭⣧⠀⠀⠀⠀⠀⠀⣿⡷⣾⠟⠑⠂⠀⠀⠀⠈⠉⠀⢠⣤⣴⣦⣤⣤⡀⠀⠀⢸⣿⡟⣡⣾⣿⣿⣿⣿⣿⣿⡋⠀⠀⠀⠀",
      "⠈⢻⡿⠁⣀⠤⠼⣆⠀⠀⠀⠀⠀⡎⢰⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣦⠤⠄⠀⠀⠙⠿⢸⡟⠻⣏⡻⣿⣿⣿⡏⠀⠀⠀⠀⠀",
      "⠀⣸⢻⡏⠀⣀⡤⠼⡄⠀⠀⠀⠀⡇⠈⢿⣿⡿⠟⠀⠀⠀⠀⠀⠀⠸⢿⣿⣿⠛⠓⠒⠀⠀⠀⠀⣺⡗⠚⠋⣡⣿⣿⣿⠆⠀⠀⠀⠀⠀",
      "⠀⡏⢸⢳⣎⡴⠂⠉⢹⡄⠀⠀⠀⢣⠀⣤⠽⠦⠤⣀⠀⠀⠀⠀⠀⠀⠘⣿⣟⠀⠀⠀⠀⠀⠀⢠⡉⠁⣠⣾⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀",
      "⠀⣧⠋⣸⢻⣀⠔⠉⠁⠹⡄⠀⠀⢸⠀⢯⠶⠶⣦⣄⠙⠢⠀⠀⠀⠀⠀⠈⣿⠷⠀⠀⠀⠀⠀⡞⢓⡞⠉⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀",
      "⣶⠃⢠⡇⠀⢷⠖⡽⠋⠉⠹⡄⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡾⠁⢰⡇⠀⢸⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀",
      "⣽⠀⢸⡇⠀⠈⢟⣇⣀⣠⠤⠽⡄⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⡾⣿⠁⠀⢈⡇⠀⠘⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⢸⠀⢸⡄⠀⠀⠘⣿⣯⠀⠀⠀⠙⣄⣧⣤⣤⣴⣦⣤⣴⣤⣤⣠⣤⣴⣶⣿⣿⣿⠟⠉⢠⠋⠀⠀⢼⡇⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⡇⣾⡇⠀⠀⠀⠸⡽⣷⣴⠒⠒⠛⣏⠙⠛⠿⣿⣿⣿⣿⣿⣿⣿⢿⣿⠟⠋⠀⠀⢀⣽⠃⠀⠀⠘⡇⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠸⣧⠇⠀⠀⠀⠀⠹⣿⣧⡠⠔⠒⠚⢧⠀⠀⠈⣿⣻⠛⣿⣿⡷⠛⠁⠀⠀⠀⢀⣼⡏⠀⠀⠀⠈⢿⠀⠀⠘⡆⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠹⡄⠀⠀⠀⠀⠀⠹⡛⣦⡀⢀⣀⠬⢧⡀⠀⢸⣿⠖⠛⠁⠀⠀⠀⠀⠀⠀⠘⢻⠃⠀⠀⠀⠀⢸⡀⠀⠀⢣⣀⠤⠖⠒⠒⠒⠢⢤",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⣸⡗⠉⠀⠀⢀⣱⡄⠈⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⠀⣸⡧⠴⠚⠉⠀⣀⣀⡄⠀⠀⢀⡀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢏⢛⣶⠖⢊⣉⣀⠽⠦⣽⣷⡀⠀⠀⠀⠀⠀⠀⢀⣿⠋⠀⣠⠴⠚⠉⠀⣀⣠⣴⣾⣿⣿⣿⣷⣷⣶⣿⣿",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣾⡿⠞⠉⠓⠲⣶⣿⣿⣿⢧⠀⠀⠀⠀⠀⠀⢀⡿⠖⠋⠁⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁",
      "⠀⠀⠀⠀⠀⠀⢀⡤⢺⣿⣿⣟⣫⣴⣶⣤⣤⣀⣀⣙⣿⣿⣬⣤⣤⠤⣤⠴⠚⢉⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⣀⣠⣴⣾"
    }

    -- Section des raccourcis mise à jour
    local shortcuts = {
      "                           RACCOURCIS NEOVIM                           ",
      "                                                                       ",
      "  Leader = <Space>                                                     ",
      "                                                                       ",
      "  NAVIGATION                                                           ",
      "    <C-n>         : Ouvrir/Fermer Neo-tree                            ",
      "    <Leader>e     : Focus Neo-tree                                     ",
      "    <Leader>ff    : Telescope find files                               ",
      "    <Leader>fg    : Telescope live grep                                ",
      "    <Leader>fb    : Telescope buffers                                  ",
      "    <Leader>fr    : Telescope recent files                             ",
      "    <Tab>         : Buffer suivant                                     ",
      "    <S-Tab>       : Buffer précédent                                   ",
      "    <Leader>x     : Fermer buffer                                      ",
      "                                                                       ",
      "  LSP                                                                  ",
      "    gd            : Aller à la définition                             ",
      "    gD            : Aller à la déclaration                            ",
      "    gr            : Voir les références                               ",
      "    gi            : Aller à l'implémentation                          ",
      "    K             : Hover documentation                               ",
      "    <Leader>K     : Signature help                                    ",
      "    <Leader>rn    : Renommer                                          ",
      "    <Leader>ca    : Actions de code                                   ",
      "    <Leader>lf    : Formater le code                                  ",
      "    <Leader>li    : LSP Info                                          ",
      "    <Leader>lr    : LSP Restart                                       ",
      "                                                                       ",
      "  DIAGNOSTICS                                                         ",
      "    ]d            : Diagnostic suivant                                ",
      "    [d            : Diagnostic précédent                              ",
      "    <Leader>dd    : Ouvrir diagnostic float                           ",
      "    <Leader>dl    : Liste des diagnostics                             ",
      "    <Leader>dcy   : Copier diagnostic ligne                           ",
      "    <Leader>dcY   : Copier tous les diagnostics                       ",
      "    <Leader>dcf   : Diagnostic dans fenêtre flottante                 ",
      "    <Leader>dcT   : Diagnostic dans nouvel onglet                     ",
      "                                                                       ",
      "  GIT                                                                 ",
      "    <Leader>gs    : Git status                                        ",
      "    <Leader>gd    : Git diff                                          ",
      "    <Leader>gc    : Git commit                                        ",
      "    <Leader>gp    : Git push                                          ",
      "    <Leader>gl    : Git pull                                          ",
      "    <Leader>gb    : Git blame                                         ",
      "                                                                       ",
      "  AUTRES                                                              ",
      "    <Leader>w     : Sauvegarder                                       ",
      "    <Leader>q     : Quitter                                           ",
      "    <Leader>?     : Afficher tous les keymaps                         ",
      "                                                                       ",
    }

    -- Définir les couleurs personnalisées
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#8be9fd" })
    vim.api.nvim_set_hl(0, "AlphaShortcuts", { fg = "#f8f8f2" })

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
