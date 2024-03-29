local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Wrapped lines goes down/up to next row, rather than next line in file.
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- insert new line while in normal mode
keymap("n", "zj", "moo<esc>k`o", opts)
keymap("n", "zk", "moI<esc>`o", opts)

keymap("n", "<leader>k", ":lua lnk()<CR><CR>", opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate tabs
keymap("n", "<S-l>", ":tabnext<CR>", opts)
keymap("n", "<S-h>", ":tabprevious<CR>", opts)

-- Split current window
keymap("n", "vv", "<C-w>v", opts)
keymap("n", "ss", "<C-w>s", opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Stop that stupid ex mode
keymap("n", "Q", "<nop>", opts)


-- Yank from the cursor to the end of the line, to be consistent with C and D.
keymap("n", "Y", "y$", opts)

-- Fast previous buffer switching
-- keymap("n", "<Backspace>", "<C-^>", opts)

-- Write readonly file
keymap("c", "w!!", "w !sudo tee > /dev/null %", opts)

-- Insert --
-- Press jj fast to change to normal mode
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)


-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("v", "p", '"_dP', opts)

vim.cmd[[
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)
]]
