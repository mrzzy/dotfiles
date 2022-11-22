--
-- dotfiles
-- Neovim config
-- Autocomplete
--

M = {}
-- Lookback & return the character just prior to the position of the cursor
function M.lookback()
  -- specify 0 for current buffer
  local buffer = 0
  local line, col = unpack(vim.api.nvim_win_get_cursor(buffer))

  -- lookback not possible if we are currently on the first character
  if col == 0 then
    return nil
  end

  -- lookback at character at previous column
  -- subtract 1 from line as it is 0-indexed in nvim_buf_get_text()
  return vim.api.nvim_buf_get_text(buffer, line - 1, col - 1, line - 1, col, {})[1]
end

-- Language servers providing completion support
M.language_servers = {
  "sumneko_lua",
  "terraformls",
}

-- Install language servers
function M.install()
  require('mason').setup()
  require('mason-lspconfig').setup({ ensure_installed = M.language_servers })
end

-- Setup language servers
function M.setup_lsp()
  local lsp = require("lspconfig")
  M.install()

  -- add additional LSP capabilities supported by nvim-cmp
  lsp.util.default_config = vim.tbl_extend(
    "force",
    lsp.util.default_config, {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
  )
  -- configure language servers
  require("neodev").setup {}
  for _, server in ipairs(M.language_servers) do
    lsp[server].setup {}
  end
end

-- Setup the autocomplete engine based on nvim-cmp & neovim's LSP client
function M.setup_cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  -- load snapmate snippets from plugins (eg. vim-snippets) into luasnip's catalogue
  -- assumes snippets are stored the 'snippets' sub directory in the runtime path
  -- pass paths explicitly to workaround bug with LuaSnip's path expansion:
  -- https://github.com/L3MON4D3/LuaSnip/pull/666
  local paths = table.concat(vim.api.nvim_get_runtime_file("snippets", true), ",")
  require("luasnip.loaders.from_snipmate").lazy_load({ paths = paths })

  cmp.setup({
    -- each list of sources forms a source group. When one group fails
    -- to produce completions, nvim-cmp falls back to the next source group.
    sources = cmp.config.sources(
      { { name = "nvim_lsp_signature_help" } }, {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
      { name = "buffer" },
      { name = "path" },
    }
    ),
    -- snippet expansion
    snippet = {
      expand = function(snippet) luasnip.lsp_expand(snippet.body) end,
    },
    -- key mappings
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          -- select next item if completion menu is visible
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          -- expand snippet or jump to next field
          luasnip.expand_or_jump()
        elseif M.lookback():match("%s") then
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
        elseif luasnip.jumpable(-1) then
          -- jump to previous field in snippet
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
  })
  -- autocomplete at the vim command line
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmdline" },
      { name = "path" },
    }, {
      { name = "buffer" },
    })
  })
end

return M
