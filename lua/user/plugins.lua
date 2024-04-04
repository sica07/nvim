local fn = vim.fn
vim.loader.enable();

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use ({
    "folke/neodev.nvim", -- additional lua configuration
    config = function()
      require('neodev').setup()
    end
  })
   -- use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  -- use 'tpope/vim-sleuth' -- detect tabstop and shiftwidth automatically
 use {
    "tpope/vim-surround",
    keys = {"c", "d", "y"},
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    setup = function()
     vim.o.timeoutlen = 500
    end
  }

  use "folke/which-key.nvim"
  use "kyazdani42/nvim-web-devicons"
  -- use "nvim-lualine/lualine.nvim" -- statusline

  use "tpope/vim-commentary"
	
  use "junegunn/vim-easy-align"

  -- use "neomake/neomake"
  use {"folke/trouble.nvim", cmd="TroubleToggle"}

  -- vimwiki --
    --
 use({
   "epwalsh/obsidian.nvim",
   tag = "*",  -- recommended, use latest release instead of latest commit
   requires = {
     -- Required.
     "nvim-lua/plenary.nvim",

     -- see below for full list of optional dependencies 👇
   },
   config = function()
     require("obsidian").setup({
                workspaces = {
                    {
                        name = "wiki",
                        path = "~/MEGA/vimwiki",
                    },
                    {
                        name = "work",
                        path = "~/MEGA/dailylogs",
                    },
                    {
                        name = "zet",
                        path = "~/MEGA/zettelkasten",
                    },
                },

                -- Optional, for templates (see below).
                templates = {
                    subdir = "templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                    -- A map for custom variables, the key should be the variable and the value a function
                    substitutions = {},
                },
                -- see below for full list of options 👇
     })
   end,
 })
  -- use ({
  --   'renerocksai/telekasten.nvim',
  --   requires = {
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-lua/plenary.nvim'
  --   },
  --   config = function()
  --     require('telekasten').setup({
  --       media_previewer = "viu-preview",
  --       plug_into_calendar = true,
  --       templates = vim.fn.expand("~/.config/nvim/skeletons"), -- Put the name of your templates directory here
  --       dailies_create_nonexisting = false,
  --       new_note_filename = "uuid-title",
  --       uuid_type = "%Y%m%d%H%M%S",
  --       tag_notation=":tag:",
  --       template_halding="always_ask",
  --       home = vim.fn.expand("~/MEGA/vimwiki"), -- Put the name of your notes directory here
  --       dailies = vim.fn.expand("~/MEGA/vimwiki/diary"), -- Put the name of your diary directory here
  --       vaults = {
  --         wiki = {
  --           home = vim.fn.expand("~/MEGA/vimwiki"), -- Put the name of your notes directory here
  --           dailies = vim.fn.expand("~/MEGA/vimwiki/diary"), -- Put the name of your diary directory here
  --         },
  --         zet = {
  --           home = vim.fn.expand("~/MEGA/zettelkasten"), -- Put the name of your zettelkasten directory here
  --         },
  --         work = {
  --           dailies = vim.fn.expand("~/MEGA/dailylogs"), -- Put the name of your notes directory here
  --           home = vim.fn.expand("~/MEGA/dailylogs"), -- Put the name of your notes directory here
  --         },
  --       },
  --     })
  --   end,
  -- })
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'mattn/calendar-vim'
  -- use 'vimwiki/vimwiki'
  -- use 'joanrivera/vim-zimwiki-syntax'
  use 'freitass/todo.txt-vim'

  -- PHP --
  use ({
    'phpactor/phpactor',
    branch = 'master',
    ft = 'php',
    run = 'composer install --no-dev -o'
  })

  -- Colorschemes --
  use {"ajmwagar/vim-deus", as="deus"}
  use {
    "jesseleite/nvim-noirbuddy",
    requires = { "tjdevries/colorbuddy.nvim", branch = "dev" }
  }
  use "sainnhe/everforest"
  use "folke/tokyonight.nvim"
  use "chriskempson/vim-tomorrow-theme"
  use "https://gitlab.com/yorickpeterse/vim-paper.git"
  use "fxn/vim-monochrome"
  use "sainnhe/gruvbox-material"
  use "morhetz/gruvbox"
  use "nikolvs/vim-sunbather"
  use "sica07/zoding-vim"
  use "ajgrf/sprinkles"
  --use "widatama/vim-phoenix"
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  --use "sica07/skull-vim"
  --use "mcchrish/zenbones.nvim"
  --use "rktjmp/lush.nvim" --needed by zenbones
  use "arcticicestudio/nord-vim"


  -- cmp plugins
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'jessarcher/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      --'onsails/lspkind-nvim',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    }
  })


  -- LSP --
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "nvimtools/none-ls.nvim" -- for formatters and linters
use({
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    php = { "phpcbf" },
                    go = { "gofmt", "goimports" },
                    css = { "prettierd", "prettier" },
                    clang = { "clang-format"},
                    -- python = { "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                },
                -- Set the log level. Use `:ConformInfo` to see the location of the log file.
                log_level = vim.log.levels.ERROR,
                -- Conform will notify you when a formatter errors
                notify_on_error = true,
                format_on_save = {
                    -- These options will be passed to conform.format()
                    dry_run = true, -- don't apply formatting changes to buffer
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
})
-- use({
--   "mfussenegger/nvim-lint",
--   config = function()
--     require("lint").setup()
--   end,
-- })
-- require("lint").linters_by_ft = {
--     lua = {'luacheck'},
--     php ={'psalm'},
--     javascript = {'eslint'},
--     typescript = {'eslint'},
--     css = {'stylelint'},
--     scss = {'stylelint'},
--     json = {'jsonlint'},
--     yaml = {'yamllint'},
--     markdown = {'markdownlint'},
--     go = {'golangci-lint'},
--     python = {'flake8'},
--     clang = {'clang-tidy'},
-- }
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

  use ({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({
        ui = {
          code_action = '',
        },
      })
    end,
  })

  -- Telescope --
  use ({
    "nvim-telescope/telescope.nvim",
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      -- { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
  })
use {
  "nvim-telescope/telescope-frecency.nvim",
  config = function()
    require("telescope").load_extension "frecency"
  end,
}

  -- Treesitter --
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
    }
  }
  -- use {
  --   "JoosepAlviste/nvim-ts-context-commentstring", -- set commentstring based on the cursor location
  --   config = function()                            -- useful for nested languages in a file
  --     require('nvim-treesitter.configs').setup {
  --       context_commentstring = {
  --         enable = true,
  --       }
  --     }
  --   end,
  --   event = "BufRead",
  -- }
use {
    "echasnovski/mini.ai",
    config = function()
        gen_spec = require('mini.ai').gen_spec
        require("mini.ai").setup({
            custom_textobjects = {
                f = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                i = gen_spec.treesitter({
                    a = { '@conditional.outer', '@loop.outer' },
                    i = { '@conditional.inner', '@loop.inner' },
                })
            }
            })
    end,
}
  -- use {
  --   'ray-x/guihua.lua',
  --   'ray-x/go.nvim',
  --   config = function()
  --     require "go".setup({
  --       goimport = 'gopls', -- if set to 'gopls' will use golsp format
  --       gofmt = 'gopls', -- if set to gopls will use golsp format
  --       max_line_len = 120,
  --       tag_transform = false,
  --       test_dir = '',
  --       comment_placeholder = '   ',
  --       lsp_cfg = true, -- false: use your own lspconfig
  --       lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  --       lsp_on_attach = true, -- use on_attach from go.nvim
  --       dap_debug = true,
  --     })
  --   end
  -- }

  -- Git --
  use({
    'tpope/vim-fugitive',
    requires = {
      'tpope/vim-rhubarb',
    },
    --  cmd = 'G',
  })
  use({
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
  })

  use({
    'mbbill/undotree',
  })
  use {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
   use {
     "github/copilot.vim",
     config = function()
       vim.g.copilot_assume_mapped=true
     end
   }
  -- ZenMode -- 
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "folke/twilight.nvim", -- dim inactive blocks of code (works with zenmode)
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  --use({
  --'tpope/vim-projectionist',
  --requires = 'tpope/vim-dispatch',
  --})
  --use {
  -- "windwp/nvim-ts-autotag",-- html tag autoclose
  -- event = "InsertEnter",
  -- config = function()
  --   require("nvim-ts-autotag").setup{autotag={enable=true}}
  -- end,
  -- }
  --use "preservim/nerdcommenter"
  --use "kyazdani42/nvim-tree.lua" -- file explorer
  --use {
  --"SmiteshP/nvim-gps",  --context for statusline
  --requires = "nvim-treesitter/nvim-treesitter",
  --config = function()
  --require("nvim-gps").setup()
  --end,
  --}
  --  use "voldikss/vim-floatermd
  --use "lukas-reineke/indent-blankline.nvim" -- Indent guides
  --use "sheerun/vim-polyglot"
  --use({
  --    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --    config = function()
  --      require("lsp_lines").setup()
  --      vim.diagnostic.config({ virtual_lines = false })
  --      vim.keymap.set(
  --        "",
  --        "<Leader>dl",
  --        require("lsp_lines").toggle,
  --        { desc = "Toggle lsp_lines" }
  --      )
  --    end,
  --  })
  -- DB
  --use "tpope/vim-dadbod"
  --use "kristijanhusak/vim-dadbod-ui"
  --use "kristijanhusak/vim-dadbod-completion"

  --use 'vim-test/vim-test'
  --use { -- search and replace
  --"windwp/nvim-spectre",
  --event = "BufRead",
  --config = function()
  --require("spectre").setup()
  --end,
  --}
  -- use 'liuchengxu/vista.vim'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
