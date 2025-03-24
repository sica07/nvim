--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.autoformat_enabled = false
vim.g.have_nerd_font = false

-- [[ Setting options ]]

vim.opt.number = true
vim.opt.relativenumber = true
-- creates a backup file
vim.opt.backup = false
vim.opt.swapfile = false
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.numberwidth = 3
vim.opt.signcolumn = 'yes'
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',

    },
  },
})
-- show error and git simbols after the line number (inside the editor space)
vim.opt.statuscolumn = "%l%s"
-- Decrease update time
vim.opt.updatetime = 250
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Configure tabstop
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '_' }
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 3
vim.opt.fileencoding='utf-8'
-- smooth conflict resolution
vim.o.diffopt = 'internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram'
-- use ripgrep instead of grep
local function set_grepprg()
  local cmd = '/usr/bin/rg --vimgrep -u --no-heading --glob "!.git" --follow $*'
  if vim.o.ignorecase then
    if vim.o.smartcase then
      -- cmd = cmd .. '-S '       --smartcase
    else
      -- cmd = cmd .. '-i '       --ignore-case
    end
  end

  vim.o.grepprg = cmd
end

set_grepprg()
vim.o.grepformat = '%f:%l:%c:%m'

vim.api.nvim_create_autocmd('OptionSet', {
  group = vim.api.nvim_create_augroup('rg', { clear = true }),
  pattern = 'ignorecase,smartcase',
  callback = set_grepprg,
})
--  trying to fix the issue with the colors  in quickfix window
vim.opt.termguicolors = true
vim.opt_local.conceallevel = 2
-- folding
vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- general colorschemes rules
vim.cmd.hi 'Comment gui=italic'
vim.cmd.hi 'Keyword gui=bold'

-- Set up pretty unicode diagnostic signs
-- vim.fn.sign_define("DiagnosticSignError", {text = "⚡", hl = "DiagnosticSignError", texthl = "DiagnosticSignError", culhl = "DiagnosticSignErrorLine"})
-- vim.fn.sign_define("DiagnosticSignWarn", {text = "", hl = "DiagnosticSignWarn", texthl = "DiagnosticSignWarn", culhl = "DiagnosticSignWarnLine"})
-- vim.fn.sign_define("DiagnosticSignInfo", {text = "", hl = "DiagnosticSignInfo", texthl = "DiagnosticSignInfo", culhl = "DiagnosticSignInfoLine"})
-- vim.fn.sign_define("DiagnosticSignHint", {text = "", hl = "DiagnosticSignHint", texthl = "DiagnosticSignHint", culhl = "DiagnosticSignHintLine"})

-- [[ Basic Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>vv', '<cmd>:vsplit<cr>', { desc = 'Split window' })
-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  -- 'tpope/vim-fugitive',
  'rktjmp/lush.nvim', -- required by modern colorschemes
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
      require('markview').setup {
        preview = {
          modes = { 'n', 'i', 'no', 'c' },
          hybrid_modes = { 'n', 'i' },
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
  --{
    --  'freitass/todo.txt-vim',
    --  opts = {
      --    todo_done_filename = 'done.txt',
      --  },
      --  config = function() end,
      --},
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
              -- name = 'fzf-lua',
              name = 'mini.pick',
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
        {
          'ibhagwan/fzf-lua',
          config = function()
            require('fzf-lua').setup {
              fzf_colors = true,
            }
            local map = function(keys, func, desc, mode)
              mode = mode or 'n'
              vim.keymap.set(mode, keys, func, { desc = 'FZF: ' .. desc })
            end

            -- map('<leader><leader>', '<cmd>FzfLua git_files<cr>', 'Files')
            -- map('<leader>/', '<cmd>FzfLua live_grep<cr>', 'Grep')
            -- map('<leader>fr', '<cmd>FzfLua oldfiles<cr>', 'Oldfiles')
            -- map('<leader>fb', '<cmd>FzfLua buffers<cr>', 'Buffers')
            -- map('<leader>ft', '<cmd>FzfLua tabs<cr>', 'Tabs')
            -- map('<leader>R', '<cmd>FzfLua resume<cr>', 'Resume')
            -- map('<leader>zc', '<cmd>FzfLua colorschemes<cr>', 'Colors')
            -- map('<leader>zm', '<cmd>FzfLua marks<cr>', 'Marks')
            -- map('<leader>zq', '<cmd>FzfLua quickfix<cr>', 'Quickfix')
            -- map('<leader>zl', '<cmd>FzfLua loclist<cr>', 'Loclist')
            -- map('<leader>zr', '<cmd>FzfLua registers<cr>', 'Registers')
            -- map('gd', '<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>', '[G]oto [D]efinition')
            -- map('gr', '<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>', '[G]oto [R]ferences')
            -- map('gI', '<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>', '[G]oto [I]mplementation')
            -- map('gy', '<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>', 'T[y]pe Definition')
            -- map('<leader>cs', '<cmd>FzfLua lsp_document_symbols<cr>', '[C]ode [S]ymbols')
            -- map('<leader>cd', '<cmd>FzfLua lsp_document_diagnostics<cr>', '[C]ode [D]iagnostics', { 'n', 'x' })
            -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          end,
        },
        -- LSP Plugins
        {
          -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
          -- used for completion, annotations and signatures of Neovim apis
          'folke/lazydev.nvim',
          ft = 'lua',
          opts = {
            library = {
              -- Load luvit types when the `vim.uv` word is found
              { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
          },
        },
        {
          -- Main LSP Configuration
          'neovim/nvim-lspconfig',
          dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },
          },
          config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
              callback = function(event)
                local map = function(keys, func, desc, mode)
                  mode = mode or 'n'
                  vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end


                vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
                map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                  local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                  })

                  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                  })

                  vim.api.nvim_create_autocmd('LspDetach', {
                    group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                    callback = function(event2)
                      vim.lsp.buf.clear_references()
                      vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                    end,
                  })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                  map('<leader>th', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                  end, '[T]oggle Inlay [H]ints')
                end

                local is_v11 = vim.fn.has('nvim-0.11') == 1

                -- enable completion side effects (if possible)
                -- note is only available in neovim v0.11 or greater
                -- if is_v11 and client and client.supports_method('textDocument/completion') then
                --   vim.lsp.completion.enable(true, client_id, event.buf, {})
                -- end
              end,
            })
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local servers = {
              intelephense = {
                settings = {
                  intelephense = {
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
              },
              marksman = {},
              deno = {},
              lua_ls = {
                settings = {
                  Lua = {
                    completion = {
                      callSnippet = 'Replace',
                    },
                  },
                },
              },
            }

            require('mason').setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
              'stylua', -- Used to format Lua code
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }
            require('mason-lspconfig').setup {
              handlers = {
                function(server_name)
                  local server = servers[server_name] or {}
                  -- server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                  -- server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities)
                  require('lspconfig')[server_name].setup(server)
                end,
              },
              capabilities = capabilities
            }
          end,
        },

        { "projekt0n/github-nvim-theme", priority = 1000 },
        { "zekzekus/menguless", priority = 1000 },
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
          vim.cmd.colorscheme 'nordfox'
        end
      },
      {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,

        config = function()
          require('lackluster').setup {
            disable_plugin = {},
            tweak_highlight = {
              -- modify @keyword's highlights to be bold and italic
              ["@keyword"] = {
                overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
                bold = true,
                -- see `:help nvim_set_hl` for all possible keys
              },
              -- overwrite @function to link to @keyword
              ["@comment"] = {
                overwrite = true, -- overwrite == true will force overwrite lackluster's default highlights
                italic = true,
              },
            },
          }
        end,
        init = function()
          -- vim.cmd.colorscheme("lackluster")
          -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
          -- vim.cmd.colorscheme("lackluster-mint")
        end,
      },
      {
        'zenbones-theme/zenbones.nvim',
        dependencies = 'rktjmp/lush.nvim',
        lazy = false,
        priority = 1000,
        init = function()
          vim.opt.background = 'light'
          vim.g.zenbones_lightness = 'bright'
          vim.g.zenbones = {
            solid_line_nr          = true,
            solid_vert_split       = true,
          }
          --vim.cmd.colorscheme 'zenbones'
        end
    },
    {
      'catppuccin/nvim',
      name = 'catppuccin',
      requires = {},
      priority = 1000,
      init = function()

        -- You can configure highlights by doing something like:
      end,
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

  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>H',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      local gen_spec = require('mini.ai').gen_spec
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

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.align').setup()
      require('mini.indentscope').setup({
        draw =  {
          delay = 50,
        },
        symbol = ':'
      })
      require('mini.animate').setup({
        scroll = { enable = true }
      })
      --require('mini.tabline').setup()
      require('mini.visits').setup()

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

      require('mini.bufremove').setup({})

      -- Close buffer and preserve window layout
      vim.keymap.set('n', '<leader>bd', '<cmd>lua pcall(MiniBufremove.delete)<cr>', {desc = 'Close buffer'})

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
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
      require('mini.icons').setup()
      require('mini.fuzzy').setup()
      require('mini.operators').setup()
      require('mini.comment').setup()
      require('mini.colors').setup()
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          gen_loader.from_lang(),
        }
      })
      require('mini.completion').setup {
        lsp_completion = {
          source_func = 'omnifunc',
          auto_setup = false,
        },
      }
      MiniIcons.mock_nvim_web_devicons()
      MiniIcons.tweak_lsp_kind()
      require('mini.files').setup()

      vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { desc = 'Explorer' })
      require('mini.bracketed').setup()
      require('mini.diff').setup({
        view = {
          style = 'sign',
          signs = { add = '⊕', change = '≋', delete = '⊖' },
        }
      })
      require('mini.git').setup()
      local win_config = function()
        Height = math.floor(0.618 * vim.o.lines)
        Width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW',
          height = Height,
          width = Width,
          row = math.floor(0.5 * (vim.o.lines - Height)),
          col = math.floor(0.5 * (vim.o.columns - Width)),
        }
      end


      require('mini.pick').setup({
        window = {
          config = win_config
        }
      })
      require('mini.extra').setup()
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = 'FZF: ' .. desc })
      end

      map('<leader><leader>', '<cmd>Pick git_files<cr>', 'Files')
      map('<leader>/', '<cmd>Pick grep_live tool="git" <cr>', 'Grep')
      map('<leader>fr', '<cmd>Pick oldfiles<cr>', 'Oldfiles')
      map('<leader>fv', '<cmd>Pick visit_paths<cr>', 'Visits')
      map('<leader>fb', '<cmd>Pick buffers<cr>', 'Buffers')
      map('<leader>zg', '<cmd>Pick git_hunks<cr>', 'Git unstaged')
      map('<leader>zG', '<cmd>Pick git_hunks scope="staged"<cr>', 'Git staged')
      map('<leader>zt', '<cmd>Pick hipatterns <cr>', '(TODO)Hipatterns')
      map('<leader>R', '<cmd>Pick resume<cr>', 'Resume')
      map('<leader>o', '<cmd>Pick options<cr>', 'Options')
      map('<leader>zz', '<cmd>Pick spellsuggest<cr>', 'Spell Suggest')
      map('<leader>zm', '<cmd>Pick marks<cr>', 'Marks')
      map('<leader>zq', '<cmd>Pick list scope="quickfix"<cr>', 'Quickfix')
      map('<leader>zl', '<cmd>Pick list scope="loclist"<cr>', 'Loclist')
      map('<leader>zr', '<cmd>Pick list scope="registers"<cr>', 'Registers')

      map('gd', '<cmd>Pick lsp scope="definition" <cr>', '[G]oto [D]efinition')
      map('gr', '<cmd>Pick lsp scope="references" <cr>', '[G]oto [R]ferences')
      map('<leader>cs', '<cmd>Pick lsp scope="document_symbol"<cr>', '[C]ode [S]ymbols')
      map('<leader>cd', '<cmd>Pick diagnostic<cr>', '[C]ode [D]iagnostics', { 'n', 'x' })
      --- align gitblame to right
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
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects"},
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
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- textobjects = {
    --   enable = true,
    -- },
  },
  { "nvim-treesitter/nvim-treesitter-context"},
  -- { 'kevinhwang91/nvim-bqf'},
  { 'stevearc/quicker.nvim',
  config = function()
    require("quicker").setup({
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 4, after = 4, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    })
  end
},
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
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
  pattern = 'php',
  callback = function()
    vim.b.autoformat = false
    vim.keymap.set({'i'}, '@v', 'echo "<pre>";var_dump();echo "</pre>";<esc>16ha',{desc="var_dump()"});
    vim.keymap.set({'i'}, '@d', 'var_dump();die;<esc>5hi',{desc="var_dump();die"});
    vim.keymap.set({'i'}, '@t', 'Tracy\\Debugger::dump();<esc>2ha',{desc="Debugger::bdump()"});
    vim.keymap.set({'i'}, '@b', 'Tracy\\Debugger::bdump();<esc>2ha',{desc="Debugger::bdump()"});
    vim.keymap.set({'n'}, '@v', 'iecho "<pre>";var_dump();echo "</pre>";<esc>16ha',{desc="var_dump()"});
    vim.keymap.set({'n'}, '@d', 'ivar_dump();die;<esc>5hi',{desc="var_dump();die"});
    vim.keymap.set({'n'}, '@t', 'Tracy\\Debugger::dump();<esc>2ha',{desc="Debugger::bdump()"});
    vim.keymap.set({'n'}, '@b', 'iTracy\\Debugger::bdump();<esc>2ha',{desc="Debugger::bdump()"});
  end,
})

if vim.g.neovide then
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_treil_size = 0.3
  vim.opt.linespace = 5
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
