vim.o.number = true
vim.o.relativenumber = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.smartindent = true
vim.o.signcolumn = 'yes'
vim.o.winborder = "rounded"
vim.o.completeopt = "menu,noinsert,popup,fuzzy"
-- show error and git simbols after the line number (inside the editor space)
vim.o.statuscolumn = "%l%s"
vim.o.splitright = true
vim.o.splitbelow = true
-- Configure tabstop
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 3
-- smooth conflict resolution
vim.o.diffopt = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram'
--  trying to fix the issue with the colors  in quickfix window
vim.o.termguicolors = true
vim.o_local.conceallevel = 2
-- folding
vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()'

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.autoformat_enabled = false
vim.g.have_nerd_font = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.diagnostic.config({
    -- virtual_text = {
    --     severity = {
    --         min = vim.diagnostic.severity.ERROR,
    --     },
    -- },
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
            -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
            -- [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
            -- [vim.diagnostic.severity.HINT] = 'DiagnosticHint',

        },
    },
})

-- general colorschemes rules
vim.cmd.hi 'Comment gui=italic'
vim.cmd.hi 'Keyword gui=bold'


-- use ripgrep instead of grep
local function set_grepprg()
    local cmd = '/usr/bin/rg --vimgrep -u --no-heading --glob "!.git" --follow $*'
    vim.o.grepprg = cmd
end
set_grepprg()
vim.o.grepformat = '%f:%l:%c:%m'

-- Plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.o.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
    {
        'sindrets/diffview.nvim',
        config = function()
            vim.keymap.set('n', '<leader>gd', function()
                if next(require(‘diffview.lib’).views) == nil then
                    vim.cmd(‘DiffviewOpen’)
                else
                    vim.cmd(‘DiffviewClose’)
                end
            end)

            vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', { desc = 'Git: Diffview Open' })
        end,
    },
     {
         'OXY2DEV/markview.nvim',
         lazy = false,
         ft = 'markdown',
         config = function()
             local preset = require("markview.presets").tables;
             require('markview').setup {
                 preview = {
                     modes = { 'n', 'i', 'no', 'c' },
                     hybrid_modes = { 'n', 'i' },
                     icon_provider = "internal", -- "mini" or "devicons",
                 },
                 markdown = { 
                     tables = preset.rounded,
                     horizontal_rules = preset.arrowed,
                     headings = preset.arrowed,
                 }
             }
             vim.cmd 'Markview hybridEnable'
         end,
     },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },
    {
        'yetone/avante.nvim',
        event = 'VeryLazy',
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            openai = {
                endpoint = 'https://api.openai.com/v1',
                model = 'gpt-4o',
                timeout = 30000, -- Timeout in milliseconds
                temperature = 0,
                max_tokens = 4096,
                -- ['local'] = false,
            },
            provider = 'openai',
            auto_suggestions_provider = 'openai',
        },
        -- { hints = { enabled = true } },
        build = 'make BUILD_FROM_SOURCE=true',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'stevearc/dressing.nvim',
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'echasnovski/mini.icons',
            --- The below dependencies are optional,
            {
                -- Make sure to set this up properly if you have lazy=true
                'OXY2DEV/markview.nvim',
                opts = {
                    file_types = { 'markdown', 'Avante' },
                },
                ft = { 'markdown', 'Avante' },
            },
        },
    },
    {
        'epwalsh/obsidian.nvim',
        version = '*', -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = 'markdown',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('obsidian').setup {
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
                -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
                -- way then set 'mappings = {}'.
                mappings = {
                    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                    ['gf'] = {
                        action = function()
                            return require('obsidian').util.gf_passthrough()
                        end,
                        opts = { noremap = false, expr = true, buffer = true },
                    },
                    -- Smart action depending on context, either follow link or toggle checkbox.
                    ['<ctrl><cr>'] = {
                        action = function()
                            return require('obsidian').util.smart_action()
                        end,
                        opts = { buffer = true, expr = true },
                    },
                },
                picker = {
                    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
                    name = 'fzf-lua',
                    -- name = 'mini.pick',
                    -- Optional, configure key mappings for the picker. These are the defaults.
                    -- Not all pickers support all mappings.
                    note_mappings = {
                        -- Create a new note from your query.
                        new = '<C-x>',
                        -- Insert a link to the selected note.
                        insert_link = '<C-l>',
                    },
                    tag_mappings = {
                        -- Add tag(s) to current note.
                        tag_note = '<C-x>',
                        -- Insert a tag at the current location.
                        insert_tag = '<C-l>',
                    },
                },
                ui = {
                    enable = false
                }

            }
        end,
    },
    { 'williamboman/mason.nvim', config = true,

    config = function() 
        require('mason').setup()
    end
}, -- NOTE: Must be loaded before dependants
{'WhoIsSethDaniel/mason-tool-installer.nvim',
config = function()
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
end
},
{"webhooked/kanso.nvim", priority=1000},
{
    "drewxs/ash.nvim",
    lazy = false,
    priority = 1000,
config = function ()
    require('ash').setup({
        options = {
    styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
    },
    fzf_colors = false
    }
    })
vim.cmd.colorscheme 'ash'
end

},
{"EdenEast/nightfox.nvim", priority=1000,
config = function ()
    require('nightfox').setup({
        options = {
            styles = {
                comments = "italic",
                keywords = "bold",
                types = "italic,bold",
            }
        }
    })
end
      },
      { 'alexghergh/nvim-tmux-navigation', config = function()

          local nvim_tmux_nav = require('nvim-tmux-navigation')

          nvim_tmux_nav.setup {
              disable_when_zoomed = true -- defaults to false
          }

          vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
          vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
          vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
          vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
          vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
          vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

      end
  },
{ -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function() 
        local gen_spec = require('mini.ai').gen_spec
        require('mini.align').setup()
        require('mini.surround').setup()
        require('mini.icons').setup()
        require('mini.fuzzy').setup()
        require('mini.indentscope').setup({style = '.'})
        require('mini.files').setup()
        vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { desc = 'Explorer' })
        require('mini.git').setup()
        require('mini.diff').setup({
            view = {
                style = 'sign',
                signs = { add = '⊕', change = '≋', delete = '⊖' },
            }
        })
        require('mini.ai').setup {
            n_lines = 500,
            -- doesn't work for me. Need to investigate
            custom_textobjects = {
                o = gen_spec.treesitter { -- code block
                    a = { '@block.outer', '@conditional.outer', '@loop.outer' },
                    i = { '@block.inner', '@conditional.inner', '@loop.inner' },
                },
                F = gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
                c = gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
            },
        }
        local miniclue = require('mini.clue')
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },

                -- `brackets` key
                { mode = 'n', keys = '[' },
                { mode = 'x', keys = '[' },
                { mode = 'n', keys = ']' },
                { mode = 'x', keys = ']' },
            },
            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
            window = {
                delay = 300,
                config = {
                    width = 'auto',
                }
            },
        }) 

        local mini_statusline = require 'mini.statusline'
        local function statusline()
            local mode, mode_hl = mini_statusline.section_mode({trunc_width = 120})
            local git = mini_statusline.section_git({})
            local diff = mini_statusline.section_diff({})
            local diagnostics = mini_statusline.section_diagnostics({trunc_width = 75})
            local search = mini_statusline.section_searchcount({})
            local lsp = mini_statusline.section_lsp({icon = 'λ', trunc_width = 75})
            local filename = mini_statusline.section_filename({trunc_width = 140})
            local percent = '%2p%%'
            local location = '%3l:%-2c'

            return mini_statusline.combine_groups({
                {hl = mode_hl,                  strings = {mode}},
                {hl = 'MiniStatuslineDevinfo',  strings = {git}},
                '%<', -- Mark general truncate point
                {hl = 'MiniStatuslineFilename', strings = {filename, search}},
                '%=', -- End left alignment
                {hl = 'MiniStatuslineFilename', strings = {'%{&filetype}'}},
                {hl = 'MiniStatuslineFileinfo', strings = {percent}},
                {hl = mode_hl,                  strings = {location}},
            })
        end

        mini_statusline.setup({
            content = {active = statusline},
        })


        require('mini.notify').setup({
            lsp_progress = {enable = true},
            window = {-- display notify window in top left corner
                config = {
                    anchor = 'NW',
                    col = 5,
                    row = 2
                }
            }
        })
        vim.notify = require('mini.notify').make_notify({}) 
        require('mini.hipatterns').setup {
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                -- Highlight hex color strings (`#rrggbb`) using that color
                -- hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        }
        -- local gen_loader = require('mini.snippets').gen_loader
        -- require('mini.snippets').setup({
        --     snippets = {
        --         gen_loader.from_lang(),
        --     }
        -- })
        -- require('mini.completion').setup {
        --     lsp_completion = {
        --         source_func = 'omnifunc',
        --         auto_setup = false,
        --     },
        -- }
        MiniIcons.mock_nvim_web_devicons()
        MiniIcons.tweak_lsp_kind() 
        -- local win_config = function()
        --     Height = math.floor(0.618 * vim.o.lines)
        --     Width = math.floor(0.618 * vim.o.columns)
        --     return {
        --         anchor = 'NW',
        --         height = Height,
        --         width = Width,
        --         row = math.floor(0.5 * (vim.o.lines - Height)),
        --         col = math.floor(0.5 * (vim.o.columns - Width)),
        --     }
        -- end


        -- require('mini.pick').setup({
        --     window = {
        --         config = win_config
        --     }
        -- }) 
        require('mini.extra').setup()
        -- local map = function(keys, func, desc, mode)
        --     mode = mode or 'n'
        --     vim.keymap.set(mode, keys, func, { desc = 'FZF: ' .. desc })
        -- end

        -- map('<leader><leader>', '<cmd>Pick git_files<cr>', 'Files')
        -- map('<leader>/', '<cmd>Pick grep_live tool="git" <cr>', 'Grep')
        -- map('<leader>fr', '<cmd>Pick oldfiles<cr>', 'Oldfiles')
        -- map('<leader>fv', '<cmd>Pick visit_paths<cr>', 'Visits')
        -- map('<leader>fb', '<cmd>Pick buffers<cr>', 'Buffers')
        -- map('<leader>zg', '<cmd>Pick git_hunks<cr>', 'Git unstaged')
        -- map('<leader>zG', '<cmd>Pick git_hunks scope="staged"<cr>', 'Git staged')
        -- map('<leader>zt', '<cmd>Pick hipatterns <cr>', '(TODO)Hipatterns')
        -- map('<leader>R', '<cmd>Pick resume<cr>', 'Resume')
        -- map('<leader>o', '<cmd>Pick options<cr>', 'Options')
        -- map('<leader>zz', '<cmd>Pick spellsuggest<cr>', 'Spell Suggest')
        -- map('<leader>zm', '<cmd>Pick marks<cr>', 'Marks')
        -- map('<leader>gr', '<cmd>Pick lsp scope="references" <cr>', '[G]oto [R]ferences')
        -- map('<leader>zq', '<cmd>Pick list scope="quickfix"<cr>', 'Quickfix')
        -- map('<leader>zl', '<cmd>Pick list scope="location"<cr>', 'Loclist')
        -- map('<leader>zr', '<cmd>Pick list scope="registers"<cr>', 'Registers') 
        -- map('<leader>cd', '<cmd>Pick diagnostic<cr>', '[C]ode [D]iagnostics', { 'n', 'x' })

        local align_blame = function(au_data)
            if au_data.data.git_subcommand ~= 'blame' then
                return
            end

            -- Align blame output with source
            local win_src = au_data.data.win_source
            vim.wo.wrap = false
            vim.fn.winrestview { topline = vim.fn.line('w0', win_src) }
            vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

            -- Bind both windows so that they scroll together
            vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
        end 
        local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }
        vim.api.nvim_create_autocmd('User', au_opts)

        vim.keymap.set({ 'n', 'x' }, '<Leader>gh', '<Cmd>lua MiniGit.show_at_cursor()<cr>', { desc = 'Git: Show history at cursor' })
        vim.keymap.set({ 'n', 'x' }, '<leader>gc', '<cmd>lua MiniDiff.toggle_overlay()<cr>', { desc = 'Git: Compare changes on cursor' }) 
    end
},
{
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    completion = { documentation = { auto_show = true } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
},
{
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function() 
    vim.keymap.set({'n','x'},  "<leader><space>", ':FzfLua oldfiles<cr>', {desc = "Smart Find Files" })
    vim.keymap.set({'n','x'},  "<leader>,", ':FzfLua buffers<cr>', {desc = "Buffers" })
    vim.keymap.set({'n','x'},  "<leader>/", ':FzfLua grep<cr>', {desc = "Grep" })
    vim.keymap.set({'n','x'},  "<leader>:", ':FzfLua command_history<cr>', {desc = "Command History" })
    -- find
    vim.keymap.set({'n','x'},  "<leader>fb", ':FzfLua buffers<cr>', {desc = "Buffers" })
    vim.keymap.set({'n','x'},  "<leader>fc", ':FzfLua files<cr>', {desc = "Find Config File" })
    vim.keymap.set({'n','x'},  "<leader>ff", ':FzfLua files<cr>', {desc = "Find Files" })
    vim.keymap.set({'n','x'},  "<leader>fg", ':FzfLua git_files<cr>', {desc = "Find Git Files" })
    vim.keymap.set({'n','x'},  "<leader>fp", ':FzfLua projects<cr>', {desc = "Projects" })
    vim.keymap.set({'n','x'},  "<leader>fr", ':FzfLua recent<cr>', {desc = "Recent" })
    -- git
    vim.keymap.set({'n','x'},  "<leader>gb", ':FzfLua git_branches<cr>', {desc = "Git Branches" })
    vim.keymap.set({'n','x'},  "<leader>gc", ':FzfLua git_commits<cr>', {desc = "Git Branches" })
    vim.keymap.set({'n','x'},  "<leader>gC", ':FzfLua git_bcommits<cr>', {desc = "Git for buffer" })
    vim.keymap.set({'n','x'},  "<leader>gl", ':FzfLua git_blame<cr>', {desc = "Git Blame" })
    vim.keymap.set({'n','x'},  "<leader>gs", ':FzfLua git_status<cr>', {desc = "Git Status" })
    vim.keymap.set({'n','x'},  "<leader>gS", ':FzfLua git_stash<cr>', {desc = "Git Stash" })
    -- Grep
    vim.keymap.set({'n','x'}, "<leader>sb", ':FzfLua lines<cr>', {desc = "Buffer Lines" })
    vim.keymap.set({'n','x'}, "<leader>sB", ':FzfLua grep_buffers<cr>', {desc = "Grep Open Buffers" })
    vim.keymap.set({'n','x'}, "<leader>sg", ':FzfLua grep<cr>', {desc = "Grep" })
    vim.keymap.set({'n','x'}, "<leader>sw", ':FzfLua grep_word<cr>', {desc = "Visual selection or word" })
    -- search
    vim.keymap.set({'n','x'}, '<leader>s"', ':FzfLua registers<cr>', {desc = "Registers" })
    vim.keymap.set({'n','x'}, '<leader>s/', ':FzfLua search_history<cr>', {desc = "Search History" })
    vim.keymap.set({'n','x'}, "<leader>sa", ':FzfLua autocmds<cr>', {desc = "Autocmds" })
    vim.keymap.set({'n','x'}, "<leader>sb", ':FzfLua lines<cr>', {desc = "Buffer Lines" })
    vim.keymap.set({'n','x'}, "<leader>sc", ':FzfLua command_history<cr>', {desc = "Command History" })
    vim.keymap.set({'n','x'}, "<leader>sC", ':FzfLua commands<cr>', {desc = "Commands" })
    vim.keymap.set({'n','x'}, "<leader>sd", ':FzfLua diagnostics_workspace<cr>', {desc = "Diagnostics" })
    vim.keymap.set({'n','x'}, "<leader>sD", ':FzfLua diagnostics_document<cr>', {desc = "Buffer Diagnostics" })
    vim.keymap.set({'n','x'}, "<leader>sh", ':FzfLua help<cr>', {desc = "Help Pages" })
    vim.keymap.set({'n','x'}, "<leader>sH", ':FzfLua highlights<cr>', {desc = "Highlights" })
    -- vim.keymap.set({'n','x'}, "<leader>si", ':FzfLua icons<cr>', {desc = "Icons" })
    vim.keymap.set({'n','x'}, "<leader>sj", ':FzfLua jumps<cr>', {desc = "Jumps" })
    vim.keymap.set({'n','x'}, "<leader>sk", ':FzfLua keymaps<cr>', {desc = "Keymaps" })
    vim.keymap.set({'n','x'}, "<leader>sl", ':FzfLua loclist<cr>', {desc = "Location List" })
    vim.keymap.set({'n','x'}, "<leader>sm", ':FzfLua marks<cr>', {desc = "Marks" })
    vim.keymap.set({'n','x'}, "<leader>sM", ':FzfLua manpages<cr>', {desc = "Man Pages" })
    vim.keymap.set({'n','x'}, "<leader>sp", ':FzfLua lazy<cr>', {desc = "Search for Plugin Spec" })
    vim.keymap.set({'n','x'}, "<leader>sq", ':FzfLua quickfix<cr>', {desc = "Quickfix List" })
    vim.keymap.set({'n','x'}, "<leader>r", ':FzfLua resume<cr>', {desc = "Resume" })
    vim.keymap.set({'n','x'}, "<leader>su", ':FzfLua undo<cr>', {desc = "Undo History" })
    vim.keymap.set({'n','x'}, "<leader>uC", ':FzfLua colorschemes<cr>', {desc = "Colorschemes" })
    -- LSP
    vim.keymap.set({'n','x'}, "gd", ':FzfLua lsp_definitions<cr>', {desc = "Goto Definition" })
    vim.keymap.set({'n','x'}, "gD", ':FzfLua lsp_declarations<cr>', {desc = "Goto Declaration" })
    vim.keymap.set({'n','x'}, "gr", ':FzfLua lsp_references<cr>', {desc = "References" })
    vim.keymap.set({'n','x'}, "gI", ':FzfLua lsp_implementations<cr>', {desc = "Goto Implementation" })
    vim.keymap.set({'n','x'}, "gy", ':FzfLua lsp_type_definitions<cr>', {desc = "Goto T[y]pe Definition" })
    vim.keymap.set({'n','x'}, "<leader>ss", ':FzfLua lsp_document_symbols<cr>', {desc = "LSP Symbols" })
    vim.keymap.set({'n','x'}, "<leader>sS", ':FzfLua lsp_workspace_symbols<cr>', {desc = "LSP Workspace Symbols" })
  end
},
{ "nvim-treesitter/nvim-treesitter-textobjects"},
{ "nvim-treesitter/nvim-treesitter-context"},
{ "rafamadriz/friendly-snippets" },
{ -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
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
}

})

-- LSP Configuration
vim.lsp.config.lua_ls = {
    cmd = { '/home/marius/.local/share/nvim/mason/bin/lua-language-server'},
    filetypes = { 'lua' },
    root_markers = { 'init.lua' },
}

vim.lsp.config.intelephense = {
    -- cmd = { '/home/marius/.local/share/nvim/mason/bin/phpactor','language-server'},
    cmd = { '/home/marius/.local/share/nvim/mason/bin/intelephense','--stdio'},
    filetypes = { 'php' },
    root_markers = { 'composer.json' },
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    settings = {
        intelephense = {
            init_options = {
                ['indexer.enabled_watchers'] = {
                    'lsp',
                },
                ['completion_worse.completor.keyword.enabled'] = true,
                ['language_server_worse_reflection.inlay_hints.enable'] = true,
                ['language_server_worse_reflection.inlay_hints.types'] = true,
                ['language_server_worse_reflection.inlay_hints.params'] = true,
                ['indexer.searcher_semi_fuzzy'] = true,
            },
            stubs = {"bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo", "filter", "gd", "gettext", "hash", "iconv", "imap", "intl", "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", "regex", "session", "SimpleXML", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml", "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib"},
            environment = {
                includePaths = {'/home/marius/Documents/'},
                shortOpenTag = true
            },
            format = {
                enable = false,
            },
            files = {
                maxSize = 5000000;
            },
        },
    },
}
vim.lsp.enable('intelephense')
vim.lsp.enable('lua_ls')

--  vim.api.nvim_create_autocmd('LspAttach', {
--      callback = function(args)
--          local client = vim.lsp.get_client_by_id(args.data.client_id)
--          -- if client:supports_method('textDocument/completion') then
--          -- end
--          vim.api.nvim_create_autocmd({ 'TextChangedI' }, {
--              buffer = args.buf,
--              callback = function()
--                  vim.lsp.completion.trigger()
--              end
--          })
--          vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- ---[[Code required to add documentation popup for an item
--     local _, cancel_prev = nil, function() end
--     vim.api.nvim_create_autocmd('CompleteChanged', {
--       buffer = args.buf,
--       callback = function()
--         cancel_prev()
--         local info = vim.fn.complete_info({ 'selected' })
--         local completionItem = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
--         if nil == completionItem then
--           return
--         end
--         _, cancel_prev = vim.lsp.buf_request(args.buf,
--           vim.lsp.protocol.Methods.completionItem_resolve,
--           completionItem,
--           function(err, item, ctx)
--             if not item then
--               return
--             end
--             local docs = (item.documentation or {}).value
--             local win = vim.api.nvim__complete_set(info['selected'], { info = docs })
--             if win.winid and vim.api.nvim_win_is_valid(win.winid) then
--               vim.treesitter.start(win.bufnr, 'markdown')
--               vim.wo[win.winid].conceallevel = 3
--             end
--           end)
--       end
--     })
--     ---]]
--      end,
--  })

 vim.cmd("set completeopt+=noselect") -- add noselect otherwise autocompletion is annoying
--
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.o_local.iskeyword:remove('$')
    vim.o_local.spell = true
    vim.o_local.wrap = false
    vim.o_local.commentstring = '// %s'
    vim.o_local.comments = 's1:/*,mb:*,ex:*/,://,:#'
    vim.bo.expandtab = true
    vim.b.autoformat = false
    -- vim.keymap.set({'i'}, '@v', 'echo "<pre>";var_dump();echo "</pre>";<esc>16ha',{desc="var_dump()"});
    -- vim.keymap.set({'i'}, '@d', 'echo "<pre>";var_dump();echo "</pre>";die;<esc>5hi',{desc="var_dump();die"});
    vim.keymap.set({'i'}, '@v', 'require_once $_SERVER["DOCUMENT_ROOT"] . "/kint.phar"; d();<esc>2ha',{desc="var_dump()"});
    vim.keymap.set({'i'}, '@d', 'require_once $_SERVER["DOCUMENT_ROOT"] . "/kint.phar"; d();die;<esc>6ha',{desc="var_dump(); die"});
    vim.keymap.set({'i'}, '@t', 'Tracy\\Debugger::dump();<esc>2ha',{desc="Debugger::bdump()"});
    vim.keymap.set({'i'}, '@b', 'Tracy\\Debugger::bdump();<esc>2ha',{desc="Debugger::bdump()"});
    vim.keymap.set({'n'}, '@v', 'iecho "<pre>";var_dump();echo "</pre>";<esc>16ha',{desc="var_dump()"});
    vim.keymap.set({'n'}, '@d', 'ivar_dump();die;<esc>5hi',{desc="var_dump();die"});
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


-- Example usage: Configure the folder and server
setup_autosave_scp(
  '/home/marius/Projects/aynax', -- Local folder to monitor
  '/home/marius/aynax', -- Remote server folder
  'a4' -- Remote server (e.g., user@host)
)

  vim.api.nvim_create_autocmd('FileType', {
      pattern='qf',
      callback = function()
            vim.keymap.set('n', '<leader>v', ':let qf_entry = getqflist()[line(".") - 1] | execute "vsplit " . qf_entry.bufnr | execute "buffer " . qf_entry.bufnr | execute qf_entry.lnum<cr>')
      end
  })

-- Better diff color regradless of the colorscheme
-- vim.cmd([[
-- augroup diffcolors
--     autocmd!
--     autocmd Colorscheme * call s:SetDiffHighlights()
-- augroup END
--
-- function! s:SetDiffHighlights()
--     if &background == "dark"
--         highlight DiffAdd gui=bold guifg=none guibg=#2e4b2e
--         highlight DiffDelete gui=bold guifg=none guibg=#4c1e15
--         highlight DiffChange gui=bold guifg=none guibg=#45565c
--         highlight DiffText gui=bold guifg=none guibg=#996d74
--     else
--         highlight DiffAdd gui=bold guifg=none guibg=palegreen
--         highlight DiffDelete gui=bold guifg=none guibg=tomato
--         highlight DiffChange gui=bold guifg=none guibg=lightblue
--         highlight DiffText gui=bold guifg=none guibg=lightpink
--     endif
-- endfunction
--]])
