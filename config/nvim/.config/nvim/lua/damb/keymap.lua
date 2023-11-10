local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- normal mode (=n) --
keymap("n", "<Leader>e", ":Lex 30<CR>", opts)

-- open last buffer (i.e. the alternate file)
keymap("n", "<Leader><Leader>", "<C-^>", opts)

keymap("n", "<Leader>o", ":only<CR>", opts)
-- close buffer
keymap("n", "<Leader>q", ":quit<CR>", opts)
keymap("n", "<Leader>w", ":write<CR>", opts)
keymap("n", "<Leader>x", ":xit<CR>", opts)

-- search and replace
keymap(
  "n",
  "<Leader>s",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>",
  { noremap = true }
)

-- command-t
keymap("n", "<Leader>fb", "<Plug>(CommandTBuffer)", opts)
keymap("n", "<Leader>ff", "<Plug>(CommandT)", opts)
keymap("n", "<Leader>fg", "<Plug>(CommandTGit)", opts)
keymap("n", "<Leader>fj", "<Plug>(CommandTJump)", opts)
keymap("n", "<Leader>fr", "<Plug>(CommandTRipgrep)", opts)

-- undotree
keymap("n", "<Leader>u", ":UndotreeToggle<CR>", opts)

-- fugitive
keymap("n", "<Leader>gc", ":Git commit<CR>", opts)
keymap("n", "<Leader>gd", ":Git diff<CR>", opts)
keymap("n", "<Leader>gg", ":Git<CR>", opts)
keymap("n", "<Leader>gl", ":Git log<CR>", opts)
keymap("n", "<Leader>gp", ":Git push<CR>", opts)
keymap("n", "<Leader>gs", ":Git status<CR>", opts)

-- insert mode (=i) --

-- visual mode (=v) --

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- visual block vode (=x) --

-- move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- term mode (=t) --

-- command mode (=c) --
