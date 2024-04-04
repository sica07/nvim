local options = {
  backup = false,                          -- creates a backup file
  history = 50,                            -- store 50 line of command history
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showcmd = true,                          -- show incomplete cmds down the bottom
  showmatch = true,                        -- cursor show matching elements
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1,                         -- show tabs only when there are more than 1 tabs
  laststatus = 3,                          -- always show statusline but only for the last window
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  shiftround = false,                      -- When indenting lines, round the indentation to the nearest multiple of “shiftwidth.”
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- the width of a tab character (4)
  softtabstop = 4,                         -- edit as if tabs are 4 characters wide (number of columns for a tab)
  smarttab = false,                        --
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "auto",                     -- place signs over the top of line numbers
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "JetBrains Mono Light:h12",  -- the font used in graphical neovim applications
  autoindent = true,
  linespace = 10,
  spell = false,
  --netrw_liststyle=3
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Post to clockify
function clk()
    local current_line = vim.api.nvim_get_current_line()
    os.execute("clk dl \""..current_line.."\"")
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set ls=3" -- status line height
vim.cmd "set ch=1" -- command line height
vim.cmd [[set iskeyword+=-]]
vim.cmd "set path+=**" -- search the current directory recursively

-- enable list mode
vim.cmd "set list"
-- display chars for tabs and trailing spaces
--vim.cmd("set lcs=tab:>,trail:-")
