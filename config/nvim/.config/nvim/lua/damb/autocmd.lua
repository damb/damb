local numbertoggle =
  vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  {
    pattern = "*",
    group = numbertoggle,
    command = "if &nu | set rnu | endif",
  }
)
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  {
    pattern = "*",
    group = numbertoggle,
    command = "if &nu | set nornu | endif",
  }
)

vim.api.nvim_create_autocmd(
  { "TermOpen" },
  { pattern = "*", command = "startinsert" }
)

vim.api.nvim_create_autocmd(
  { "BufReadPost" },
  { pattern = "fugitive://*", command = "set bufhidden=delete" }
)
