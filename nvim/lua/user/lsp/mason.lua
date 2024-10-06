local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok_1 then
  return
end

local servers = {
--  'solargraph',
--  'pyright'
}

-- declare settings to pass to the mason
local settings = {
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_install = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local opts = {}

-- loop through the servers
for _, server in pairs(servers) do
  opts = {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities
  }

  -- server name
  server = vim.split(server, '@')[1]

  -- pass them to lspconfig
  lspconfig[server].setup(opts)
end
