vim.o.background = "dark" -- "dark|light"

vim.g.gruvbox_contrast_dark = "medium" -- "soft|medium|hard"
vim.g.gruvbox_contrast_light = "medium" -- "soft|medium|hard"

local colorscheme = "gruvbox"

local success, err = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not success then
  vim.notify(
    "WARN: failed to load colorscheme '"
      .. colorscheme
      .. "'; using colorscheme 'default'"
  )
  vim.cmd("colorscheme default")
end
