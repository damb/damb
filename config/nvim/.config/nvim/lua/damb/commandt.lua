local success, commandt = pcall(require, "wincent.commandt")
if not success then
  vim.notify("WARN: failed to load 'command-t' plugin")
  return
end

commandt.setup({
  height = 30, -- Default is 15.
  scanners = {
    file = {
      max_files = 1000000,
    },
    find = {
      max_files = 1000000,
    },
    rg = {
      max_files = 1000000,
    },
  },
})
