local success, null_ls = pcall(require, "null-ls")
if not success then
  vim.notify("WARN: failed to load 'none-ls' plugin")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- XXX(damb): in order to avoid LSP formatting conflicts,
-- see: https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08

null_ls.setup({
  debug = false,
  sources = {
    formatting.black,
    formatting.stylua,
    formatting.shfmt,
    formatting.clang_format,
    formatting.cmake_format,
    diagnostics.shellcheck,
    diagnostics.flake8,
  },
})
