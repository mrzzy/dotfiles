--
-- dotfiles
-- Neovim config
-- Plugins
--


-- load & install plugins with packer plugin manager if its installed
local has_packer, packer = pcall(require, "packer")
if has_packer then
  packer.startup(function(use)
    -- self manage packer.nvim
    use { "wbthomason/packer.nvim" }

    require("plugins.editor").use_plugins(use)
    require("plugins.navigation").use_plugins(use)
    require("plugins.completion").use_plugins(use)

    -- Colors
    -- syntax highlighting
    use { "sheerun/vim-polyglot" }
    -- colorscheme
    use {
       "ellisonleao/gruvbox.nvim",
        tag = "1.0.0",
        config = function()
          require("gruvbox").setup({
              inverse = true,
          })
          vim.cmd [[colorscheme gruvbox]]
        end,
    }

    -- Language Support
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
    -- Obsidian notes
    use {
        "epwalsh/obsidian.nvim",
        tag = "v1.7.0",
        requires = { "hrsh7th/nvim-cmp" },
        config = function()
          require("obsidian").setup {
              dir = "~/notepad",
              disable_frontmatter = true,
              daily_notes = {
                  folder = "journal",
              },
              -- autocomplete wikilinks
              completion = {
                  nvim_cmp = true,
              }
          }
          -- key bindings
          local map = vim.keymap.set
          map({ "n" }, "<leader>o[", ":ObsidianBacklinks<CR>", {})
          map({ "n" }, "<leader>oo", ":ObsidianOpen<CR>", {})
          map({ "n" }, "<leader>oj", ":ObsidianToday<CR>", {})
          -- override 'gf' for navigating wikilinks navigation
          map({ "n" }, "gf", function(_)
            if require('obsidian').util.cursor_on_markdown_link() then
              return ":ObsidianFollowLink<CR>"
            else
              return "gf"
            end
          end, { noremap = false, expr = true })
        end
    }
  end)

  -- auto :PackerCompile on plugins.lua write to sync compiled packer config
  local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins/"
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("packer", { clear = true }),
      pattern = { plugin_dir .. "*.lua" },
      callback = function()
        -- re-source plugins.lua
        dofile(plugin_dir .. "init.lua")
        vim.cmd("PackerCompile")
      end,
  })
end
