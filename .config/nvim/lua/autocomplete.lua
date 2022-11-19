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

  -- subtract 1 from line as nvim_buf_get_text() is 0-indexed
  local line = line - 1
  local back_col = col - 1
  -- lookback at character at previous column
  return vim.api.nvim_buf_get_text(buffer, line, col - 1, line, col, {})[1]
end

-- Setup the autocomplete engine based on nvim-cmp & neovim's LSP client
function M.setup()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  cmp.setup({
    -- each list of sources forms a source group. When one group fails
    -- to produce completions, nvim-cmp falls back to the next source group.
    sources = cmp.config.sources({
        {name="nvim-lsp"},
        {name="luasnip"},
      }, {
        {name="buffer"},
        {name="path"},
      }
    ),
    -- snippet expansion
    snippet = {
      expand = function(snippet) luasnip.lsp_expand(snippet.body) end,
    },
    -- key mappings
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"]=function(fallback)
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
      ["<S-Tab>"]=function(fallback)
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
      {name="cmdline"},
      {name="path"},
    }, {
      {name="buffer"},
    })
  })
end

return M
