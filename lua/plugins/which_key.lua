return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    -- Configuration de base
    wk.setup({
      preset = "modern",
      delay = 300,
      expand = 1,
      notify = true,
      triggers = {
        { "<leader>", mode = { "n", "v" } },
      },
    })

    -- Enregistrement des groupes et keymaps
    wk.add({
      -- Groupes principaux
      { "<leader>f",   group = "Find (Telescope)" },
      { "<leader>g",   group = "Git" },
      { "<leader>l",   group = "LSP" },
      { "<leader>d",   group = "Diagnostics" },
      { "<leader>dc",  group = "Diagnostics Copy" },

      -- Keymaps généraux
      { "<leader>w",   desc = "Save file" },
      { "<leader>q",   desc = "Quit" },
      { "<leader>x",   desc = "Close buffer" },
      { "<leader>e",   desc = "Focus Neotree" },
      { "<leader>?",   desc = "Show all keymaps" },

      -- Telescope
      { "<leader>ff",  desc = "Find files" },
      { "<leader>fg",  desc = "Live grep" },
      { "<leader>fb",  desc = "Find buffers" },
      { "<leader>fh",  desc = "Help tags" },
      { "<leader>fr",  desc = "Recent files" },

      -- Git
      { "<leader>gs",  desc = "Git status" },
      { "<leader>gd",  desc = "Git diff" },
      { "<leader>gc",  desc = "Git commit" },
      { "<leader>gp",  desc = "Git push" },
      { "<leader>gl",  desc = "Git pull" },
      { "<leader>gb",  desc = "Git blame" },

      -- LSP
      { "<leader>li",  desc = "LSP Info" },
      { "<leader>lr",  desc = "LSP Restart" },
      { "<leader>lf",  desc = "Format code" },
      { "<leader>rn",  desc = "Rename symbol" },
      { "<leader>ca",  desc = "Code actions" },
      { "<leader>K",   desc = "Signature help" },

      -- Diagnostics
      { "<leader>dd",  desc = "Show line diagnostics" },
      { "<leader>dl",  desc = "Diagnostics loclist" },

      -- Diagnostics Copy
      { "<leader>dcy", desc = "Copy line diagnostics" },
      { "<leader>dcY", desc = "Copy all diagnostics" },
      { "<leader>dcf", desc = "Show diagnostics in float" },
      { "<leader>dcT", desc = "Open diagnostics in tab" },

      -- Keymaps sans leader (pour référence)
      { "gd",          desc = "Go to definition" },
      { "gD",          desc = "Go to declaration" },
      { "gr",          desc = "Show references" },
      { "gi",          desc = "Go to implementation" },
      { "K",           desc = "Hover documentation" },
      { "[d",          desc = "Previous diagnostic" },
      { "]d",          desc = "Next diagnostic" },
      { "<C-n>",       desc = "Toggle Neotree" },
      { "<Tab>",       desc = "Next buffer" },
      { "<S-Tab>",     desc = "Previous buffer" },
      { "<C-h>",       desc = "Move to left window" },
      { "<C-j>",       desc = "Move to bottom window" },
      { "<C-k>",       desc = "Move to top window" },
      { "<C-l>",       desc = "Move to right window" },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Show all keymaps",
    },
  },
}
