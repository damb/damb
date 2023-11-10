local success, ts_config = pcall(require, "nvim-treesitter.configs")
if not success then
  vim.notify("WARN: failed to load 'treesitter' plugin")
  return
end

ts_config.setup({
  ensure_installed = {
    "bash",
    "bibtex",
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
    "toml",
    "vimdoc",
    "xml",
    "yaml",
  },
  ignore_install = { "" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
})
