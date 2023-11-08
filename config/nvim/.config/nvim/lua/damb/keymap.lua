local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- normal mode (=n) --
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- command-t
keymap("n", "<Leader>ff", "<Plug>(CommandT)")
keymap("n", "<Leader>fb", "<Plug>(CommandTBuffer)")
keymap("n", "<Leader>fj", "<Plug>(CommandTJump)")
keymap("n", "<Leader>fg", "<Plug>(CommandTGit)")
keymap("n", "<Leader>fr", "<Plug>(CommandTRipgrep)")

-- insert mode (=i) --

-- visual mode (=v) --

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- visual block vode (=x) --

-- term mode (=t) --

-- command mode (=c) --
