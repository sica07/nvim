return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  -- "junegunn/vim-easy-align",
  'mattn/calendar-vim',
  {
    'echasnovski/mini.align',
    version = '*',
    opts = {
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    },
    config = function()
      require("mini.align").setup({})
    end

  },
  {
    'freitass/todo.txt-vim',
    opts = {
      todo_done_filename = "done.txt",
    },
    config = function()
    end
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Oil<CR>", desc = "File Explorer" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        natural_order = true,
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
        ["local"] = false,
      },
      provider = "openai",
      auto_suggestions_provider = "openai",
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make BUILD_FROM_SOURCE=true",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },

  {
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
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
            name = "zet",
            path = "~/MEGA/zettelkasten",
          },
          {
            name = "work",
            path = "~/MEGA/dailylogs",
          },
        },
        daily_notes = {
          folder = "~/MEGA/vimwiki/diary",
          date_format = "%Y-%m-%d",
        },
        -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
        -- way then set 'mappings = {}'.
        mappings = {
          -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- Toggle check-boxes.
          ["<leader>ch"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
          -- Smart action depending on context, either follow link or toggle checkbox.
          ["<cr>"] = {
            action = function()
              return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
          },
        },
        picker = {
          -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
          name = "fzf-lua",
        },

        -- Optional, for templates (see below).
        -- templates = {
        --     subdir = "~/MEGA/dailylogs/templates",
        --     date_format = "%Y-%m-%d",
        --     time_format = "%H:%M",
        --     -- A map for custom variables, the key should be the variable and the value a function
        --     substitutions = {},
        -- },
        -- see below for full list of options 👇
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
