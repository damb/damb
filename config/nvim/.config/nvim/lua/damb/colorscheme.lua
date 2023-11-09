vim.o.background = "dark" -- use "light" for light mode

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
