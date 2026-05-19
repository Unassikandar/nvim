


vim.opt.number = true
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.wrap = false -- disable line wrap
vim.opt.cursorline = true --highlights the line where cursor is
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom
vim.opt.laststatus = 3 -- single status line on split windows
vim.opt.scrolloff = 8 -- keep 8 lines below or above cursor when scrolling
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- set the path for undo directory. use with the undofile opt
vim.opt.undofile = true -- enable persistent undo
vim.g.loaded_netrw = 1 -- Disable netrw (required by nvim-tree)
vim.g.loaded_netrwPlugin = 1 -- Disable netrw (required by nvim-tree)
-- vim.o.cmdheight = 0 -- change the command line height to 0



vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank()
  end,
})

