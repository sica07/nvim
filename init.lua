
vim.o.mouse = 'a'
vim.o.statuscolumn = "%l%s"
vim.o.signcolumn = 'yes'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.listchars = "tab: ,multispace:.   " -- Characters to show for tabs, spaces, and end of line
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.wrap = false
vim.o.scrolloff = 3
vim.o.undofile = true
vim.o.completeopt = "menuone,noinsert,popup,fuzzy"
vim.opt.winborder = "rounded"
vim.o.diffopt = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram' -- smooth conflict resolution
vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.o.grepprg = '/usr/bin/rg --vimgrep -u --no-heading --glob "!.git" --follow $*'
vim.o.grepformat = '%f:%l:%c:%m'


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
    { src = "https://github.com/obsidian-nvim/obsidian.nvim" },
    -- colorscheme(s)
    { src = "https://github.com/drewxs/ash.nvim" },
    -- lsp
    { src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    { src = "https://github.com/williamboman/mason.nvim" },
}, { load = true })

require('mini.surround').setup()
require('mini.icons').setup()
require('mini.indentscope').setup({style = '.'})
require('mini.files').setup()
require('mini.git').setup()
require('mini.diff').setup({
            view = {
                style = 'sign',
                signs = { add = '⊕', change = '≋', delete = '⊖' },
            }
        })
require('mini.pick').setup()
require('mini.extra').setup()
require('diffview').setup()
require('nvim-tmux-navigation').setup{ disabled_when_zoomed =  true }
require('obsidian').setup({
    ft = "markdown",
    completion = {
        nvim_cmp = false,
        blink =  false,
    },
    picker = {
        name = "mini.pick",
    },
    workspaces = {
        {
            name = 'wiki',
            path = '/home/marius/MEGA/vimwiki',
        },
        {
            name = 'zet',
            path = '/home/marius/MEGA/zettelkasten',
        },
        {
            name = 'work',
            path = '/home/marius/MEGA/dailylogs',
        },
    },
    daily_notes = {
        folder = '/home/marius/MEGA/vimwiki/diary',
        date_format = '%Y-%m-%d',
    },
})

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


-- COMPLETEION

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true })
        end
    end,
})

-- AUTOCOMMANDS

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'php',
    callback = function()
        vim.opt_local.iskeyword:remove('$')
        vim.opt_local.spell = true
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
-- MiniGit
vim.keymap.set({ 'n', 'x' }, '<Leader>gh', '<Cmd>lua MiniGit.show_at_cursor()<cr>', { desc = 'Git: Show history at cursor' })
vim.keymap.set({ 'n', 'x' }, '<leader>gd', '<cmd>lua MiniDiff.toggle_overlay()<cr>', { desc = 'Git: Compare changes on cursor' }) 

-- MiniPick
vim.keymap.set({'n','x'},  "<leader><space>f", ':Pick files<cr>', {desc = "Find Files" })
vim.keymap.set({'n','x'},  "<leader><space>b", ':Pick buffers<cr>', {desc = "Buffers" })
vim.keymap.set({'n','x'},  "<leader><space>e", ':Pick oldfiles<cr>', {desc = "Recent" })
vim.keymap.set({'n','x'},  "<leader><space>/", ':Pick grep_live<cr>', {desc = "Grep" })
vim.keymap.set({'n','x'},  "<leader><space>d", ':Pick diagnostic scope="current"<cr>', {desc = "Diagnostics" })
vim.keymap.set({'n','x'},  "<leader><space>q", ':Pick list scope="quickfix"<cr>', {desc = "Quickfix" })
vim.keymap.set({'n','x'},  "<leader><space>r", ':Pick registers<cr>', {desc = "Registers" })
vim.keymap.set({'n','x'},  "<leader><space>j", ':Pick list scope="jump"<cr>', {desc = "Jumplist" })
vim.keymap.set({'n','x'},  "<leader><space>m", ':Pick marks<cr>', {desc = "Marks" })
vim.keymap.set({'n','x'},  "<leader><space>v", ':Pick visit_paths<cr>', {desc = "Visits" })
