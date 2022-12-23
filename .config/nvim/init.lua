--
-- dotfiles
-- nvim config
--

require("plugins")

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
-- insert & command line auto completion options
vim.o.completeopt = "menu,menuone,noselect"

-- File Explorer (Netrw)
-- file explorer window size
vim.g.netrw_winsize = "20%"
-- tree style file listing
vim.g.netrw_liststyle = 3
-- disable default banner
vim.g.netrw_banner = 0

-- Keyboard Bindings
local map = vim.keymap.set
-- key bindings default leader key
vim.g.mapleader = ","
-- toggle vetween light & dark colorschemes
for key, background in pairs({
  ["<leader>hl"] = "light",
  ["<leader>hd"] = "dark",
}) do
  map({ "n" }, key, function() vim.o.background = background end, {})
end
--- alternative binding for the <C-w> prefix used in window manipulation keys
map({ "n" }, "<leader>w", "<C-w>", { silent = true, nowait = true })
-- LSP key bindings
for key, lsp_fn in pairs({
  -- documentation
  ["K"] = vim.lsp.buf.hover,
  -- navigation
  ["gT"] = vim.lsp.buf.type_definition,
  ["gD"] = vim.lsp.buf.declaration,
  ["gd"] = vim.lsp.buf.definition,
  ["gi"] = vim.lsp.buf.implementation,
  ["gr"] = vim.lsp.buf.references
}) do
  map({ "n" }, key, lsp_fn, { silent = true, noremap = true })
end
for key, lsp_fn in pairs({
  -- workspace folders
  ["<leader>wa"] = vim.lsp.buf.add_workspace_folder,
  ["<leader>wd"] = vim.lsp.buf.remove_workspace_folder,
  ["<leader>ww"] = function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,
  -- code actions
  ["<leader>cc"] = vim.lsp.buf.code_action,
  ["<leader>cw"] = vim.lsp.buf.rename,
  ["<leader>cf"] = vim.lsp.buf.formatting,
}) do
  map({ "n" }, key, lsp_fn, { noremap = true })
end
-- diagnostics key bindings
map({ "n" }, "[e", vim.diagnostic.goto_prev, { silent = true, noremap = true })
map({ "n" }, "]e", vim.diagnostic.goto_next, { silent = true, noremap = true })
map({ "n" }, "<leader>ee", vim.diagnostic.open_float, {})
map({ "n" }, "<C-e>", vim.diagnostic.setloclist, {})
