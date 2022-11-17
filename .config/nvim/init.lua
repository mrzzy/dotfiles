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
function map(modes, lhs, rhs, opts) 
  opts = opts or {}
  -- allow one mode to be passed as atomic string, multiple modes as table
  for i,mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end
-- keyboard bindings default leader key
vim.g.mapleader = ","

-- Plugins
-- load & install plugins with packer plugin manager if its installed
local has_packer, packer = pcall(require, "packer")
packer.startup(function(use)
  -- self manage packer
  use 'wbthomason/packer.nvim'
  -- text editing
  use {"tpope/vim-repeat", commit="24afe922e6a05891756ecf331f39a1f6743d3d5a"}
  use {"tpope/vim-surround", commit="9857a874632d1b983a7f4b1c85e3d15990c8b101"}
  -- multi-subsitute command
  use {"tpope/vim-abolish", commit="3f0c8faadf0c5b68bcf40785c1c42e3731bfa522"}
  -- sensible key bindings
  use {"tpope/vim-unimpaired", commit="f992923d336e93c7f50fe9b35a07d5a92660ecaf"}
  -- editor sessions
  use {"tpope/vim-obsession", commit="d2818a614ec3a5d174c6bb19e87e2eeb207f4900"}
  -- auto alignment
  use {
    "junegunn/vim-easy-align",
    commit="12dd6316974f71ce333e360c0260b4e1f81169c3",
    config=function()
      map({"n", "x"}, "<leader>=", "<Plug>(EasyAlign)")
    end,
  }
  -- code jumping & project wide grep
  use {
    "junegunn/fzf.vim",
    commit="b23e4bb8f853cb9641a609c5c8545751276958b0",
    requires={
      {"junegunn/fzf", tag="0.29.0"}
    },
    config=function()
      map({"n"}, "<M-p>", ":Files<CR>")
      map({"n"}, "<C-p>", ":GFiles<CR>")
      map({"n"}, "<C-t>", ":Tags<CR>")
      map({"n"}, "<M-t>", ":Tags<CR>")
      map({"n"}, "<C-Space>", ":Buffers<CR>")
      map({"n"}, "<C-_>", ":Rg<CR>")
      map({"n"}, "<M-/>", ":Rg<CR>")
    end,
  }
  -- syntax highlighting
  use {"sheerun/vim-polyglot"}
end)  -- default to no mapping options
