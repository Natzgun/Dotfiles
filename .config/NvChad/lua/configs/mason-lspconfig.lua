-- configs/mason-lspconfig.lua

local servers = require("configs.lspconfig")

-- Combinar simple + custom en una sola lista
local all_servers = {}
for _, s in ipairs(servers.simple) do
  table.insert(all_servers, s)
end
for _, s in ipairs(servers.custom) do
  table.insert(all_servers, s)
end

require("mason-lspconfig").setup({
  ensure_installed = all_servers,
  automatic_installation = false,
})
