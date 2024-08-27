local wk = require("which-key")
wk.add({
    {"<leader>e","<cmd>Oil<cr>", desc="Oil", mode="n"},
    {"<leader>W", "<cmd>w !sudo tee > /dev/null %<CR>", desc="Save" },
    {"<leader>q", "<cmd>q!<CR>", desc="Quit" },
    {"<leader>Q", "<cmd>qall!<CR>", desc="Quit all" },
    {"<leader>x", "<cmd>Bdelete!<CR>", desc="Close Buffer" },
    {"<leader>vv", "<cmd>vnew<CR>", desc="split window vertically"},
    {"<leader>ss", "<cmd>vnew<CR>", desc="split window horizontally"},
    {"<leader>T", "<cmd>tabnew<CR>", desc="open new tab"},
    {"<leader>z", "<cmd>ZenMode<CR>:set norelativenumber<cr>:set nonumber<cr>:Gitsigns toggle_signs<cr>", desc="Zen mode"},
    {"<leader>O", ":set ls=0<cr> :set stal=0<cr> :set norelativenumber<cr> :set nonumber<cr> :Gitsigns toggle_signs<cr>", desc="No distractions without numbers"},
    {"<leader>-", "<cmd>hi NORMAL ctermbg=NONE guibg=NONE<cr>", desc="transparent background"},

    {"<leader>o",group= "Toggle properties"},
    {"<leader>or" ,":set relativenumber<cr>", desc="relative number ON"},
    {"<leader>oR" ,":set norelativenumber<cr>", desc="relative number OFF"},
    {"<leader>on" ,":set number<cr>", desc="line number ON"},
    {"<leader>oN" ,":set nonumber<cr>", desc="line number OFF"},
    {"<leader>os" ,":set laststatus=3<cr>", desc="statusline ON"},
    {"<leader>oS" ,":set laststatus=0<cr>", desc="statusline OFF"},
    {"<leader>ot" ,":set stal=2<cr>", desc="tabline ON"},
    {"<leader>oT" ,":set stal=0<cr>", desc="tabline OFF"},
    {"<leader>ow" ,":set winbar=%f<cr>", desc="winbar ON"},
    {"<leader>oW" ,":set winbar=<cr>", desc="winbar OFF"},
    {"<leader>og" ,":Gitsigns toggle_signs<cr>", desc="gitsigns toogle"},
    {"<leader>oc" ,":set cursorcolumn<cr>", desc="cursorcolumn ON"},
    {"<leader>oC" ,":set cursorcolumn!<cr>", desc="cursorcolumn OFF"},

    {"<leader>p",group= "Packer"},
    {"<leader>pc" ,"<cmd>PackerCompile<cr>", desc="Compile" },
    {"<leader>pi" ,"<cmd>PackerInstall<cr>", desc="Install" },
    {"<leader>ps" ,"<cmd>PackerSync<cr>", desc="Sync" },
    {"<leader>pS" ,"<cmd>PackerStatus<cr>", desc="Status" },
    {"<leader>pu" ,"<cmd>PackerUpdate<cr>", desc="Update" },

    {"<leader>g",group= "Git"},
    -- g = { "<cmd>Neogit<CR>", "Neogit" },
    {"<leader>gj" ,"<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc="Next Hunk" },
    {"<leader>gk" ,"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc="Prev Hunk" },
    {"<leader>g]" ,"<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc="Next Hunk" },
    {"<leader>g[" ,"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc="Prev Hunk" },
    {"<leader>gl" ,"<cmd>lua require 'gitsigns'.blame_line()<cr>", desc="Blame" },
    {"<leader>gp" ,"<cmd>Git push<cr>", desc="Push" },
    {"<leader>gv" ,"<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc="Preview Hunk" },
    {"<leader>gr" ,"<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc="Reset Hunk" },
    {"<leader>gR" ,"<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc="Remove unstaged" },
    {"<leader>gU" ,"<cmd>lua require 'gitsigns'.reset_buffer_index()<cr>", desc="Unstage git reset" },
    {"<leader>gZ" ,"<cmd>lua require 'gitsigns'.reset_buffer_index()<cr><cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc="git reset --hard" },
    {"<leader>gs" ,"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc="Stage Hunk" },
    {"<leader>gS" ,"<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc="Stage Buffer" },
    {"<leader>gu" ,"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc="Undo Stage Hunk", },
    {"<leader>go" ,"<cmd>FzfLua git_status<cr>", desc="Open changed file" },
    {"<leader>gb" ,"<cmd>FzfLua git_branches<cr>", desc="Checkout branch" },
    {"<leader>gc" ,"<cmd>FzfLua git_commits<cr>", desc="Checkout commit" },
    {"<leader>gd" ,"<cmd>DiffviewOpen<cr>", desc="Diff", },
    {"<leader>gh", "<cmd>Gclog -p %<cr>", desc="See file history" },
    -- '<cmd>lua _GIT_FILE_HISTORY()<cr>', "See file history"

    {"<leader>l",group= "LSP"},
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    -- R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    -- r = { "<cmd>Telescope lsp_references<cr>", "References" },
    -- "<cmd>Telescope diagnostics<cr>",
    {"<leader>la" ,"<cmd>Lspsaga code_action<cr>", desc="Code Action" },
    {"<leader>ld" ,"<cmd>FzfLua diagnostics<cr>", desc="Document Diagnostics", },
    -- {"<leader>lw" ,"<cmd>TroubleToggle diagnostics<cr>", desc="Workspace Diagnostics", },
    {"<leader>lf" ,"<cmd>lua vim.lsp.buf.format()<cr>", desc="Format" },
    {"<leader>li" ,"<cmd>LspInfo<cr>", desc="Info" },
    {"<leader>lI" ,"<cmd>LspInstallInfo<cr>", desc="Installer Info" },
    {"<leader>ll" ,"<cmd>lua vim.lsp.codelens.run()<cr>", desc="CodeLens Action" },
    {"<leader>lp" ,"<cmd>FzfLua lsp_definitions<cr>", desc="Peek definition" },
    {"<leader>lR" ,"<cmd>Lspsaga rename<cr>", desc="Rename" },
    {"<leader>lr" ,"<cmd>Lspsaga finder<cr>", desc="References" },
    {"<leader>ls" ,"<cmd>FzfLua lsp_document_symbols<cr>", desc="Document Symbols" },
    {"<leader>lS" ,"<cmd>FzfLua lsp_dynamic_workspace_symbols<cr>", desc="Workspace Symbols", },
    {"<leader>lt" ,"<cmd>Lspsaga outline<cr>", desc="Symbols outline" },
    {"<leader>lq" ,"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc="Quickfix" },

    {"<leader>f",group= "Find"},
    -- f = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live grep"},
    -- h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    -- u = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, layout_config={width=0.6}})<cr>", "Open Buffers" },
    {"<leader>fC" ,"<cmd>FzfLua commands<cr>", desc="Commands" },
    {"<leader>fM" ,"<cmd>FzfLua man_pages<cr>", desc="Man Pages" },
    {"<leader>fR" ,"<cmd>FzfLua registers<cr>", desc="Registers" },
    {"<leader>fc" ,"<cmd>FzfLua colorschemes<cr>", desc="Colorscheme" },
    {"<leader>fe" ,"<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown{previewer = false, layout_config={width=0.6}})<cr>", desc="Open recent files" },
    {"<leader>ff" ,"<cmd>FzfLua live_grep<cr>", desc="Live grep"},
    {"<leader>fh" ,"<cmd>Telescope frecency workspace=CWD<cr>", desc="Find files after frecency" },
    {"<leader>fk" ,"<cmd>FzfLua keymaps<cr>", desc="Keymaps" },
    {"<leader>fl" ,"<cmd>FzfLua loclist<cr>", desc="Open Loclist" },
    {"<leader>fp" ,"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, layout_config={width=0.6}})<cr>", desc="Find files"},
    {"<leader>fq" ,"<cmd>FzfLua quickfix<cr>", desc="Open Quickfix" },
    {"<leader>fs" ,"<cmd>lua require('spectre').open_visual({select_word=true}) <cr>", desc="Search current word"},
    {"<leader>ft" ,"<cmd>FzfLua tabs<cr>", desc="Open Tabs" },
    {"<leader>fu" ,"<cmd>FzfLua buffers<cr>", desc="Open Buffers" },
    {"<leader>fv" ,"<cmd>FzfLua grep_visual<cr>", desc="Find visual selection" },
    {"<leader>fw" ,"<cmd>FzfLua grep_cword<cr>", desc="Find word under cursor" },
    {"<leader>fz" ,"<cmd>FzfLua spell_suggest<cr>", desc="Spelling" },

    {"<leader>h",group="Frecency"},
    {"<leader>hh" ,"<cmd>Telescope frecency workspace=CWD<cr>", desc="Find files in current workspace" },
    {"<leader>ha" ,"<cmd>Telescope frecency workspace=aynax<cr>", desc="Find files in AYNAX" },
    {"<leader>hv" ,"<cmd>Telescope frecency workspace=nvim<cr>", desc="Find files in NVIM" },
    {"<leader>hc" ,"<cmd>Telescope frecency workspace=config<cr>", desc="Find files in CONFIG" },
    {"<leader>hd" ,"<cmd>Telescope frecency workspace=dl<cr>", desc="Find files in DAILYLOGS" },
    {"<leader>hs" ,"<cmd>Telescope frecency workspace=scripts<cr>", desc="Find files in SCRIPTS" },
    {"<leader>hp" ,"<cmd>Telescope frecency workspace=projects<cr>", desc="Find files in PROJECTS" },
    {"<leader>hw" ,"<cmd>Telescope frecency workspace=wiki<cr>", desc="Find files in WIKI" },
    {"<leader>hz" ,"<cmd>Telescope frecency workspace=zet<cr>", desc="Find files in ZETTELKASTEN" },

    {"<leader>x",group= "Code Actions"},
    {"<leader>xx" ,"<cmd> :PhpactorContextMenu<cr>", desc="Context menu"},
    {"<leader>xu" ,"<cmd> :PhpactorImportClass<cr>", desc="Import Class"},
    {"<leader>xf" ,"<cmd> :PhpactorExtractMethod<cr>", desc="Extract method/function"},
    {"<leader>xc" ,"<cmd> :PhpactorExtractConstant<cr>", desc="Extract Constant"},
    {"<leader>xm" ,"<cmd> :PhpactorMoveFile<cr>", desc="Move File"},
    {"<leader>xy" ,"<cmd> :PhpactorCopyFile<cr>", desc="Copy File"},
    {"<leader>xt" ,"<cmd> :PhpactorTransform<cr>", desc="Refactor tools"},
    {"<leader>xv" ,"<cmd> :PhpactorChangeVisibility<cr>", desc="Change Visibility"},
    {"<leader>xi" ,"<cmd> :PhpactorClassInflect<cr>", desc="Generate interface from current class"},
    {"<leader>xa" ,"<cmd> :PhpactorGenerateAccessors<cr>", desc="Generate accessors"},
    {"<leader>xn" ,"<cmd> :PhpactorClassNew<cr>", desc="Create new class"},
    {"<leader>xN" ,"<cmd> :PhpactorNavigate<cr>", desc="Go to classes used here"},
    {"<leader>xr" ,"<cmd>lua vim.lsp.buf.rename()<cr>", desc="Rename" },
    --r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    --
    {"<leader>d",group= "Diagnostics"},
    {"<leader>dd" ,"<cmd>FzfLua diagnostics_document<cr>", desc="document" },
    {"<leader>dw" ,"<cmd>Fzflua diagnostics_workspace<cr>", desc="workspace" },
    {"<leader>dl" ,"<cmd>Lspsaga show_line_diagnostics<cr>", desc="document" },
    {"<leader>dq" ,"<cmd>FzfLua quickfix<cr>", desc="quickfix" },
    {"<leader>dj" ,"<cmd>Lspsaga diagnostic_jump_next<CR>", desc="Next Diagnostic", },
    {"<leader>d]" ,"<cmd>Lspsaga diagnostic_jump_next<CR>", desc="Next Diagnostic", },
    {"<leader>dk" ,"<cmd>Lspsaga diagnostic_jump_prev<cr>", desc="Prev Diagnostic", },
    {"<leader>d]" ,"<cmd>Lspsaga diagnostic_jump_prev<cr>", desc="Prev Diagnostic", },
    -- {"<leader>dr" ,"<cmd>Trouble lsp_references<cr>", desc="references" },
    --l = { "<cmd>lua require('lsp_lines').toggle<cr>", "toggle virtual lines" },
    --
    {"<leader>z",group= "Obsidian"},
    -- c = {"<cmd>Calendar<CR>", "calendar"},
    {"<leader>zb" ,"<cmd>ObsidianBacklinks<CR>", desc="backlinks/references"},
    {"<leader>zc" ,"<cmd>ObsidianToggleCheckbox<CR>", desc="checkbox"},
    {"<leader>ze" ,"<cmd>ObsidianExtractNote<CR>", desc="create a new note from selection"},
    {"<leader>zf" ,"<cmd>ObsidianSearch<CR>", desc="grep and create"},
    {"<leader>zi" ,"<cmd>ObsidianPasteImg<CR>", desc="paste image"},
    {"<leader>zl" ,"<cmd>ObsidianLinks<CR>", desc="links"},
    {"<leader>zL" ,"<cmd>ObsidianLink<CR>", desc="link to existing note"},
    {"<leader>zn" ,"<cmd>ObsidianNew<CR>", desc="new note"},
    {"<leader>zN" ,"<cmd>ObsidianLinkNew<CR>", desc="create a new note and link it"},
    {"<leader>zp" ,"<cmd>ObsidianQuickSwitch<CR>", desc="find"},
    {"<leader>zt" ,"<cmd>ObsidianToday<CR>", desc="daily note"},
    {"<leader>zT" ,"<cmd>ObsidianTemplate<CR>", desc="select template"},
    {"<leader>zw" ,"<cmd>ObsidianWorkspace<CR>", desc="change workspace"},
    {"<leader>zy" ,"<cmd>ObsidianYesteday<CR>", desc="previous working day"},
    {"<leader>z#","<cmd>ObsidianTags<CR>", desc="tags"},
})
-- local status_ok, wk = pcall(require, "which-key")
-- if not status_ok then
--   return
-- end

-- local setup = {
--   plugins = {
--     marks = true, -- shows a list of your marks on ' and `
--     registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
--     spelling = {
--       enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
--       suggestions = 20, -- how many suggestions should be shown in the list?
--     },
--     -- the presets plugin, adds help for a bunch of default keybindings in Neovim
--     -- No actual key bindings are created
--     presets = {
--       operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
--       motions = true, -- adds help for motions
--       text_objects = true, -- help for text objects triggered after entering an operator
--       windows = true, -- default bindings on <c-w>
--       nav = true, -- misc bindings to work with windows
--       z = true, -- bindings for folds, spelling and others prefixed with z
--       g = true, -- bindings for prefixed with g
--     },
--   },
--   -- add operators that will trigger motion and text object completion
--   -- to enable all native operators, set the preset / operators plugin above
--   -- operators = { gc = "Comments" },
--   icons = {
--     breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
--     separator = "➜", -- symbol used between a key and it's label
--     group = "+", -- symbol prepended to a group
--   },
--   -- popup_mappings = {
--   --   scroll_down = "<c-d>", -- binding to scroll down inside the popup
--   --   scroll_up = "<c-u>", -- binding to scroll up inside the popup
--   -- },
--   win = {
--     border = "rounded", -- none, single, double, shadow
--     position = "bottom", -- bottom, top
--     margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
--     padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
--     winblend = 0,
--   },
--   layout = {
--     height = { min = 4, max = 25 }, -- min and max height of the columns
--     width = { min = 20, max = 100 }, -- min and max width of the columns
--     spacing = 3, -- spacing between columns
--     align = "left", -- align columns left, center or right
--   },
--   -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
--   -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
--   show_help = true, -- show help message on the command line when the popup is visible
--   triggers = {"auto"}, -- automatically setup triggers
--   -- triggers = {"<leader>"} -- or specify a list manually
--   -- triggers = {
--     -- list of mode / prefixes that should never be hooked by WhichKey
--     -- this is mostly relevant for key maps that start with a native binding
--     -- most people should not need to change this
--     -- i = { "j", "k" },
--     -- v = { "j", "k" },
--   -- },
-- }

-- local opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "<leader>",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }
  



-- wk.setup(setup)
