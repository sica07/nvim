local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}
local opt = { expr = true, remap = true }

-- Toggle using count
vim.keymap.set('n', '<leader>cc', "v:count == 0 ? '<Plug>(comment_toggle_current_linewise)' : '<Plug>(comment_toggle_linewise_count)'", opt)
vim.keymap.set('n', '<leader>c<space>', "v:count == 0 ? '<Plug>(comment_toggle_current_blockwise)' : '<Plug>(comment_toggle_blockwise_count)'", opt)

-- Toggle in Op-pending mode
vim.keymap.set('n', '<leader>cc', '<Plug>(comment_toggle_linewise)')
vim.keymap.set('n', '<leader>c<space>', '<Plug>(comment_toggle_blockwise)')

-- Toggle in VISUAL mode
vim.keymap.set('x', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)')
vim.keymap.set('x', '<leader>c<space>', '<Plug>(comment_toggle_blockwise_visual)')
