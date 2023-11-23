if vim.loader then
  vim.loader.enable()
end

require("damb.rc")
require("damb.keymap")
require("damb.plugins")
require("damb.commandt")
require("damb.autocmd")
require("damb.colorscheme")
require("damb.cmp")
require("damb.netrw")
require("damb.lsp")
require("damb.termdebug")
require("damb.treesitter")
require("damb.autopairs")
require("damb.illuminate")
require("damb.lualine")
