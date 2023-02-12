--
-- dotfiles
-- Neovim config
-- Plugins
--

local autocomplete = require("autocomplete")
local fn = require("functional")

-- load & install plugins with packer plugin manager if its installed
local has_packer, packer = pcall(require, "packer")
if has_packer then
  packer.startup(function(use)
    -- self manage packer.nvim
    use { "wbthomason/packer.nvim" }

    -- Editor
    -- text editing
    use { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" }
    use { "tpope/vim-surround", commit = "9857a874632d1b983a7f4b1c85e3d15990c8b101" }
    -- multi-subsitute command
    use { "tpope/vim-abolish", commit = "3f0c8faadf0c5b68bcf40785c1c42e3731bfa522" }
    -- sensible key bindings
    use { "tpope/vim-unimpaired", commit = "f992923d336e93c7f50fe9b35a07d5a92660ecaf" }
    -- editor sessions
    use {
        "tpope/vim-obsession", commit = "d2818a614ec3a5d174c6bb19e87e2eeb207f4900",
        config = function(_)
          vim.keymap.set({ "n" }, "<leader>ws", ":Obsession", {})
        end
    }
    -- auto alignment
    use {
        "junegunn/vim-easy-align",
        commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
        config = function()
          vim.keymap.set({ "n", "x" }, "<leader>=", "<Plug>(EasyAlign)", {})
        end,
    }
    -- undo history
    use {
        "mbbill/undotree",
        tag = "rel_6.1",
        config = function() vim.keymap.set({ "n" }, "<leader>uu", ":UndotreeToggle<CR>", {}) end,
    }
    -- window management
    use {
        "simeji/winresizer",
        config = function()
          vim.g.winresizer_start_key = "<leader>w<CR>"
        end,
    }
    -- git integration
    use {
        "tpope/vim-fugitive",
        tag = "v3.6",
        config = function() vim.keymap.set({ "n" }, "<leader>vv", ":Git<CR>", {}) end,
    }
    -- commenting code
    use {
        "numToStr/Comment.nvim",
        tag = "v0.7.0",
        config = function()
          require('Comment').setup()
        end
    }
    -- indent guides
    use {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v2.20.2",
        config = function()
          require("indent_blankline").setup {}
        end,
    }

    -- Colors
    -- syntax highlighting
    use { "sheerun/vim-polyglot" }
    -- colorscheme
    use {
        "sainnhe/gruvbox-material",
        tag = "v1.2.3",
        config = function()
          vim.g.gruvbox_material_background = "medium"
          vim.cmd [[colorscheme gruvbox-material]]
        end,
    }

    -- Navigation
    -- code jumping & project wide grep
    use {
        "junegunn/fzf.vim",
        commit = "b23e4bb8f853cb9641a609c5c8545751276958b0",
        requires = {
            { "junegunn/fzf", tag = "0.29.0" }
        },
        config = function()
          local map = vim.keymap.set
          map({ "n" }, "<M-p>", ":Files<CR>", {})
          map({ "n" }, "<C-p>", ":GFiles<CR>", {})
          map({ "n" }, "<C-t>", ":Tags<CR>", {})
          map({ "n" }, "<M-t>", ":Tags<CR>", {})
          map({ "n" }, "<C-Space>", ":Buffers<CR>", {})
          map({ "n" }, "<C-_>", ":Rg<CR>", {})
          map({ "n" }, "<M-/>", ":Rg<CR>", {})
          map({ "n" }, "<C-j>", function()
            vim.lsp.buf.document_symbol {
                on_list = function(opts)
                  vim.fn["fzf#run"] {
                      source = opts.items,
                      sink = "e",
                  }
                end
            }
          end, {})
        end,
    }
    -- tag file manager
    use {
        "ludovicchabant/vim-gutentags",
        commit = "b77b8fabcb0b052c32fe17efcc0d44f020975244",
        config = function()
          -- disable gutentags by default, unless toggled on explictly
          vim.g.gutentags_enabled = false
          vim.g.gutentags_define_advanced_commands = true
          -- disable gutentags for git commit as they do not does not play well together
          -- clear any existing autocmds to prevent autocmd spam
          local group_id = vim.api.nvim_create_augroup("gutentags", { clear = true })
          vim.api.nvim_create_autocmd({ "FileType" }, {
              group = group_id,
              pattern = { "gitcommit", "gitrebase" },
              callback = function(_)
                vim.g.gutentags_enabled = false
              end,
          })
        end
    }
    -- project specific file navigation
    use { "tpope/vim-projectionist", commit = "d4aee3035699b82b3789cee0e88dad0e38c423ab" }
    -- file drawer
    use {
        "nvim-tree/nvim-tree.lua",
        commit = "59e65d88db177ad1e6a8cffaafd4738420ad20b6",
        config = function()
          -- replace netrw builtin in file drawer
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          -- override special glyphs used in nvim-tree that require font support
          require("nvim-tree").setup {
              renderer = {
                  icons = {
                      glyphs = {
                          default = ".",
                          symlink = "~",
                          modified = "+",
                          bookmark = "M",
                          folder = {
                              arrow_closed = "▷",
                              arrow_open = "▼",
                              default = "/",
                              open = "/",
                              empty = "",
                              empty_open = "",
                              symlink = "",
                              symlink_open = "",
                          },
                          git = {
                              unstaged = "U",
                              staged = "S",
                              unmerged = "↔",
                              renamed = "⇒",
                              untracked = "?",
                              deleted = "D",
                              ignored = "I",
                          },
                      }
                  }
              }
          }
          -- define key bindings
          local map = vim.keymap.set
          map({ "n" }, "<leader>ff", ":NvimTreeToggle<CR>", {})
          map({ "n" }, "<leader>f.", ":NvimTreeFindFile<CR>", {})
          map({ "n" }, "<leader>fa", function()
            -- populate arglist with bookmarked files
            vim.cmd.args(fn.map(require("nvim-tree.api").marks.list(), function(node)
              return node.absolute_path
            end))
          end, {})
        end,
    }
    -- document symbols outline
    use {
        "simrat39/symbols-outline.nvim",
        commit = "512791925d57a61c545bc303356e8a8f7869763c",
        config = function(_)
          require("symbols-outline").setup {}
          -- define key bindings
          local map = vim.keymap.set
          map({ "n" }, "<leader>#", ":SymbolsOutline<CR>", {})
        end,
    }

    -- Language Support
    -- language servers
    use {
        "neovim/nvim-lspconfig",
        tag = "v0.1.3",
        requires = {
            {
                "williamboman/mason-lspconfig.nvim",
                requires = { { "williamboman/mason.nvim" } },
                run = autocomplete.install,
                config = function(_)
                  require('mason').setup()
                  require('mason-lspconfig').setup()
                end
            },
            {
                "folke/neodev.nvim",
                commit = "071c8895bbff0e4d1d3d4c531adfe20e3a2a6e82",
            }
        },
        config = autocomplete.setup_lsp,
    }
    -- autocomplete & snippets
    use {
        "hrsh7th/nvim-cmp",
        commit = "8a9e8a89eec87f86b6245d77f313a040a94081c1",
        requires = {
            { "hrsh7th/cmp-nvim-lsp",                commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" },
            { "hrsh7th/cmp-path",                    commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
            { "hrsh7th/cmp-cmdline",                 commit = "8bc9c4a34b223888b7ffbe45c4fe39a7bee5b74d" },
            { "hrsh7th/cmp-buffer",                  commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", commit = "d2768cb1b83de649d57d967085fe73c5e01f8fd7" },
            { "saadparwaiz1/cmp_luasnip",            commit = "18095520391186d634a0045dacaa346291096566" },
            {
                "L3MON4D3/LuaSnip",
                commit = "09ce9a70bd787d4ce188f2de1390f656f119347c",
                requires = { { "honza/vim-snippets" } },
                config = function(_)
                  -- load snapmate snippets from plugins (eg. vim-snippets) into luasnip's catalogue
                  require("luasnip.loaders.from_snipmate").lazy_load()
                end,
            },
        },
        config = autocomplete.setup_cmp,
    }
    -- linters & formatters
    use {
        "jose-elias-alvarez/null-ls.nvim",
        branch = "0.7-compat",
        requires = { { "nvim-lua/plenary.nvim", tag = "v0.1.2" } },
        config = function()
          local null_ls = require("null-ls")
          null_ls.setup {
              -- TODO(mrzzy): add sources
          }
        end,
    }
  end)

  -- auto :PackerCompile on plugins.lua wrie to sync compiled packer config
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("packer", { clear = true }),
      pattern = { vim.fn.stdpath("config") .. "/lua/plugins.lua" },
      callback = function() vim.cmd("PackerCompile") end,
  })
end
