local mark = require("harpoon.mark");
local ui = require("harpoon.ui");

require("telescope").load_extension('harpoon')

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", function() ui.toggle_quick_menu() end)

vim.keymap.set("n", "!", function() ui.nav_file(1) end)
vim.keymap.set("n", "@", function() ui.nav_file(2) end)
vim.keymap.set("n", "#", function() ui.nav_file(3) end)
vim.keymap.set("n", "$", function() ui.nav_file(4) end)