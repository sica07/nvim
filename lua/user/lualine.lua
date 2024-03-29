local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

--local hide_in_width = function()
--	return vim.fn.winwidth(0) > 80
--end
--local separator = { '"▏"', color = 'StatusLineNonText' }
local separator = { '"▏"'}

require('lualine').setup({
  options = {
    path = 1,   --relative path
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = 'auto',
    --[[theme = {
      normal = {
        a = 'StatusLine',
        b = 'StatusLine',
        c = 'StatusLine',
      },
    },]]
  },
  sections = {
    lualine_a = {
      'mode',
      separator,
    },
    lualine_b = {
      'branch',
--      'diff',
      --separator,
      --'"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
--      { 'diagnostics', sources = { 'nvim_diagnostic' } },
      separator,
    },
    lualine_c = {
      'filename',
    },
    lualine_x = {
      'filetype',
      'encoding',
      'fileformat',
    },
    lualine_y = {
      separator,
      '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
      separator,
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
})
--[[local diagnostics = {]]
	--[["diagnostics",]]
	--[[sources = { "nvim_diagnostic" },]]
	--[[sections = { "error", "warn" },]]
	--[[symbols = { error = " ", warn = " " },]]
	--[[colored = false,]]
	--[[update_in_insert = false,]]
	--[[always_visible = true,]]
--[[}]]

--[[local diff = {]]
	--[["diff",]]
	--[[colored = false,]]
	--[[symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols]]
  --[[cond = hide_in_width]]
--[[}]]

--[[local mode = {]]
	--[["mode",]]
	--[[fmt = function(str)]]
		--[[--return "-- " .. str .. " --"]]
		--[[return str]]
	--[[end,]]
--[[}]]

--[[local filetype = {]]
	--[["filetype",]]
	--[[icons_enabled = false,]]
	--[[icon = nil,]]
--[[}]]

--[[local branch = {]]
	--[["branch",]]
	--[[icons_enabled = true,]]
	--[[icon = "",]]
--[[}]]

--[[local location = {]]
	--[["location",]]
	--[[padding = 0,]]
--[[}]]

--[[-- cool function for progress]]
--[[local progress = function()]]
	--[[local current_line = vim.fn.line(".")]]
	--[[local total_lines = vim.fn.line("$")]]
	--[[local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }]]
	--[[local line_ratio = current_line / total_lines]]
	--[[local index = math.ceil(line_ratio * #chars)]]
	--[[return current_line .. " / " .. total_lines]]
	--[[--return chars[index]]
--[[end]]

--[[local spaces = function()]]
	--[[return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")]]
--[[end]]

--[[lualine.setup({]]
	--[[options = {]]
		--[[icons_enabled = true,]]
		--[[theme = "auto",]]
    --[[component_separators = { left = '', right = ''},]]
    --[[section_separators = { left = '', right = ''},]]
		--[[disabled_filetypes = { "dashboard", "NvimTree", "Outline" },]]
		--[[always_divide_middle = true,]]
	--[[},]]
	--[[sections = {]]
		--[[--lualine_a = { branch, diagnostics },]]
		--[[lualine_a = { branch },]]
		--[[lualine_b = { mode },]]
		--[[lualine_c = { {require("nvim-gps").get_location} },]]
		--[[-- lualine_x = { "encoding", "fileformat", "filetype" },]]
		--[[--lualine_x = { diff, spaces, "encoding", filetype },]]
		--[[lualine_x = { spaces, "encoding"},]]
		--[[lualine_y = { filetype },]]
		--[[lualine_z = { progress },]]
	--[[},]]
	--[[inactive_sections = {]]
		--[[lualine_a = {},]]
		--[[lualine_b = {},]]
		--[[lualine_c = { "filename" },]]
		--[[lualine_x = { progress },]]
		--[[lualine_y = {},]]
		--[[lualine_z = {},]]
	--[[},]]
	--[[tabline = {]]
		--[[lualine_a = {"%f"},]]
		--[[lualine_b = {},]]
		--[[lualine_c = {},]]
		--[[lualine_x = {},]]
		--[[lualine_y = {},]]
		--[[lualine_z = {}]]
	--[[},]]
--[[line = {},]]
	--[[extensions = {},]]
--[[})]]
