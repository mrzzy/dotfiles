--
-- dotfiles
-- nvim config
--

require("plugins")
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
-- keep words together when wrapping text to improve readability
vim.o.linebreak = true
-- dark mode by default
vim.o.background = "dark"

-- Keyboard Bindings
local map = vim.keymap.set
-- key bindings default leader key
vim.g.mapleader = ","
--- alternative binding for the <C-w> prefix used in window manipulation keys
map({ "n" }, "<leader>w", "<C-w>", { silent = true, nowait = true, noremap = true })
-- toggle between light & dark colorschemes
for key, background in pairs({
    ["<leader>hl"] = "light",
    ["<leader>hd"] = "dark",
}) do
    map({ "n" }, key, function() vim.o.background = background end, {})
end

for key, fn in pairs({
    -- turn off search highlight
    ["<leader>H"] = vim.cmd.noh,

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
    ["<leader>ll"] = function() vim.cmd [[LspInfo]] end,
    ["<leader>lr"] = function() vim.cmd [[LspRestart]] end,
    ["<M-j>"] = vim.lsp.buf.document_symbol,
    -- diagnostics key bindings
    ["[e"] = vim.diagnostic.goto_prev,
    ["]e"] = vim.diagnostic.goto_next,
    ["<leader>ee"] = vim.diagnostic.open_float,
    ["<C-e>"] = vim.diagnostic.setqflist,
}) do
    map({ "n" }, key, fn, { noremap = true })
end
