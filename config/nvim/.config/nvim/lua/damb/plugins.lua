if vim.o.loadplugins then
  vim.cmd("packadd! LuaSnip")
  vim.cmd("packadd! cmp-buffer")
  vim.cmd("packadd! cmp-cmdline")
  vim.cmd("packadd! cmp-nvim-lsp")
  vim.cmd("packadd! cmp-nvim-lua")
  vim.cmd("packadd! cmp-path")
  vim.cmd("packadd! cmp_luasnip")
  vim.cmd("packadd! command-t")
  vim.cmd("packadd! friendly-snippets")
  vim.cmd("packadd! gruvbox.nvim")
  vim.cmd("packadd! lualine.nvim")
  vim.cmd("packadd! mason-lspconfig.nvim")
  vim.cmd("packadd! mason.nvim")
  vim.cmd("packadd! none-ls.nvim")
  vim.cmd("packadd! nvim-autopairs")
  vim.cmd("packadd! nvim-cmp")
  vim.cmd("packadd! nvim-lspconfig")
  vim.cmd("packadd! nvim-treesitter")
  vim.cmd("packadd! plenary.nvim")
  vim.cmd("packadd! termdebug")
  vim.cmd("packadd! undotree")
  vim.cmd("packadd! vim-commentary")
  vim.cmd("packadd! vim-fugitive")
  vim.cmd("packadd! vim-illuminate")
  vim.cmd("packadd! vim-repeat")
  vim.cmd("packadd! vim-surround")
end

-- Automatic, language-dependent indentation, syntax coloring and other
-- functionality.
--
-- Must come *after* the `:packadd!` calls above otherwise the contents of
-- package "ftdetect" directories won't be evaluated.
vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
