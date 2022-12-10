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

-- Language servers providing completion support
M.language_servers = {
  "sumneko_lua", -- lua
  "terraformls", -- terraform
  "dockerls", -- docker
  "bashls", -- bash
  "pyright", -- python
  "gopls", -- golang
  "yamlls", -- yaml
  "ansiblels", -- ansible
  "rust_analyzer", -- rust
  "tsserver", -- javascript
}

-- Install language servers
function M.install()
  -- convert lsp server name ot mason naming scheme
  local mason_servers = {}
  local mason_map = require("mason-lspconfig.mappings.server").lspconfig_to_package
  for _, server in ipairs(require("autocomplete").language_servers) do
    table.insert(mason_servers, mason_map[server])
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
  for _, server in ipairs(require("autocomplete").language_servers) do
    lsp[server].setup {}
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
    -- each list of sources forms a source group. When one group fails
    -- to produce completions, nvim-cmp falls back to the next source group.
    sources = cmp.config.sources(
      {
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        buffer_src,
        { name = "path" },
        { name = "luasnip" },
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
          -- insert a tab if character preceeding is whitespace
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
      ['<M-u>'] = cmp.mapping.scroll_docs(-4),
      ['<M-d>'] = cmp.mapping.scroll_docs(4),
      -- snippet bindings
      ['<M-x>'] = cmp.mapping(function() luasnip.expand_or_jump() end, { "i", "s" }),
      ['<M-k>'] = cmp.mapping(function() luasnip.jump(-1) end, { "i", "s" }),
      ['<M-j>'] = cmp.mapping(function() luasnip.jump(1) end, { "i", "s" }),
    }),
  })
  -- autocomplete at the vim command line
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmdline" },
      { name = "path" },
      buffer_src,
    })
  })
end

return M
