local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 100 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
  ["e"] = { "<cmd>Oil<cr>", "Oil" },
  -- ["w"] = { "<cmd>w!<CR>", "Save" },
  ["W"] = { "<cmd>w !sudo tee > /dev/null %<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["Q"] = { "<cmd>qall!<CR>", "Quit all" },
  ["x"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["vv"] = { "<cmd>vnew<CR>", "split window vertically"},
  ["ss"] = { "<cmd>vnew<CR>", "split window horizontally"},
  ["T"] = { "<cmd>tabnew<CR>", "open new tab"},
  ["z"] = { "<cmd>ZenMode<CR>:set norelativenumber<cr>:set nonumber<cr>:Gitsigns toggle_signs<cr>", "Zen mode"},
  ["O"] = {":set ls=0<cr> :set stal=0<cr> :set norelativenumber<cr> :set nonumber<cr> :Gitsigns toggle_signs<cr>", "No distractions without numbers"},
  ["-"] = {"<cmd>hi NORMAL ctermbg=NONE guibg=NONE<cr>", "transparent background"},

  o = {
    name = "Toggle properties",
    r = {":set relativenumber<cr>", "relative number ON"},
    R = {":set norelativenumber<cr>", "relative number OFF"},
    n = {":set number<cr>", "line number ON"},
    N = {":set nonumber<cr>", "line number OFF"},
    s = {":set laststatus=3<cr>", "statusline ON"},
    S = {":set laststatus=0<cr>", "statusline OFF"},
    t = {":set stal=2<cr>", "tabline ON"},
    T = {":set stal=0<cr>", "tabline OFF"},
    w = {":set winbar=%f<cr>", "winbar ON"},
    W = {":set winbar=<cr>", "winbar OFF"},
    g = {":Gitsigns toggle_signs<cr>", "gitsigns toogle"},
    c = {":set cursorcolumn<cr>", "cursorcolumn ON"},
    C = {":set cursorcolumn!<cr>", "cursorcolumn OFF"},
  },

  c = {
    name = "NerdComment",
    ["space"] = {"<cmd>NERDCommenterToggle"},
    c = {"<cmd>NERDCommenterComment"},
    i = {"<cmd>NERDCommenterInvert"},
    A = {"<cmd>NERDCommenterAppend"},
    a = {"<cmd>NERDCommenterAltDelims"},
    s = {"<cmd>NERDCommenterSexy"},
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>Git<CR>", "Lazygit" },
    -- g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>Git push<cr>", "Push" },
    v = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Remove unstaged" },
    U = { "<cmd>lua require 'gitsigns'.reset_buffer_index()<cr>", "Unstage git reset" },
    Z = { "<cmd>lua require 'gitsigns'.reset_buffer_index()<cr><cmd>lua require 'gitsigns'.reset_buffer()<cr>", "git reset --hard" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
    L = { "<cmd>lua require('telescope.builtin').loclist(require('gitsigns').setloclist())<cr>", "Open diffs in loclist" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    h = {
      -- '<cmd>lua _GIT_FILE_HISTORY()<cr>', "See file history"
      '<cmd>Gclog -p %<cr>', "See file history"
    }
  },

  l = {
    name = "LSP",
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    d = {
      -- "<cmd>Telescope diagnostics<cr>",
      "<cmd>TroubleToggle loclist<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    K = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    -- R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>Lspsaga rename<cr>", "Rename" },
    -- r = { "<cmd>Telescope lsp_references<cr>", "References" },
    r = { "<cmd>Lspsaga finder<cr>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    t = { "<cmd>Lspsaga outline<cr>", "Symbols outline" }
  },
  f = {
    name = "Find",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    -- h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    h = { "<cmd>lua require('spectre').open() <cr>", "Search & Replace"},
    s = { "<cmd>lua require('spectre').open_visual({select_word=true}) <cr>", "Search current word"},
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    e = { "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown{previewer = false, layout_config={width=0.6}})<cr>", "Open recent files" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    q = { "<cmd>Telescope quickfix<cr>", "Open Quickfix" },
    l = { "<cmd>Telescope loclist<cr>", "Open Loclist" },
    z = { "<cmd>Telescope spell_suggest<cr>", "Spelling" },
    p = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, layout_config={width=0.6}})<cr>", "Find files"},
    f = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live grep"},
    u = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, layout_config={width=0.6}})<cr>", "Open Buffers" },
  },
  t = {
    name = "Terminal",
    t = { "<cmd>FloatermToggle scratch<cr>", "Float term" },
  },
  x = {
    name = "Code Actions",
    x = {"<cmd> :PhpactorContextMenu<cr>", "Context menu"},
    u = {"<cmd> :PhpactorImportClass<cr>", "Import Class"},
    f = {"<cmd> :PhpactorExtractMethod<cr>", "Extract method/function"},
    c = {"<cmd> :PhpactorExtractConstant<cr>", "Extract Constant"},
    m = {"<cmd> :PhpactorMoveFile<cr>", "Move File"},
    y = {"<cmd> :PhpactorCopyFile<cr>", "Copy File"},
    t = {"<cmd> :PhpactorTransform<cr>", "Refactor tools"},
    v = {"<cmd> :PhpactorChangeVisibility<cr>", "Change Visibility"},
    i = {"<cmd> :PhpactorClassInflect<cr>", "Generate interface from current class"},
    a = {"<cmd> :PhpactorGenerateAccessors<cr>", "Generate accessors"},
    n = {"<cmd> :PhpactorClassNew<cr>", "Create new class"},
    N = {"<cmd> :PhpactorNavigate<cr>", "Go to classes used here"},
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    --r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  },
  d = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    --l = { "<cmd>lua require('lsp_lines').toggle<cr>", "toggle virtual lines" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
  },
  w = {
    name = "Vimwiki",
    d = {"<cmd>VimwikiDiaryIndex<cr>", "Diary Index"},
    u = {"<cmd>VimwikiDiaryGenerateLinks<cr>", "Update diary index links"},
    j = {"<cmd>VimwikiMakeDiaryNote<cr>", "new journal entry"},
    t = {"<cmd>VimwikiSearchTags<cr>", "Tags"},
    T = {"<cmd>Toc<cr>", "Toc"},
    w = {"<cmd>VimwikiIndex<cr>", "Index"},
    I = {"<cmd>VimwikiUISelect<cr>", "Wiki List"},
    x = {"<cmd>VimwikiDeleteFile<cr>", "Delete wiki page you are in"},
    r = {"<cmd>VimwikiRenameFile<cr>", "Rename wiki page you are in"},
    z = {"<cmd>=strftime('%Y%m%d%H%M%S') . '-'<CR>", "insert date"},
    Z = {"<cmd>Zet ", "create Zetelkasten"}
  },
  u = {
    name = "Unit tests",
    n = {"<cmd>TestNearest<CR>", "test nearest"},
    f = {"<cmd>TestFile<CR>", "test file"},
    s = {"<cmd>TestSuite<CR>", "test suite"},
    l = {"<cmd>TestLast<CR>", "test last"},
    v = {"<cmd>TestVisit<CR>", "test visit"},
  },
  z = {
    name = "Telekasten",
    p = {"<cmd>Telekasten find_notes<CR>", "find"},
    f = {"<cmd>Telekasten search_notes<CR>", "grep"},
    d = {"<cmd>Telekasten goto_today<CR>", "diary entrance"},
    z = {"<cmd>Telekasten follow_link<CR>", "follow link"},
    n = {"<cmd>Telekasten new_note<CR>", "new note"},
    r = {"<cmd>Telekasten show_backlinks<CR>", "backlinks/references"},
    c = {"<cmd>Telekasten show_calendar<CR>", "calendar"},
    T = {"<cmd>Telekasten new_templated_note<CR>", "template note"},
    ["?"] = {"<cmd>Telekasten panel<CR>", "all commands"},
    x = {"<cmd>Telekasten toggle_todo<CR>", "toggle todo"},
    [";"] = {"<cmd>Telekasten show_tags<CR>", "tags"},

  }
}

local visual_opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
 local visual_mappings = {
  c = {
    name = "NerdComment",
    ["space"] = {"<cmd>NERDCommenterToggle"},
    i = {"<cmd>NERDCommenterInvert"},
    s = {"<cmd>NERDCommenterSexy"},
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(visual_mappings, visual_opts)
