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

-- Setup the autocomplete engine based on nvim-cmp & neovim's LSP client
function M.setup_cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  -- complete from all loaded buffers
  local buffer_src_all = {
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
        buffer_src_all,
      }
    ),
    -- snippet expansion
    snippet = {
      expand = function(snippet) luasnip.lsp_expand(snippet.body) end,
    },
    -- disable LSP preselect feature
    preselect = cmp.PreselectMode.None,
    -- key mappings
    mapping = cmp.mapping.preset.insert({
      -- autocomplete bindings
      ["<Tab>"] = function(fallback)
        local A = require("autocomplete")
        if cmp.visible() then
          -- select next item if completion menu is visible
          cmp.select_next_item()
        elseif A.lookback() == nil or A.lookback():match("%s") then
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
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
    -- trigger completion after 'keyword_length' characters
    completion = {
      keyword_length = 2,
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      buffer_src_all,
    })
  })
end

return M
