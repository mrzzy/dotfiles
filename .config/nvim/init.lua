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
-- use ripgrep as project wide search tool
vim.o.grepprg = [[rg --vimgrep --no-heading --smart-case]]
-- insert & command line auto completion options
vim.o.completeopt = "menu,menuone,noselect"

-- Keyboard Bindings
local map = vim.keymap.set
-- key bindings default leader key
vim.g.mapleader = ","
-- toggle between light & dark colorschemes
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
    ["gr"] = vim.lsp.buf.references,
    ["<C-j>"] = vim.lsp.buf.document_symbol,
    ["<C-k>"] = vim.lsp.buf.workspace_symbol,
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
    ["<leader>cf"] = vim.lsp.buf.format,
    -- lsp commands
    ["<leader>ll"] = function() vim.cmd [[LspInfo]] end,
    ["<leader>lr"] = function() vim.cmd [[LspRestart]] end,
}) do
    map({ "n" }, key, lsp_fn, { noremap = true })
end
-- diagnostics key bindings
map({ "n" }, "[e", vim.diagnostic.goto_prev, { silent = true, noremap = true })
map({ "n" }, "]e", vim.diagnostic.goto_next, { silent = true, noremap = true })
map({ "n" }, "<leader>ee", vim.diagnostic.open_float, {})
map({ "n" }, "<C-e>", vim.diagnostic.setloclist, {})
