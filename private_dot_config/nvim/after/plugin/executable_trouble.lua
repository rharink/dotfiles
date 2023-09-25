require("trouble").setup {
    mode = "document_diagnostics",
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true,      -- group results by file
    padding = true,    -- add an extra new line on top of the list
    signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = false,
}

vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
