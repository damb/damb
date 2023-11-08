local success, lualine = pcall(require, "lualine")
if not success then
  vim.notify("WARN: failed to load 'lualine' plugin")
  return
end

lualine.setup({
  options = {
    theme = "gruvbox",
    ignore_focus = { "netrw" },
    extensions = { "fugitive", "man", "quickfix" },
  },
})
