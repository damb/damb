local success, ts_config = pcall(require, "nvim-treesitter.configs")
if not success then
  vim.notify("WARN: failed to load 'treesitter' plugin")
  return
end

ts_config.setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "dockerfile",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
    "xml",
    "yaml",
  },
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
})
