local success, nvim_tree = pcall(require, "nvim-tree")
if not success then
  vim.notify("WARN: failed to load 'nvim-tree' plugin")
  return
end

-- TODO(damb): display file icons. See: https://github.com/nvim-tree/nvim-tree.lua#requirements.

nvim_tree.setup({
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 40,
  },
})
