local success, lspconfig = pcall(require, "lspconfig")
if not success then
  vim.notify("WARN: failed to load 'lspconfig' plugin")
  return
end

local success, mason = pcall(require, "mason")
if not success then
  vim.notify("WARN: failed to load 'mason' plugin")
  return
end

local success, mason_lspconfig = pcall(require, "mason-lspconfig")
if not success then
  vim.notify("WARN: failed to load 'mason-lspconfig' plugin")
  return
end

local servers = {
  "bashls",
  "clangd",
  "cmake",
  "docker_compose_language_service",
  "dockerls",
  "lua_ls",
  "marksman",
  "pyright",
  "rust_analyzer",
}

local function settings()
  local icon = require("damb.icon")

  return {
    ui = {
      border = "none",
      icons = {
        package_installed = icon.package.Installed,
        package_pending = icon.package.Pending,
        package_uninstalled = icon.package.Uninstalled,
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  }
end

mason.setup(settings())
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = false,
})

local handler = require("damb.lsp.handler")

local opts = {}
for _, server in pairs(servers) do
  opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "damb.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
