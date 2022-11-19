--
-- dotfiles
-- Neovim config
-- Plugins
--

local autocomplete = require("autocomplete")

-- load & install plugins with packer plugin manager if its installed
local has_packer, packer = pcall(require, "packer")
if has_packer then
  packer.startup(function(use)
    -- self manage packer.nvim
    use {"wbthomason/packer.nvim"}
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
        vim.keymap.set({"n", "x"}, "<leader>=", "<Plug>(EasyAlign)")
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
        local map = vim.keymap.set
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
    -- tag file manager
    use {
      "ludovicchabant/vim-gutentags",
      commit="b77b8fabcb0b052c32fe17efcc0d44f020975244",
      config=function()
        -- disable gutentags by default, unless toggled on explictly 
        vim.g.gutentags_enabled = false
        vim.g.gutentags_define_advanced_commands = false
        -- disable gutentags as it does not play well with git commits
        -- TODO(mrzzy): port to nvim lua API introduces v0.7
        vim.cmd [[
        augroup gutentags
          " delete any existing autocmds to prevent autocmd spam
          autocmd!
          autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
        augroup end
        ]]
      end
    }
    -- git integration
    use {
      "tpope/vim-fugitive",
      tag="v3.6",
      config=function() vim.keymap.set({"n"}, "<leader>vv", ":Git<CR>") end,
    }
    -- undo history
    use {
       "mbbill/undotree",
      tag="rel_6.1",
      config=function() vim.keymap.set({"n"}, "<leader>uu", ":UndotreeToggle<CR>") end,
    }
    -- window management
    use {
      "simeji/winresizer",
      config=function() 
        vim.g.winresizer_start_key = "<leader>w<CR>"
      end,
    }
    -- project specific file navigation
    use {"tpope/vim-projectionist", commit="d4aee3035699b82b3789cee0e88dad0e38c423ab"}
    -- colorscheme
    use {
      "sainnhe/gruvbox-material",
      tag="v1.2.3",
      config=function()
        vim.g.gruvbox_material_background = "medium"
        vim.cmd[[colorscheme gruvbox-material]]
      end,
    }

    -- language servers
    use {
      "williamboman/mason-lspconfig.nvim", 
      requires={
        {"hrsh7th/cmp-nvim-lsp", commit="59224771f91b86d1de12570b4070fe4ad7cd1eeb"},
        {"neovim/nvim-lspconfig", tag="v0.1.3"},
        {"williamboman/mason.nvim"}
      },
      after={
        "nvim-lspconfig",
        "cmp-nvim-lsp",
        "mason.nvim",
      },
      config=autocomplete.setup_lsp,
    }

    -- autocomplete & snippets
    use {
      "hrsh7th/nvim-cmp", 
      commit="8a9e8a89eec87f86b6245d77f313a040a94081c1",
      requires={
        {"hrsh7th/cmp-path", commit="91ff86cd9c29299a64f968ebb45846c485725f23"},
        {"hrsh7th/cmp-cmdline", commit="8bc9c4a34b223888b7ffbe45c4fe39a7bee5b74d"},
        {"hrsh7th/cmp-buffer", commit="3022dbc9166796b644a841a02de8dd1cc1d311fa"},
        {"hrsh7th/cmp-nvim-lsp-signature-help", commit="d2768cb1b83de649d57d967085fe73c5e01f8fd7"},
        {
          "saadparwaiz1/cmp_luasnip",
          commit="18095520391186d634a0045dacaa346291096566",
          requires={{"L3MON4D3/LuaSnip", tag="v1.1.0"}},
        }
      },
      after={
        "mason-lspconfig.nvim",
        "cmp-nvim-lsp",
        "cmp-buffer",
        "cmp-path",
        "cmp-cmdline",
        "cmp_luasnip",
        "cmp-nvim-lsp-signature-help",
      },
      config=autocomplete.setup_cmp,
    }
  end)
end
