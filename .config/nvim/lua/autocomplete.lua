--
-- dotfiles
-- Neovim config
-- Autocomplete
--


local M = {}
-- Lookback & return the character just prior to the position of the cursor
function M.lookback()
  -- specify 0 for current buffer
  local buffer = 0
  local line, col = unpack(vim.api.nvim_win_get_cursor(buffer))

  -- lookback not possible if we are currently on the first character
  if col <= 0 then
    return nil
  end

  -- lookback at character at previous column
  -- subtract 1 from line as it is 0-indexed in nvim_buf_get_text()
  return vim.api.nvim_buf_get_text(buffer, line - 1, col - 1, line - 1, col, {})[1]
end

-- Language servers providing completion support & their custom setup functions
-- each setup function returns a table that is passed to the lspconfig's setup()
local noop = function() return {} end
M.language_servers = {
    -- lua
    ["sumneko_lua"] = noop,
    -- terraform
    ["terraformls"] = noop,
    -- docker
    ["dockerls"] = noop,
    -- bash
    ["bashls"] = noop,
    -- python
    ["pyright"] = noop,
    -- golang
    ["gopls"] = noop,
    -- yaml
    ["yamlls"] = function()
      return {
          settings = {
              yaml = {
                  keyOrdering = false
              }
          }
      }
    end,
    -- html
    ["html"] = noop,
    -- ansible
    ["ansiblels"] = noop,
    -- rust
    ["rust_analyzer"] = noop,
    -- javascript
    ["tsserver"] = noop,
    -- java
    ["jdtls"] = function()
      -- jdtls's lspconfig references $JDTLS_HOME env var, so we set it here.
      vim.env.JDTLS_HOME = require("mason-registry").get_package(
              require("mason-lspconfig.mappings.server").lspconfig_to_package["jdtls"]
          ):get_install_path()
      return {}
    end,
    -- scala, installed manually, see https://github.com/mrzzy/warp
    ["metals"] = noop,
    -- c/c++
    ["clangd"] = function()
      -- clangd needs to query native gcc compiler for build config
      return {
          cmd = { "clangd", "--query-driver=/usr/bin/*" },
      }
    end,
    -- sql
    ["sqlls"] = noop,
    -- latex
    ["texlab"] = function()
      -- configure texlab to use tectonic
      -- https://github.com/latex-lsp/texlab/wiki/Tectonic
      return {
          settings = {
              texlab = {
                  build = {
                      executable = "tectonic",
                      args = {
                          "-X",
                          "compile",
                          "%f",
                          "--synctex",
                          "--keep-logs",
                          "--keep-intermediates",
                      }
                  }
              }
          }
      }
    end,
}

-- Install language servers
function M.install()
  local map_package = require("mason-lspconfig.mappings.server").lspconfig_to_package
  -- convert lsp server name to mason naming scheme
  local mason_servers = {}
  for server, _ in pairs(require("autocomplete").language_servers) do
    -- only install servers supported by mason
    if map_package[server] ~= nil then
      table.insert(mason_servers, map_package[server])
    end
  end
  -- install language servers with mason
  require("mason.api.command").MasonInstall(mason_servers)
end

-- Setup language servers
function M.setup_lsp()
  local lsp = require("lspconfig")
  -- setup vim lua api completion, must be done before lspconfig setup
  require("neodev").setup {}
  -- add additional LSP capabilities supported by nvim-cmp
  lsp.util.default_config = vim.tbl_extend(
          "force",
          lsp.util.default_config, {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
  -- configure language servers
  for server, setup_fn in pairs(require("autocomplete").language_servers) do
    lsp[server].setup(setup_fn())
  end
end

-- Setup the autocomplete engine based on nvim-cmp & neovim's LSP client
function M.setup_cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  -- complete from all loaded buffers
  local buffer_src = {
      name = "buffer",
      option = {
          get_bufnrs = vim.api.nvim_list_bufs,
      }
  }
  cmp.setup({
      -- trigger completion after 'keyword_length' characters
      completion = {
          keyword_length = 2,
      },
      -- each list of sources forms a source group. When one group fails
      -- to produce completions, nvim-cmp falls back to the next source group.
      sources = cmp.config.sources(
          {
              { name = "nvim_lsp_signature_help" },
              { name = "nvim_lsp" },
              { name = "path" },
              { name = "luasnip" },
          }, {
          buffer_src,
      }
      ),
      -- snippet expansion
      snippet = {
          expand = function(snippet) luasnip.lsp_expand(snippet.body) end,
      },
      -- key mappings
      mapping = cmp.mapping.preset.insert({
          -- autocomplete bindings
          ["<Tab>"] = function(fallback)
            local M = require("autocomplete")
            if cmp.visible() then
              -- select next item if completion menu is visible
              cmp.select_next_item()
            elseif M.lookback() == nil or M.lookback():match("%s") then
              -- insert a tab if character preceding is whitespace
              fallback()
            else
              -- trigger completion
              cmp.complete()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              -- select previous item if completion menu is visible
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<BS>'] = function(fallback)
            cmp.close()
            fallback()
          end,
          ['<M-u>'] = cmp.mapping.scroll_docs( -4),
          ['<M-d>'] = cmp.mapping.scroll_docs(4),
          -- snippet bindings
          ['<M-x>'] = cmp.mapping(function() luasnip.expand_or_jump() end, { "i", "s" }),
          ['<M-k>'] = cmp.mapping(function() luasnip.jump( -1) end, { "i", "s" }),
          ['<M-j>'] = cmp.mapping(function() luasnip.jump(1) end, { "i", "s" }),
      }),
  })
  -- autocomplete at the vim command line
  cmp.setup.cmdline(":", {
      -- trigger completion after 'keyword_length' characters
      completion = {
          keyword_length = 2,
      },
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "path" },
      }, {
          buffer_src,
      })
  })
end

return M
