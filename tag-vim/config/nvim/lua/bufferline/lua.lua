vim.o.termguicolors = true

-- colors for active , inactive buffer tabs 
require "bufferline".setup {
    options = {
      view = "default",
    numbers = "ordinal",
    number_style = "superscript",
    mappings = true,
    buffer_close_icon = "",
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is deduplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict)
      return "("..count..")"
    end
    },
    separator_style = "thin",
    highlights = {
        background = {
            guifg = comment_fg,
            guibg = "#121212"
        }
    }
}

local opt = {silent = true}

vim.g.mapleader = " "

--command that adds new buffer and moves to it
--vim.api.nvim_command "com -nargs=? -complete=file_in_path New badd <args> | blast"
--vim.api.nvim_set_keymap("n","<S-b>",":New ", opt)

--removing a buffer
--vim.api.nvim_set_keymap("n","<S-f>",[[<Cmd>bdelete<CR>]], opt)

-- tabnew and tabprev
vim.api.nvim_set_keymap("n", "gt", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "gT", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
