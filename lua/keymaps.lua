vim.cmd("let mapleader = ' '")

-- File Explorer
vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left toggle<CR>")
vim.keymap.set("n", "<leader><S-e>", ":Neotree focus<CR>")

-- Buffer control
vim.keymap.set("n", "<tab>", ":BufferNext<CR>")
vim.keymap.set("n", "<S-tab>", ":BufferPrevious<CR>")
vim.keymap.set("n", "<leader>x", ":BufferClose<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")
vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>")

-- Code formatting
vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>/", "gcc", { remap = true })

-- Terminal
vim.keymap.set("n", "<leader>tr", ":ToggleTerm<CR>")
