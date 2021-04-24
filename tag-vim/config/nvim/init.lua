-- load all plugins
require("pluginsList.lua")
require("file-icons.lua")
require("misc-utils.lua")
require("nvimTree.lua")
require("bufferline.lua")
require("statusline.lua")
require("telescope.lua")
require("gitsigns.lua")
require "colorizer".setup()
require("treesitter.lua")
require("mappings.lua")

-- lsp
require("lspconfig.lua")

-- langs
require("lang.rust")

local cmd = vim.cmd
local g = vim.g

g.mapleader = " "
g.auto_save = 1

-- deoplete
g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup
g['deoplete#lsp#use_icons_for_candidates'] = 'v:true'
--
-- colorscheme related stuff
cmd "syntax enable"
cmd "syntax on"
cmd "colorscheme moonfly"

-- Options
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for deoplete)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers
opt('w', 'wrap', false)                               -- Disable line wrap
opt("w", "cul", true)
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)
opt("o", "updatetime", 250)                           -- update interval for gitsigns

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false


-- highlights --
cmd("hi IndentBlanklineChar guifg=#26292e")
cmd("hi LineNr guibg=NONE")
cmd("hi SignColumn guibg=NONE")
cmd("hi VertSplit guibg=NONE guifg=#3e4451")
cmd("hi DiffAdd guifg=#8cc85f guibg = none")
cmd("hi DiffChange guifg =#ae81ff guibg = none")
cmd("hi DiffModified guifg = #e2637f guibg = none")
cmd("hi EndOfBuffer guifg=#26292e")
cmd("hi cursorlinenr guibg=NONE guifg=#e2637f")

-- telescope stuff and popupmenu
cmd("hi TelescopeBorder   guifg=#3e4451")
cmd("hi TelescopePromptBorder   guifg=#3e4451")
cmd("hi TelescopeResultsBorder  guifg=#3e4451")
cmd("hi TelescopePreviewBorder  guifg=#525865")
cmd("hi PmenuSel  guibg=#8cc85f")

-- tree folder name , icon color
cmd("hi NvimTreeFolderIcon guifg = #80a0ff")
cmd("hi NvimTreeFolderName guifg = #80a0ff")
cmd("hi NvimTreeIndentMarker guifg=#545862")

require("nvim-autopairs").setup()
require("lspkind").init(
    {
        File = " "
    }
)

vim.api.nvim_exec(
    [[
augroup NvimTree 
  au!
  au FileType NvimTree setlocal winhighlight=Normal:CustomExplorerBg
 augroup END
 ]],
    false
    )

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)

-- inactive statuslines as thin splitlines
--cmd("highlight! StatusLineNC gui=underline guibg=NONE guifg=#3e4451")
