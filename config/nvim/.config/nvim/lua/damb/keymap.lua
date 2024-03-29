local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- normal mode (=n) --
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- open last buffer (i.e. the alternate file)
keymap("n", "<Leader><Leader>", "<C-^>", opts)

keymap("n", "<Leader>o", ":only<CR>", opts)
-- close buffer
keymap("n", "<Leader>q", ":quit<CR>", opts)
keymap("n", "<Leader>w", ":write<CR>", opts)
keymap("n", "<Leader>x", ":xit<CR>", opts)

-- search and replace (mnemonic: replace)
keymap(
  "n",
  "<Leader>r",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>",
  { noremap = true }
)

-- disable cursor
keymap("n", "<Down>", "<Nop>", opts)
keymap("n", "<Left>", "<Nop>", opts)
keymap("n", "<Right>", "<Nop>", opts)
keymap("n", "<Up>", "<Nop>", opts)

-- command-t & ferret
keymap("n", "<Leader>fb", "<Plug>(CommandTBuffer)", opts)
keymap("n", "<Leader>ff", "<Plug>(CommandT)", opts)
keymap("n", "<Leader>fg", "<Plug>(CommandTGit)", opts)
keymap("n", "<Leader>fj", "<Plug>(CommandTJump)", opts)
keymap("n", "<Leader>fr", "<Plug>(CommandTRipgrep)", opts)
keymap("n", "<Leader>fa", ":Ack ", opts)

-- undotree
keymap("n", "<Leader>u", ":UndotreeToggle<CR>", opts)

-- fugitive
keymap("n", "<Leader>gc", ":Git commit<CR>", opts)
keymap("n", "<Leader>gd", ":Git diff<CR>", opts)
keymap("n", "<Leader>gg", ":Git<CR>", opts)
keymap("n", "<Leader>gl", ":Gclog %<CR>", opts)
keymap("n", "<Leader>gp", ":Git push<CR>", opts)
keymap("n", "<Leader>gs", ":Ggrep! --quiet ", opts) -- mnemonic: git search
keymap("n", "<Leader>gw", ":Gw<CR>", opts)

-- insert mode (=i) --

-- disable cursor
keymap("i", "<Down>", "<Nop>", opts)
keymap("i", "<Left>", "<Nop>", opts)
keymap("i", "<Right>", "<Nop>", opts)
keymap("i", "<Up>", "<Nop>", opts)

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
