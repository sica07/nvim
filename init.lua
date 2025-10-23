
vim.o.mouse = 'a'
vim.o.statuscolumn = "%l%s"
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.infercase = true
vim.o.spelloptions = 'camel'
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- vim.o.listchars = "tab: ,multispace:.   " -- Characters to show for tabs, spaces, and end of line
vim.o.fillchars = 'eob: ,fold:╌'
vim.o.listchars = 'extends:·,nbsp:␣,precedes:·,tab:  ,multispace:. '
vim.o.list = true
vim.o.number = true
vim.o.pumheight = 10 -- make popup menu smaller
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.wrap = false
vim.o.shortmess = 'CFOSWaco' -- Disable some built-in completion messages
vim.o.scrolloff = 3
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
vim.o.undofile = true
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.opt.winborder = "rounded"
vim.o.diffopt = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram' -- smooth conflict resolution
vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.o.grepprg = '/usr/bin/rg --vimgrep -u --no-heading --glob "!.git" --follow $*'
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.wildmenu = true
vim.o.wildmode = 'noselect:longest:lastused,full'
vim.o.path = '.,**'
vim.o.formatoptions = 'rqnl1j' 

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.autoformat_enabled = false
vim.g.have_nerd_font = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- PLUGINS --
vim.pack.add({
    { src = "https://github.com/echasnovski/mini.nvim" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/alexghergh/nvim-tmux-navigation" },
    -- { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
    -- colorscheme(s)
    { src = "https://github.com/drewxs/ash.nvim" },
    -- lsp
    { src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    -- DB
    { src = "https://github.com/tpope/vim-dadbod" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
    -- AI
    { src = "https://github.com/sourcegraph/amp.nvim" },
}, { load = true })

--require('mini.align').setup()


require('mini.surround').setup()
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()
require('mini.indentscope').setup({symbol = '·'})
require('mini.misc').setup()
MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()
MiniMisc.setup_termbg_sync()
require('mini.files').setup()
require('mini.git').setup()
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.diff').setup({
            view = {
                style = 'sign',
                signs = { add = '⊕', change = '≋', delete = '⊖' },
            }
        })
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.pick').setup({
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
require('mini.visits').setup()
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
require('diffview').setup()

require('nvim-tmux-navigation').setup{ disabled_when_zoomed =  true }
require('mini.completion').setup()
vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
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

require('mason').setup()
require('nvim-treesitter').setup({
    build = ':TSUpdate',
    -- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
        ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'php', 'javascript', 'query', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
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

 local preset = require("markview.presets").tables;
 require('markview').setup({
     preview = {
         modes = { 'n', 'i', 'no', 'c' },
         hybrid_modes = { 'n', 'i' },
         icon_provider = "mini", -- "mini" or "devicons",
     },
     markdown = { 
         tables = preset.rounded,
         horizontal_rules = preset.arrowed,
         headings = preset.arrowed,
     },
 })
 vim.cmd 'Markview hybridEnable'

-- Colorscheme
vim.cmd.colorscheme("ash")

vim.cmd.hi 'Comment gui=italic'
vim.cmd.hi 'Keyword gui=bold'
vim.cmd.hi 'Type gui=italic,bold'

-- STATUSLINE
local mini_status = require('mini.statusline')
mini_status.setup({
    content = {active = function()
        return mini_status.combine_groups({
            {hl = 'MiniStatuslineFilename', strings = {mini_status.section_filename({})}},
            '%<', -- Mark general truncate point
            {hl = 'MiniStatuslineDevinfo', strings = { mini_status.section_searchcount({})}},
            '%<', -- Mark general truncate point
            {hl = 'MiniStatuslineDevinfo', strings = {mini_status.section_git({})}},
            '%=', -- End left alignment
            {hl = 'MiniStatuslineFilename', strings = {'%{&filetype}'}},
            {hl = 'MiniStatuslineFileinfo', strings = {'%2p%%'}},
        })
    end
}
})

-- LSP
vim.lsp.enable({
    "lua_ls",
    "intelephense",
    "marksman",
    "deno",
})

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
            min = 'WARN',
            max = 'ERROR'
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


-- -- COMPLETION
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(ev)
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         if client ~= nil and client:supports_method("textDocument/completion") then
--             vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true })
--         end
--     end,
-- })

-- AUTOCOMMANDS

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
    'a4' -- Remote server (e.g., user@host)
)

-- function to open  in a vsplit the file from quickfix window
vim.api.nvim_create_autocmd('FileType', {
    pattern='qf',
    callback = function()
        vim.keymap.set('n', '<leader>v', ':let qf_entry = getqflist()[line(".") - 1] | execute "vsplit " . qf_entry.bufnr | execute "buffer " . qf_entry.bufnr | execute qf_entry.lnum<cr>')
    end
})

-- KEYMAPS

-- tmux navigator
local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- MiniFiles
vim.keymap.set({'n','x'},  "<leader>e", ':lua MiniFiles.open()<cr>', {desc = "Files" })

-- MiniPick
vim.keymap.set({'n','x'},  "<leader>ff", ':Pick files<cr>', {desc = "Find Files" })
vim.keymap.set({'n','x'},  "<leader>fb", ':Pick buffers<cr>', {desc = "Buffers" })
vim.keymap.set({'n','x'},  "<leader>fo", ':Pick oldfiles<cr>', {desc = "Recent" })
vim.keymap.set({'n','x'},  "<leader>/", ':Pick grep_live<cr>', {desc = "Grep live" })
vim.keymap.set({'n','x'},  "<leader>fg", ':Pick grep pattern="<cword>"<cr>', {desc = "Grep current word" })
vim.keymap.set({'n','x'},  "<leader>fd", ':Pick diagnostic scope="current"<cr>', {desc = "Diagnostics" })
vim.keymap.set({'n','x'},  "<leader>fq", ':Pick list scope="quickfix"<cr>', {desc = "Quickfix" })
vim.keymap.set({'n','x'},  "<leader>fr", ':Pick registers<cr>', {desc = "Registers" })
vim.keymap.set({'n','x'},  "<leader>fc", ':Pick colorscheme<cr>', {desc = "Colorscheme" })
vim.keymap.set({'n','x'},  "<leader>fr", ':Pick help<cr>', {desc = "Help" })
vim.keymap.set({'n','x'},  "<leader>fj", ':Pick list scope="jump"<cr>', {desc = "Jumplist" })
vim.keymap.set({'n','x'},  "<leader>fm", ':Pick marks<cr>', {desc = "Marks" })
vim.keymap.set({'n','x'},  "<leader>fv", ':Pick visit_paths cwd=""<cr>', {desc = "Visits (all)" })
vim.keymap.set({'n','x'},  "<leader>fV", ':Pick visit_paths<cr>', {desc = "Visits (cwd)" })
vim.keymap.set({'n','x'},  "<leader>fz", ':Pick spellsuggest<cr>', {desc = "Spell" })
vim.keymap.set({'n','x'},  "<leader>go", '<cmd>lua MiniDiff.toggle_overlay()<cr>', {desc = "Toggle overlay" })
vim.keymap.set({'n','x'},  "<leader>gs", '<cmd>lua MiniGit.show_at_cursor()<cr>', {desc = "Show at cursor" })
vim.keymap.set({'n','x'},  "<leader>la", '<cmd>lua vim.lsp.buf.code_action()<cr>', {desc = "Actions" })
vim.keymap.set({'n','x'},  "<leader>li", '<cmd>lua vim.lsp.buf.implementation()<cr>', {desc = "Implementation" })
vim.keymap.set({'n','x'},  "<leader>lr", '<cmd>lua vim.lsp.buf.rename()<cr>', {desc = "Rename" })
vim.keymap.set({'n','x'},  "<leader>lt", '<cmd>lua vim.lsp.buf.type_definition()<cr>', {desc = "Type definition" })
vim.keymap.set({'n','x'},  "<leader>ld", '<cmd>lua vim.diagnostic.setqflist({open=true, bufnr=0})<cr>', {desc = "Diagnostics" })
vim.keymap.set({'n','x'},  "<leader>d", '<cmd>lua vim.diagnostic.setqflist({open=true, bufnr=0})<cr>', {desc = "Diagnostics" })
vim.keymap.set({'n','x'},  "<leader>be", '<cmd>lua MiniFiles.open()<cr>', {desc = "Root Directory" })
vim.keymap.set({'n','x'},  "<leader>bf", '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', {desc = "CWD" })
vim.keymap.set({'n','x'},  "<leader>bi", '<cmd>edit $MYVIMRC<cr>', {desc = "init.lua" })
vim.keymap.set({'n','x'},  "<leader>ba", '<cmd>lua MiniFiles.open("~/Projects/aynax")<cr>', {desc = "aynax" })
vim.keymap.set({'n','x'},  "<leader>bw", '<cmd>lua MiniFiles.open("~/MEGA/vimwiki/")<cr>', {desc = "wiki" })
vim.keymap.set({'n','x'},  "<leader>sd", '<cmd>lua MiniSessions.select("delete")<cr>', {desc = "Delete" })
vim.keymap.set({'n','x'},  "<leader>sn", '<cmd>lua MiniSessions.write(vim.fn.input("Session name: "))<cr>', {desc = "New" })
vim.keymap.set({'n','x'},  "<leader>sf", '<cmd>lua MiniSessions.select("read")<cr>', {desc = "Find" })
vim.keymap.set({'n','x'},  "<leader>sw", '<cmd>lua MiniSessions.write()<cr>', {desc = "Write" })
vim.keymap.set({'n','x'},  "<leader>z", '<cmd>lua MiniMisc.zoom()<cr>', {desc = "Zoom/Focus mode" })

local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = 'core', sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end


vim.keymap.set({'n','x'}, "<leader>vc", make_pick_core('',  'Core visits (all)'), {desc ='Core visits (all)'})
vim.keymap.set({'n','x'}, "<leader>vC", make_pick_core(nil, 'Core visits (cwd)'), {desc ='Core visits (cwd)'})
vim.keymap.set({'n','x'}, "<leader>vv", '<Cmd>lua MiniVisits.add_label("core")<CR>', {desc = 'Add "core" label'})
vim.keymap.set({'n','x'}, "<leader>vV", '<Cmd>lua MiniVisits.remove_label("core")<CR>', {desc = 'Remove "core" label'})
vim.keymap.set({'n','x'}, "<leader>vl", '<Cmd>lua MiniVisits.add_label()<CR>', {desc = 'Add label'})
vim.keymap.set({'n','x'}, "<leader>vL", '<Cmd>lua MiniVisits.remove_label()<CR>', {desc = 'Remove label'})
