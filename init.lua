_G.Config = {}

local gr = vim.api.nvim_create_augroup('custom-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end


-- ┌──────────────────────────┐
-- │ Built-in Neovim behavior │
-- └──────────────────────────┘
--
-- This file defines Neovim's built-in behavior. The goal is to improve overall
-- usability in a way that works best with MINI.
--
-- Here `vim.o.xxx = value` sets default value of option `xxx` to `value`.
-- See `:h 'xxx'` (replace `xxx` with actual option name).
--
-- Option values can be customized on per buffer or window basis.
-- See 'after/ftplugin/' for common example.

-- stylua: ignore start
-- The next part (until `-- stylua: ignore end`) is aligned manually for easier
-- reading. Consider preserving this or remove `-- stylua` lines to autoformat.

-- General ====================================================================
vim.g.mapleader = ' ' -- Use `<Space>` as <Leader> key

vim.o.mouse         = 'a'            -- Enable mouse
vim.o.mousescroll   = 'ver:25,hor:6' -- Customize mouse scroll
vim.o.undofile      = true           -- Enable persistent undo
vim.o.termguicolors = true
vim.o.swapfile      = false

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- UI =========================================================================
vim.o.breakindent    = true       -- Indent wrapped lines to match line start
vim.o.breakindentopt = 'list:-1'  -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn    = '+1'       -- Draw column on the right of maximum width
vim.o.cursorline     = true       -- Enable current line highlighting
vim.o.linebreak      = true       -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list           = true       -- Show helpful text indicators
vim.o.number         = true       -- Show line numbers
vim.o.relativenumber = true       -- Show relative line numbers
vim.o.pumheight      = 10         -- Make popup menu smaller
vim.o.ruler          = false      -- Don't show cursor coordinates
vim.o.shortmess      = 'CFOSWaco' -- Disable some built-in completion messages
vim.o.showmode       = false      -- Don't show mode in command line
vim.o.signcolumn     = 'yes'      -- Always show signcolumn (less flicker)
vim.o.splitbelow     = true       -- Horizontal splits will be below
vim.o.splitkeep      = 'screen'   -- Reduce scroll during window split
vim.o.splitright     = true       -- Vertical splits will be to the right
vim.o.statuscolumn   = "%l%s"
vim.o.winborder      = 'rounded'   -- Use border in floating windows
vim.o.wrap           = false      -- Don't visually wrap lines (toggle with \w)

vim.o.cursorlineopt  = 'screenline,number' -- Show cursor line per screen line

-- Special UI symbols. More is set via 'mini.basics' later.
vim.o.fillchars = 'eob: ,fold:╌'
vim.o.listchars = 'extends:·,nbsp:ׅׅ,precedes:·,tab:  ,multispace:ׅׅ'

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldlevel   = 10       -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod  = 'indent' -- Fold based on indent level
vim.o.foldnestmax = 10       -- Limit number of fold levels
-- vim.o.foldtext    = ''       -- Show text under fold with its highlighting
vim.o.foldtext    = 'v:lua.vim.treesitter.foldtext()'

-- Editing ====================================================================
-- vim.o.autoindent    = true    -- Use auto indent
-- vim.o.expandtab     = true    -- Convert tabs to spaces
vim.o.confirm       = true    -- Confirm before restart
vim.o.formatoptions = 'rqnl1j'-- Improve comment editing
vim.o.ignorecase    = true    -- Ignore case during search
vim.o.incsearch     = true    -- Show search matches while typing
vim.o.infercase     = true    -- Infer case in built-in completion
vim.o.shiftwidth    = 4       -- Use this number of spaces for indentation
vim.o.smartcase     = true    -- Respect case if search pattern has upper case
vim.o.smartindent   = true    -- Make indenting smart
vim.o.spelloptions  = 'camel' -- Treat camelCase word parts as separate words
vim.o.tabstop       = 4       -- Show tab as this number of spaces
vim.o.softtabstop   = 4
vim.o.virtualedit   = 'block' -- Allow going past end of line in blockwise mode

vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.grepprg = '/usr/bin/rg --vimgrep -u --no-heading --glob "!.git" --follow $*'
vim.o.grepformat = '%f:%l:%c:%m'

-- Built-in completion
vim.o.complete    = '.,w,b,kspell'                  -- Use less sources
-- vim.o.completeopt = 'menuone,noselect,fuzzy,nosort' -- Use custom behavior
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.o.wildmenu    = true
vim.o.wildmode    = 'noselect:longest:lastused,full'

vim.o.path           = '.,**'
vim.o.diffopt        = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram' -- smooth conflict resolution
vim.g.have_nerd_font = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- Autocommands ===============================================================

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local f = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
_G.Config.new_autocmd('FileType', nil, f, "Proper 'formatoptions'")

-- There are other autocommands created by 'mini.basics'. See 'plugin/30_mini.lua'.

-- Diagnostics ================================================================

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = 'HINT', max = 'ERROR' } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
vim.diagnostic.config(diagnostic_opts);
-- stylua: ignore end

-- ┌─────────────────┐
-- │ Custom mappings │
-- └─────────────────┘
--
-- This file contains definitions of custom general and Leader mappings.

-- General mappings ===========================================================

-- Use this section to add custom general mappings. See `:h vim.keymap.set()`.

-- An example helper to create a Normal mode mapping
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
nmap('[p', '<Cmd>exe "put! " . v:register<CR>', 'Paste Above')
nmap(']p', '<Cmd>exe "put "  . v:register<CR>', 'Paste Below')

-- Many general mappings are created by 'mini.basics'. See 'plugin/30_mini.lua'

-- stylua: ignore start
-- The next part (until `-- stylua: ignore end`) is aligned manually for easier
-- reading. Consider preserving this or remove `-- stylua` lines to autoformat.

-- Leader mappings ============================================================

-- Neovim has the concept of a Leader key (see `:h <Leader>`). It is a configurable
-- key that is primarily used for "workflow" mappings (opposed to text editing).
-- Like "open file explorer", "create scratch buffer", "pick from buffers".
--
-- In 'plugin/10_options.lua' <Leader> is set to <Space>, i.e. press <Space>
-- whenever there is a suggestion to press <Leader>.
--
-- This config uses a "two key Leader mappings" approach: first key describes
-- semantic group, second key executes an action. Both keys are usually chosen
-- to create some kind of mnemonic.
-- Example: `<Leader>f` groups "find" type of actions; `<Leader>ff` - find files.
-- Use this section to add Leader mappings in a structural manner.
--
-- Usually if there are global and local kinds of actions, lowercase second key
-- denotes global and uppercase - local.
-- Example: `<Leader>fs` / `<Leader>fS` - find workspace/document LSP symbols.
--
-- Many of the mappings use 'mini.nvim' modules set up in 'plugin/30_mini.lua'.

-- Create a global table with information about Leader groups in certain modes.
-- This is used to provide 'mini.clue' with extra clues.
-- Add an entry if you create a new group.
_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Bookmarks/Edit' },
  -- { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  -- { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },

  { mode = 'x', keys = '<Leader>g', desc = '+iGit' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

-- Helpers for a more concise `<Leader>` mappings.
-- Most of the mappings use `<Cmd>...<CR>` string as a right hand side (RHS) in
-- an attempt to be more concise yet descriptive. See `:h <Cmd>`.
-- This approach also doesn't require the underlying commands/functions to exist
-- during mapping creation: a "lazy loading" approach to improve startup time.
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end

-- e is for 'Explore' and 'Edit'. Common usage:
-- - `<Leader>ed` - open explorer at current working directory
-- - `<Leader>ef` - open directory of current file (needs to be present on disk)
-- - `<Leader>ei` - edit 'init.lua'
-- - All mappings that use `edit_plugin_file` - edit 'plugin/' config files
local edit_plugin_file = function(filename)
  return string.format('<Cmd>edit %s/plugin/%s<CR>', vim.fn.stdpath('config'), filename)
end
local explore_at_file = '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>'
local explore_quickfix = function()
  for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.fn.getwininfo(win_id)[1].quickfix == 1 then return vim.cmd('cclose') end
  end
  vim.cmd('copen')
end

nmap_leader('be', '<Cmd>lua MiniFiles.open()<CR>',          'Directory')
nmap_leader('bi', '<Cmd>edit $MYVIMRC<CR>',                 'init.lua')
nmap_leader('bf', explore_at_file,                          'File directory')
nmap_leader('bn', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
nmap_leader('bq', explore_quickfix,                         'Quickfix')

-- f is for 'Fuzzy Find'. Common usage:
-- - `<Leader>ff` - find files; for best performance requires `ripgrep`
-- - `<Leader>fg` - find inside files; requires `ripgrep`
-- - `<Leader>fh` - find help tag
-- - `<Leader>fr` - resume latest picker
-- - `<Leader>fv` - all visited paths; requires 'mini.visits'
--
-- All these use 'mini.pick'. See `:h MiniPick-overview` for an overview.
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',            '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',            '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',     'Added hunks (all)')
nmap_leader('fA', pick_added_hunks_buf,                         'Added hunks (buf)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>',                      'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>',                  'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>',         'Commits (buf)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>',       'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>',   'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>',                        'Files')
nmap_leader('/' , '<Cmd>Pick grep_live<CR>',                    'Grep live')
nmap_leader('e' , '<Cmd>lua MiniFiles.open()<CR>',                    'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',       'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>',                         'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',                    'Highlight groups')
nmap_leader('fj', '<Cmd>Pick list scope="jump"<cr>',            'Jumplist')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>',        'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>',    'Lines (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                    'Modified hunks (all)')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',           'Modified hunks (buf)')
nmap_leader('fr', '<Cmd>Pick resume<CR>',                       'Resume')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>',       'References (LSP)')
nmap_leader('fs', pick_workspace_symbols_live,                  'Symbols workspace (live)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>',  'Symbols document')
nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>',           'Visit paths (all)')
nmap_leader('fV', '<Cmd>Pick visit_paths<CR>',                  'Visit paths (cwd)')

-- g is for 'Git'. Common usage:
-- - `<Leader>gs` - show information at cursor
-- - `<Leader>go` - toggle 'mini.diff' overlay to show in-buffer unstaged changes
-- - `<Leader>gd` - show unstaged changes as a patch in separate tabpage
-- - `<Leader>gL` - show Git log of current file
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

nmap_leader('ga', '<Cmd>Git diff --cached<CR>',             'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>',        'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>',                    'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>',            'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>',                      'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>',                 'Diff buffer')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>',         'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>',     'Log buffer')
nmap_leader('gh', '<cmd>:Gitsigns preview_hunk<cr>', "Preview hunk")
nmap_leader('gb', '<cmd>:Gitsigns blame_line<cr>', "Show blame at cursor")
nmap_leader('gB', '<cmd>:Gitsigns blame<cr>', "Buffer blame")

nmap("]gh", '<cmd>:Gitsigns next_hunk<cr>', "Git next hunk" )
nmap("]gh", '<cmd>:Gitsigns next_hunk<cr>', "Git prev hunk" )
nmap("]gh", '<cmd>:Gitsigns next_hunk<cr>', "Git prev hunk" )
nmap("gm", '<cmd>:Git checkout aynax_master<cr>', "Go master")

-- l is for 'Language'. Common usage:
-- - `<Leader>ld` - show more diagnostic details in a floating window
-- - `<Leader>lr` - perform rename via LSP
-- - `<Leader>ls` - navigate to source definition of symbol under cursor
--
-- NOTE: most LSP mappings represent a more structured way of replacing built-in
-- LSP mappings (like `:h gra` and others). This is needed because `gr` is mapped
-- by an "replace" operator in 'mini.operators' (which is more commonly used).
-- local formatting_cmd = '<Cmd>lua require("conform").format({lsp_fallback=true})<CR>'

nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',     'Actions')
nmap_leader('lc', '<Cmd>lua vim.lsp.codelens.enable()<CR>',     'Codelens')
nmap_leader('lC', '<Cmd>lua vim.lsp.codelens.run()<CR>',        'Codelens here')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>',   'Diagnostic popup')
-- nmap_leader('lf', formatting_cmd,                               'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>',  'Implementation')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>',           'Hover')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',          'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',      'References')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>',      'Source definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

-- xmap_leader('lf', formatting_cmd, 'Format selection')

-- o is for 'Other'. Common usage:
-- - `<Leader>oz` - toggle between "zoomed" and regular view of current buffer
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end
nmap_leader('s', new_scratch_buffer,                            'Scratch')
nmap_leader('z', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- s is for 'Session'. Common usage:
-- - `<Leader>sn` - start new session
-- - `<Leader>sr` - read previously started session
-- - `<Leader>sd` - delete previously started session
local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'

nmap_leader('sd', '<Cmd>lua MiniSessions.select("delete")<CR>', 'Delete')
nmap_leader('sn', '<Cmd>lua ' .. session_new .. '<CR>',         'New')
nmap_leader('sr', '<Cmd>lua MiniSessions.select("read")<CR>',   'Read')
nmap_leader('sw', '<Cmd>lua MiniSessions.write()<CR>',          'Write current')

-- o is for 'Obisidian'
nmap_leader('oo', '<Cmd>Obsidian follow_link vsplit<cr>', "Follow link" )
nmap_leader('of', '<Cmd>Obsidian quick_switch<cr>', "Find" )
nmap_leader('or', '<Cmd>Obsidian rename', "rename" )
nmap_leader('on', '<Cmd>Obsidian new_from_template', "New note" )
nmap_leader('ob', '<Cmd>Obsidian backlinks<cr>', "Backlinks" )
nmap_leader('ot', '<Cmd>Obsidian tags<cr>', "Tags" )
nmap_leader('o/', '<Cmd>Obsidian search<cr>', "grep" )

-- v is for 'Visits'. Common usage:
-- - `<Leader>vv` - add    "core" label to current file.
-- - `<Leader>vV` - remove "core" label to current file.
-- - `<Leader>vc` - pick among all files with "core" label.
local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end

nmap_leader('vc', make_pick_core('',  'Core visits (all)'),       'Core visits (all)')
nmap_leader('vC', make_pick_core(nil, 'Core visits (cwd)'),       'Core visits (cwd)')
nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')
--

-- stylua: ignore end
--
-- ┌─────────┐
-- │ Plugins │
-- └─────────┘
--
vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim" },
    -- { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    -- colorscheme(s)
	{ src = "https://github.com/rktjmp/lush.nvim" },
    { src = "https://github.com/drewxs/ash.nvim" },
    { src = "https://github.com/EdenEast/nightfox.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/zenbones-theme/zenbones.nvim" },
    { src = "https://github.com/miikanissi/modus-themes.nvim" },
	{ src = "https://github.com/dybdeskarphet/gruvbox-minimal.nvim"},
	{ src = "https://github.com/p00f/alabaster.nvim"},
	{ src = "https://github.com/projekt0n/github-nvim-theme", name = "github-theme"},
	{ src = "https://github.com/nordtheme/vim"},
    -- lsp
    { 
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context"},
    -- { src = 'https://github.com/Bekaboo/dropbar.nvim'},
    { src = "https://github.com/neovim/nvim-lspconfig"},
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp", version ="v1.8.0"},
    { src = "https://github.com/obsidian-nvim/obsidian.nvim"},
    -- DB
    { src = "https://github.com/tpope/vim-dadbod" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
    -- AI
    { src = "https://github.com/sourcegraph/amp.nvim" },
	-- Others
    { src = "https://github.com/lowitea/aw-watcher.nvim" },
}, { load = true })


vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
	vim.cmd.hi 'Comment gui=italic'
	vim.cmd.hi 'Keyword gui=bold'
	vim.cmd.hi 'Type gui=italic,bold'
	vim.api.nvim_set_hl(0, "Whitespace", { link = "Comment" })
	vim.api.nvim_set_hl(0, "NonText",    { link = "Comment" })
	vim.api.nvim_set_hl(0, "SpecialKey", { link = "Comment" })
	vim.g.alabaster_dim_comments = true -- for alabaster colorscheme
	vim.opt_local.iskeyword:remove('$')
  end,
})

require('aw_watcher').setup({
	aw_server = {
		host = "127.0.0.1",
		port = 5600
	}
})

require('modus-themes').setup({
	line_nr_column_background=false,
	sign_column_background=false,
});
vim.o.background="dark"
vim.cmd.colorscheme("nordbones")



-- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require('mini.icons').setup({
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })

-- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()

require('mini.misc').setup()
  -- Change current working directory based on the current file path. It
  -- searches up the file tree until the first root marker ('.git' or 'Makefile')
  -- and sets their parent directory as a current directory.
  -- This is helpful when simultaneously dealing with files from several projects.
  MiniMisc.setup_auto_root()
  -- Restore latest cursor position on file open
  MiniMisc.setup_restore_cursor()
  -- Synchronize terminal emulator background with Neovim's background to remove
  -- possibly different color padding around Neovim instance
  MiniMisc.setup_termbg_sync()
require('mini.notify').setup()
require('mini.bracketed').setup()
require('mini.sessions').setup()
require('mini.animate').setup()
require('mini.surround').setup()
require('mini.indentscope').setup({symbol = '݃'}) -- ·⁞⦙
require('mini.files').setup()
require('mini.extra').setup()
require('mini.align').setup()
require('mini.visits').setup()

local choose_all = function()
  local mappings = MiniPick.get_picker_opts().mappings
  vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
end

require('mini.pick').setup({
mappings = {
	choose_all = { char = '<C-q>', func = choose_all }, -- choose all and send to quickfix
},
window = {
    config = function()
      local height = math.floor(vim.o.lines * 0.4) -- 40% of total height
      return {
        width = vim.o.columns,
        height = height,
        row = math.floor((vim.o.lines - height) / 2), -- center vertically
      }
    end,
  },
})
local miniclue = require('mini.clue')
  -- stylua: ignore
  miniclue.setup({
      window = {
          config = function()
              return { width = math.floor(vim.o.columns * 0.30) }
          end
      },
    clues = {
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      -- This creates a submode for window resize mappings. Try the following:
      -- - Press `<C-w>s` to make a window split.
      -- - Press `<C-w>+` to increase height. Clue window still shows clues as if
      --   `<C-w>` is pressed again. Keep pressing just `+` to increase height.
      --   Try pressing `-` to decrease height.
      -- - Stop submode either by `<Esc>` or by any key that is not in submode.
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
      {
          { mode = 'n', keys = '<Leader>b', desc = '+Bookmarks/Edit' },
          { mode = 'n', keys = '<Leader>f', desc = '+Find' },
          { mode = 'n', keys = '<Leader>g', desc = '+Git' },
          { mode = 'n', keys = '<Leader>l', desc = '+Language' },
          { mode = 'n', keys = '<Leader>o', desc = '+Obsidian' },
          { mode = 'n', keys = '<Leader>s', desc = '+Session' },
          { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
          { mode = 'x', keys = '<Leader>g', desc = '+Git' },
          { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
      }
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = 'n', keys = '<Leader>' }, -- Leader triggers
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = '\\' },       -- mini.basics
      { mode = 'n', keys = '[' },        -- mini.bracketed
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'i', keys = '<C-x>' },    -- Built-in completion
      { mode = 'n', keys = 'g' },        -- `g` key
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },        -- Marks
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' },        -- Registers
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },    -- Window commands
      { mode = 'n', keys = 'z' },        -- `z` key
      { mode = 'x', keys = 'z' },
          },
  })


  require('blink.cmp').setup({
   keymap = { preset = 'default' },
   completion = { documentation = { auto_show = true } },
   sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
	per_filetype = {
		sql = {'snippets', 'dadbod', 'buffer'}
	},
	providers = {
		dadbod = {name = 'Dadbod', module = 'vim_dadbod_completion.blink'}
	}
   },
   signature = {enabled = true },
   fuzzy = { implementation = "prefer_rust_with_warning" }
  });

require('lualine').setup {
  options = {
     component_separators = { left = '', ritght = ''},
    -- section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'filename', 'location'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {'lsp_status'},
    lualine_y = {'branch'},
    lualine_z = {'progress'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}
require('treesitter-context').setup()
-- require('dropbar').setup()

require('amp').setup({auto_start = true, log_level = "info"})
-- Send a quick message to the agent
vim.api.nvim_create_user_command("AmpAsk", function(opts)
  local message = opts.args
  if message == "" then
    print("Please provide a message to send")
    return
  end

  local amp_message = require("amp.message")
  amp_message.send_message(message)
end, {
  nargs = "*",
  desc = "Send a question to Amp",
})

-- Send a quick message to the agent
vim.api.nvim_create_user_command("AmpReview", function(opts)
  -- local message = opts.args
  local message = "Check all my staged changes for errors. If new classes are used check if they are callable." 
  if message == "" then
    print("Please provide a message to send")
    return
  end

  local amp_message = require("amp.message")
  amp_message.send_message(message)
end, {
  nargs = "*",
  desc = "Ask Amp to check changes for errors",
})

-- Add selected text directly to prompt
vim.api.nvim_create_user_command("AmpSelect", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local text = table.concat(lines, "\n")
  local message = opts.args

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(text)
end, {
  nargs = "*",
  range = true,
  desc = "Add selected text to Amp prompt",
})

-- Add file+selection reference to prompt
vim.api.nvim_create_user_command("AmpRef", function(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    print("Current buffer has no filename")
    return
  end

  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  local ref = "@" .. relative_path
  if opts.line1 ~= opts.line2 then
    ref = ref .. "#L" .. opts.line1 .. "-" .. opts.line2
  elseif opts.line1 > 1 then
    ref = ref .. "#L" .. opts.line1
  end

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(ref)
end, {
  range = true,
  desc = "Add file reference (with selection) to Amp prompt",
})
require('obsidian').setup({
    -- ui = {enable =  false},
    legacy_commands = false,
	-- ft="markdown",
	-- opts = {
		workspaces = {
			{
				name = "wiki",
				path = "~/MEGA/vimwiki",
			},
			{
				name = "zet",
				path = "~/MEGA/zettelkasten",
			},
		}

	-- }
})
require('gitsigns').setup({
    current_line_blame = true,
    signs = { add = { text = '⊕'}, change = { text = '≋'}, delete = { text = '⊖'} },
    signcolumn = true,
})
require('mason').setup()
require('nvim-treesitter').setup({
    build = ':TSUpdate',
    highlight = { enable = true },
    injections = { enable = true },
    -- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
        ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'php', 'javascript', 'query', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        -- auto_install = true,
        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'php' },
        },
        indent = { enable = false, disable = { 'php' } },
    },
})
-- Enable tree-sitter after opening a file for a target language
  -- local filetypes = {}
  -- local languages = {'php','markdown','lua','javascript','sql','query','bash','diff'}
  -- for _, lang in ipairs(languages) do
  --   for _, ft in ipairs(vim.treesitten.language.get_filetypes(lang)) do
  --     table.insert(filetypes, ft)
  --   end
  -- end
  -- local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  -- _G.Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
---- tmux navigator
local nvim_tmux_nav = require('nvim-tmux-navigation')
nvim_tmux_nav.setup{ disabled_when_zoomed =  true }
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- db ui icons
vim.g.db_ui_icons = {
		  expanded= {
		    db= '▾ ',
		    buffers= '▾ ',
		    saved_queries= '▾ ',
		    schemas= '▾ ',
		    schema= '▾ פּ',
		    tables= '▾ ',
		    table= '▾ ',
		  },
		   collapsed= {
		     db= '▸ ',
		     buffers= '▸ ',
		     saved_queries= '▸ ',
		     schemas= '▸ ',
		     schema= '▸ פּ',
		     tables= '▸ ',
		     table= '▸ ',
		  },
		   saved_query= '',
		   new_query= '?',
		   tables= '',
		   buffers= '',
		   add_connection= '',
		   connection_ok= '✓',
		   connection_error= '✕',
		}

-- 
-- ┌──────────────┐
-- │ LSP config   │
-- └──────────────┘
--

vim.lsp.enable({
    "lua_ls",
    "intelephense",
    "marksman",
    "deno",
})


-- hack for using the vscode peeklocations action in nvim (for Intelephense)
vim.lsp.commands["editor.action.peekLocations"] = function(command, ctx)
  local locations = command.arguments[3]

  if not locations or #locations == 0 then
    vim.notify("No locations found", vim.log.levels.INFO)
    return
  end

  local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding

  if #locations == 1 then
    vim.lsp.util.show_document(locations[1], offset_encoding, { focus = true })
  else
    vim.fn.setloclist(0, {}, " ", {
      title = "LSP Locations",
      items = vim.lsp.util.locations_to_items(locations, offset_encoding),
    })
    vim.cmd("lopen")
  end
end



vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

-- vim.lsp.codelens.enable(true)

require('vim._core.ui2').enable({enable=true})

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
    },
    signs = {
        priority = 9999,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR
        },
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',

        },
    },
})
-- 
-- ┌──────────────┐
-- │ Autocommands │
-- └──────────────┘
--
vim.bo.expandtab = true
vim.b.autoformat = false

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'php',
    callback = function()
        vim.opt_local.iskeyword:remove('$')
        -- vim.opt_local.spell = true
        vim.opt_local.wrap = false
        vim.opt_local.commentstring = '// %s'
        vim.opt_local.comments = 's1:/*,mb:*,ex:*/,://,:#'
        vim.opt_local.conceallevel = 2
        vim.bo.expandtab = true
        vim.b.autoformat = false
        -- vim.keymap.set({'i'}, '@v', 'echo "<pre>";var_dump();echo "</pre>";<esc>16ha',{desc="var_dump()"});
        -- vim.keymap.set({'i'}, '@d', 'echo "<pre>";var_dump();echo "</pre>";die;<esc>5hi',{desc="var_dump();die"});
        vim.keymap.set({'i'}, '@v', 'require_once $_SERVER["DOCUMENT_ROOT"] . "/kint.phar"; d();<esc>2ha',{desc="var_dump()"});
        vim.keymap.set({'n'}, '@v', 'irequire_once $_SERVER["DOCUMENT_ROOT"] . "/kint.phar"; d();<esc>2ha',{desc="var_dump()"});
        vim.keymap.set({'i'}, '@d', 'require_once $_SERVER["DOCUMENT_ROOT"] . "/kint.phar"; d();die;<esc>6ha',{desc="var_dump(); die"});
        vim.keymap.set({'n'}, '@d', 'irequire_once $_SERVER["DOCUMENT_ROOT"] . "/kint.phar"; d();die;<esc>6ha',{desc="var_dump(); die"});
        vim.keymap.set({'i'}, '@t', 'Tracy\\Debugger::dump();<esc>2ha',{desc="Debugger::bdump()"});
        vim.keymap.set({'i'}, '@b', 'Tracy\\Debugger::bdump();<esc>2ha',{desc="Debugger::bdump()"});
        -- vim.keymap.set({'n'}, '@v', 'iecho "<pre>";var_dump();echo "</pre>";<esc>16ha',{desc="var_dump()"});
        -- vim.keymap.set({'n'}, '@d', 'ivar_dump();die;<esc>5hi',{desc="var_dump();die"});
        vim.keymap.set({'n'}, '@t', 'Tracy\\Debugger::dump();<esc>2ha',{desc="Debugger::bdump()"});
        vim.keymap.set({'n'}, '@b', 'iTracy\\Debugger::bdump();<esc>2ha',{desc="Debugger::bdump()"});
        vim.keymap.set({'i'}, '@l', 'file_put_contents($_SERVER["DOCUMENT_ROOT"] . "/debug.log", __FILE__ . ":" . __LINE__ . " " . var_export(,true) . "\\n ---/*/--- \\n", FILE_APPEND);<esc>28ha',{desc="log in debug.log"});
        vim.keymap.set({'n'}, '@l', 'ifile_put_contents($_SERVER["DOCUMENT_ROOT"] . "/debug.log", __FILE__ . ":" . __LINE__ . " " . var_export(,true) . "\\n ---/*/--- \\n", FILE_APPEND);<esc>28ha',{desc="log in debug.log"});
    end,
})

-- Function to upload a file via scp
local function upload_file_via_scp(filepath, remote_path, server)
    -- Construct the scp command
    local scp_command = string.format('scp %s %s:%s', filepath, server, remote_path)

    -- Execute the scp command
    local success = os.execute(scp_command)

    -- Notify the user about the result
    if success == 0 then
        vim.notify('File uploaded successfully!', vim.log.levels.INFO)
    else
        vim.notify('File upload failed!', vim.log.levels.ERROR)
    end
end

-- Set up an autocommand for file save
local function setup_autosave_scp(local_folder, remote_folder, server)
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = vim.api.nvim_create_augroup('AutoSCPUpload', { clear = true }),
        callback = function(args)
            -- Get the file path of the saved file
            local fullfilepath = vim.fn.fnamemodify(vim.fn.expand(args.file), ':p')

            -- Check if the file is in the specified local folder
            if fullfilepath:find(local_folder, 1, true) then
                -- Extract the relative path of the file within the local folder
                local relative_path = fullfilepath:sub(#local_folder + 2)

                -- Construct the remote path
                local remote_path = remote_folder .. '/' .. relative_path

                -- Trigger the scp upload
                upload_file_via_scp(fullfilepath, remote_path, server)
            end
        end,
    })
end


setup_autosave_scp(
    '/home/marius/Projects/aynax', -- Local folder to monitor
    '/home/marius/aynax', -- Remote server folder
    'a' -- Remote server (e.g., user@host)
)

-- function to open  in a vsplit the file from quickfix window
vim.api.nvim_create_autocmd('FileType', {
    pattern='qf',
    callback = function()
        vim.keymap.set('n', '<leader>v', ':let qf_entry = getqflist()[line(".") - 1] | execute "vsplit " . qf_entry.bufnr | execute "buffer " . qf_entry.bufnr | execute qf_entry.lnum<cr>')
    end
})

