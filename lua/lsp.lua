local lsp_configs = {
  "config.clangd",
  "config.cmake",
  "config.lua_ls",
  "config.ruff",
  "config.pyright",
  "config.lemminx"
}

local function setup_lsp_servers()
  for _, config_name in ipairs(lsp_configs) do
    local ok, config = pcall(require, config_name)
    if ok then
      local setup_ok, err = pcall(config.setup)
      if not setup_ok then
        print("Error setting up " .. config_name .. ": " .. err)
      end
    else
      print("Warning: Could not load " .. config_name)
    end
  end
end

setup_lsp_servers()
