vim.o.guifont = "Operator Mono Lig"
vim.opt.linespace = 0
vim.g.neovide_scale_factor = 1

vim.g.neovide_padding_top = 1
vim.g.neovide_padding_bottom = 1
vim.g.neovide_padding_right = 1
vim.g.neovide_padding_left = 1


-- Helper function for transparency formatting
local alpha = function()
    return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end
--
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.98
vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.neovide_scroll_animation_length = 0.3

vim.g.neovide_hide_mouse_when_typing = false

vim.g.neovide_remember_window_size = true

vim.g.neovide_profiler = false

vim.g.neovide_cursor_vfx_mode = "pixiedust"

vim.g.neovide_input_use_logo = 1            -- enable use of the logo (cmd) key
vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set('n', '<D-z>', 'u')           -- Undo

-- Copy/Paste from clipboard
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
