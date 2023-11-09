local M = {}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(
    bufnr,
    "n",
    "<leader>lf",
    "<cmd>lua vim.lsp.buf.format({async = true})<CR>",
    opts
  )
  keymap(
    bufnr,
    "x",
    "<leader>lf",
    "<cmd>lua vim.lsp.buf.format({async = true})<CR>",
    opts
  )
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

M.setup = function()
  local icon = require("damb.icon")
  local signs = {
    { name = "DiagnosticSignError", text = icon.diagnostic.BoldError },
    { name = "DiagnosticSignWarn", text = icon.diagnostic.BoldWarning },
    { name = "DiagnosticSignHint", text = icon.diagnostic.BoldHint },
    { name = "DiagnosticSignInfo", text = icon.diagnostic.BoldInformation },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" }
    )
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
end

local success, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if success then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
