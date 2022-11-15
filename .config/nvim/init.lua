--
-- dotfiles
-- nvim config
--

-- Editor
-- tab expansion
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
-- reduce for better responsiveness
vim.o.updatetime = 300
-- show no-visible characters
vim.o.list = true
-- show number
vim.o.number = true
-- 24-bit color goodness
vim.o.termguicolors = true
-- 80-char column as reminder to break long lines
vim.o.colorcolumn = "80"
-- search: ignore case unless uppercase letters in query
vim.o.ignorecase = true
vim.o.smartcase = true
-- project specific nvim config via .nvimrc/.exrc
vim.o.exrc = true
vim.o.secure = true
-- use ripgrep as project wide search tool
vim.o.grepprg = [[rg --vimgrep --no-heading --smart-case]]
 
-- Keyboard Bindings
map = vim.api.set_keymap
-- keyboard bindings default leader key
vim.g.mapleader = ","
