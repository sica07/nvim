local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
        "cmake",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "scss",
        "sql",
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "NvimTree" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  playground = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true,
  --     keymaps = {
  --       ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
  --       ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },
  --       ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
  --       ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
  --       ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
  --       ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
  --     },
  --   },
  -- },
}
