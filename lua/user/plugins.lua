local fn = vim.fn

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
  use "lewis6991/impatient.nvim" -- Improve startup time
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use({
    'tpope/vim-projectionist',
    requires = 'tpope/vim-dispatch',
  })
  use {
    "tpope/vim-surround",
    keys = {"c", "d", "y"}
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  }
  -- use {
  --     'numToStr/Comment.nvim',,
  --     config = function()
  --         require('Comment').setup()
  --     end
  -- }
  use "preservim/nerdcommenter"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua" -- file explorer
  use "nvim-lualine/lualine.nvim" -- statusline
  use {
    "SmiteshP/nvim-gps",  --context for statusline
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-gps").setup()
    end,
  }
  use "voldikss/vim-floaterm"
  --use "lukas-reineke/indent-blankline.nvim" -- Indent guides
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end
  }
  use "sheerun/vim-polyglot"
  use "tommcdo/vim-lion"
  use "neomake/neomake"
  use {"folke/trouble.nvim", cmd="TroubleToggle"}
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
  use "tpope/vim-dadbod"
  use "kristijanhusak/vim-dadbod-ui"
  use "kristijanhusak/vim-dadbod-completion"
  -- vimwiki
  use 'mattn/calendar-vim'
  use 'vimwiki/vimwiki'
  use 'joanrivera/vim-zimwiki-syntax'
  use 'freitass/todo.txt-vim'

  -- PHP
  use ({
      'phpactor/phpactor',
      branch = 'master',
      ft = 'php',
      run = 'composer install --no-dev -o'
    })
  use 'vim-test/vim-test'
  use { -- search and replace
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  }
  -- use 'liuchengxu/vista.vim'

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "sica07/skull-vim"
  use "Yazeed1s/minimal.nvim"
  use "folke/tokyonight.nvim"
  use "widatama/vim-phoenix"
  use {"dracula/vim",  as= "dracula" }
  use "chriskempson/vim-tomorrow-theme"
  use "https://gitlab.com/yorickpeterse/vim-paper.git"
  use "fxn/vim-monochrome"
  use "sainnhe/gruvbox-material"
  use "sainnhe/everforest"
  use "mcchrish/zenbones.nvim"
  use "rktjmp/lush.nvim" --needed by zenbones
  use "drewtempelmeyer/palenight.vim"
  use "arcticicestudio/nord-vim"
  use "joshdick/onedark.vim"


  -- cmp plugins
  use({
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'jessarcher/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  }
  })


  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end
  }
  use "simrat39/symbols-outline.nvim"


  -- Telescope
  use ({
      "nvim-telescope/telescope.nvim",
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
      },
    })

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    }
  }
  use {
    "windwp/nvim-ts-autotag",-- html tag autoclose
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup{autotag={enable=true}}
    end,
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring", -- set commentstring based on the cursor location
    config = function()                            -- useful for nested languages in a file
      require('nvim-treesitter.configs').setup {
        context_commentstring = {
          enable = true,
        }
      }
    end,
    event = "BufRead",
  }

  -- Git
  use({
      'tpope/vim-fugitive',
      requires = 'tpope/vim-rhubarb',
      --  cmd = 'G',
    })
  use({
      'lewis6991/gitsigns.nvim',
      requires = 'nvim-lua/plenary.nvim',
    })

  -- ZenMode
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


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
