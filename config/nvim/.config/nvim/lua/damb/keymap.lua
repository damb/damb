local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- normal mode (=n) --
keymap("n", "<Leader>e", ":Lex 30<CR>", opts)

-- command-t
keymap("n", "<Leader>ff", "<Plug>(CommandT)")
keymap("n", "<Leader>fb", "<Plug>(CommandTBuffer)")
keymap("n", "<Leader>fj", "<Plug>(CommandTJump)")
keymap("n", "<Leader>fg", "<Plug>(CommandTGit)")
keymap("n", "<Leader>fr", "<Plug>(CommandTRipgrep)")

-- search and replace
keymap(
  "n",
  "<Leader>s",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>",
  { noremap = true }
)

-- undotree
keymap("n", "<Leader>u", ":UndotreeToggle<CR>", opts)


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
