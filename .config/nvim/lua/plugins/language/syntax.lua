--
-- dotfiles
-- Neovim config
-- Language Support: Syntax
--

local syntax = {}

function syntax.use_plugins(use)
  -- neovim lua
  use {
    "folke/neodev.nvim",
    tag = "v2.5.2",
  }

  -- treesitter: syntax tree
  use {
    'nvim-treesitter/nvim-treesitter',
    tag = "v0.9.0",
    run = function()
      -- install or upgrade treesitter parsers
      local ts = require('nvim-treesitter.install')
      ts.update { with_sync = true } {
        "python", "c", "lua", "vim", "vimdoc", "query", "go", "rust", "java", "scala",
        "bash", "cpp", "css", "html", "javascript", "typescript", "dockerfile",
        "latex", "lua", "make", "cmake", "sql", "proto", "yaml",
      }
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- auto install parsers when opening a buffer without one
        auto_install = true,
        -- use treesitter for '=' auto indent
        indent = {
          enabled = true,
        },
        -- use treesitter for syntax highlighting
        highlight = {
          enabled = true,
          -- disable on large files
          disable = function(_, buf)
            return require("utilities").is_large(buf)
          end,
        },
        -- treesitter's incremental selection based on syntax nodes
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>v',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },
      }
      -- use treesitter for code folding
      vim.o.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
  }
end

return syntax
