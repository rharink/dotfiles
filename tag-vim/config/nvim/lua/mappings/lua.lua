local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Copy any selected text with pressing y
map("", "<leader>c", '"+y')

-- Open terminal(s)
map("n", "<leader>t", [[<Cmd>vnew term://fish <CR>]], opt) -- open term over right
map("n", "<leader>T", [[<Cmd> split term://fish | resize 10 <CR>]], opt) -- open term bottom

-- Kill buffer
map("n", "<leader>bd", [[<Cmd> :bd!<CR>]], opt)


map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights

