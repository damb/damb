local home = vim.env.HOME
local config = home .. "/.config/nvim"
local vi = vim.v.progname == "vi"
local root = vim.env.USER == "root"

vim.opt.autoindent = true -- maintain indent of current line
vim.opt.backup = false -- don't make backups before writing
vim.opt.backupcopy = "yes" -- overwrite files to update, instead of renaming + rewriting
vim.opt.backupdir = config .. "/backup//" -- keep backup files out of the way (ie. if 'backup' is ever set)
vim.opt.backupdir = vim.opt.backupdir + "." -- fallback
vim.opt.cursorline = true -- highlight current line
vim.opt.directory = config .. "/swap//" -- keep swap files out of the way
vim.opt.directory = vim.opt.directory + "." -- fallback
vim.opt.expandtab = true -- always use spaces instead of tabs
vim.opt.foldlevel = 1
vim.opt.foldmethod = "indent" -- folds are automatically defined by the indent of the lines
vim.opt.guicursor = "" -- disable cursor styling
vim.opt.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.incsearch = true -- show match while typing pattern
vim.opt.laststatus = 2 -- always show status line

if vi then
  vim.opt.loadplugins = false
end

vim.g.loaded_netrw = 1 -- disable netrw i.e. pretend netrw is already loaded
vim.g.loaded_netrwPlugin = 1
vim.opt.number = true -- show line numbers in gutter
vim.opt.pumblend = 10 -- pseudo-transparency for popup-menu
vim.opt.pumheight = 20 -- max number of lines to show in pop-up menu
vim.opt.relativenumber = true -- show relative numbers in gutter
vim.opt.scrolloff = 3 -- start scrolling 3 lines before edge of viewport

if root then
  vim.opt.shada = "" -- Don't create root-owned files.
  vim.opt.shadafile = "NONE"
else
  -- Defaults:
  --   Neovim: !,'100,<50,s10,h
  --
  -- - ! save/restore global variables (only all-uppercase variables)
  -- - '100 save/restore marks from last 100 files
  -- - <50 save/restore 50 lines from each register
  -- - s10 max item size 10KB
  -- - h do not save/restore 'hlsearch' setting
  --
  -- Our overrides:
  -- - '0 store marks for 0 files
  -- - <0 don't save registers
  -- - f0 don't store file marks
  -- - n: store in ~/.config/nvim/shada
  --
  vim.opt.shada = "'0,<0,f0,n" .. config .. "/shada"
end

vim.opt.shell = "sh" -- shell to use for `!`, `:!`, `system()` etc.
vim.opt.shiftwidth = 2 -- spaces per tab (when shifting)
vim.opt.sidescroll = 0 -- sidescroll in jumps because terminals are slow
vim.opt.sidescrolloff = 3 -- same as scrolloff, but for columns
vim.opt.spelllang = { "en", "de", "es", "pl", "fr" }
vim.opt.smartcase = true -- don't ignore case in searches if uppercase characters present
vim.opt.smartindent = true -- enable smart indenting
vim.opt.softtabstop = 2
vim.opt.splitbelow = true -- open horizontal splits below current window
vim.opt.splitright = true -- open vertical splits to the right of the current window
vim.opt.swapfile = false -- don't create swap files
vim.opt.tabstop = 2 -- spaces per tab
vim.opt.termguicolors = true -- use guifg/guibg instead of ctermfg/ctermbg in terminal (most terminals support this)
vim.opt.textwidth = 80 -- automatically hard wrap at 80 columns

if root then
  vim.opt.undofile = false -- don't create root-owned files
else
  vim.opt.undodir = config .. "/undo//" -- keep undo files out of the way
  vim.opt.undodir = vim.opt.undodir + "." -- fallback
  vim.opt.undofile = true -- actually use undo files
end

vim.opt.updatetime = 50 -- faster completion (4000ms default)
vim.opt.updatecount = 80 -- update swapfiles every 80 typed chars
vim.opt.viewdir = config .. "/view//" -- where to store files for `:mkview`
vim.opt.wildignore = vim.opt.wildignore + "*.o,*.so" -- patterns to ignore during file-navigation
vim.opt.writebackup = false -- don't keep backups after writing
