--
-- dotfiles
-- Neovim config
--

-- tab expansion
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
-- persist undo history across restarts
vim.o.undofile = true
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
-- use ripgrep as project wide search tool
vim.o.grepprg = [[rg --vimgrep --no-heading --smart-case]]
-- insert & command line auto completion options
vim.o.completeopt = "menu,menuone,noselect"
-- enable reading of project-specific config in working dir
vim.o.exrc = true
-- disable text wrapping
vim.o.wrap = false
-- dark mode by default
vim.o.background = "dark"
-- expand all folds when opening a file with folds
vim.o.foldenable = false
-- disable nested folding
vim.o.foldnestmax = 1

-- Keyboard Bindings
local map = vim.keymap.set
-- key bindings default leader key
vim.g.mapleader = " "
--- alternative binding for the <C-w> prefix used in window manipulation keys
map({ "n" }, "<leader>w", "<C-w>", { silent = true, nowait = true, noremap = true })
-- toggle between light & dark colorschemes
for key, background in pairs({
	["<leader>hl"] = "light",
	["<leader>hd"] = "dark",
}) do
	map({ "n" }, key, function()
		vim.o.background = background
	end, {})
end
for key, fn in pairs({
	-- turn off search highlight
	["<leader>H"] = vim.cmd.noh,
	-- close location, quickfix & preview windows
	["<leader>W"] = function()
		vim.cmd.cclose()
		vim.cmd.lclose()
		vim.cmd.pclose()
	end,
	-- view manpage of keyword under cursor
	["gK"] = function()
		vim.cmd.Man(vim.fn.expand("<cword>"))
	end,

	-- LSP key bindings
	-- documentation
	["K"] = vim.lsp.buf.hover,
	-- navigation
	["gT"] = vim.lsp.buf.type_definition,
	["gD"] = vim.lsp.buf.declaration,
	["gd"] = vim.lsp.buf.definition,
	["gi"] = vim.lsp.buf.implementation,
	["gr"] = vim.lsp.buf.references,
	-- workspace folders
	["<leader>wa"] = vim.lsp.buf.add_workspace_folder,
	["<leader>wd"] = vim.lsp.buf.remove_workspace_folder,
	["<leader>ww"] = function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end,
	-- code actions
	["<leader>cc"] = vim.lsp.buf.code_action,
	["<leader>cw"] = vim.lsp.buf.rename,
	["<leader>cf"] = vim.lsp.buf.format,
	-- code lens
	["<leader>cl"] = vim.lsp.codelens.run,
	-- lsp commands
	["<leader>ll"] = function()
		vim.cmd([[LspInfo]])
	end,
	["<leader>lr"] = function()
		vim.cmd([[LspRestart]])
	end,
	["<M-j>"] = vim.lsp.buf.document_symbol,
	-- diagnostics key bindings
	["[e"] = vim.diagnostic.goto_prev,
	["]e"] = vim.diagnostic.goto_next,
	["<leader>ee"] = vim.diagnostic.open_float,
	["<C-e>"] = vim.diagnostic.setqflist,
}) do
	map({ "n" }, key, fn, { noremap = true })
end

require("plugins")
