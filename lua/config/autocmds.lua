-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd [[
try
  au ColorScheme * hi! Keyword gui=bold
  au ColorScheme * hi! Comment gui=italic
endtry
]]
