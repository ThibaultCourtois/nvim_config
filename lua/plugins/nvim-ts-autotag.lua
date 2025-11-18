return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "InsertEnter",
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    per_filetype = {
      ["html"] = { enable_close = true },
      ["xml"] = { enable_close = true },
      ["xhtml"] = { enable_close = true },
      ["mjcf"] = { enable_close = true },
      ["svg"] = { enable_close = true },
      ["xsd"] = { enable_close = true },
      ["xsl"] = { enable_close = true },
      ["xslt"] = { enable_close = true },
    }
  },
}
