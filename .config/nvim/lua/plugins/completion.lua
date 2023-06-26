--
-- dotfiles
-- Neovim config
-- Completion Engine
--

local autocomplete = require("autocomplete")

local completion = {}

function completion.use_plugins(use)
  -- completion & snippets
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
        config = function()
          -- load snapmate snippets from plugins (eg. vim-snippets) &
          -- runtime path nvim config into luasnip's catalogue
          require("luasnip.loaders.from_snipmate").lazy_load()
        end,
      },
    },
    config = autocomplete.setup_cmp,
  }

  -- populate 'wildignore' option with the contents of .gitignore
  -- improves performance filesystem completion (eg. globbing) by reducing file candidates
  use {
    "octref/RootIgnore",
    commit = "e0142359f297021f8d35f26476bff78f4938b297",
  }
end

return completion
