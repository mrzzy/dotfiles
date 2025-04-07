--
-- dotfiles
-- Neovim config
-- Completion Engine
--

local autocomplete = require("autocomplete")

return {
	-- completion & snippets
	{
		"hrsh7th/nvim-cmp",
		commit = "v0.0.2",
		config = autocomplete.setup_cmp,
	},

	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb",
	},
	{
		"hrsh7th/cmp-path",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
	},
	{
		"hrsh7th/cmp-cmdline",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "8bc9c4a34b223888b7ffbe45c4fe39a7bee5b74d",
	},
	{
		"hrsh7th/cmp-buffer",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "d2768cb1b83de649d57d967085fe73c5e01f8fd7",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "18095520391186d634a0045dacaa346291096566",
	},
	{
		"L3MON4D3/LuaSnip",
		commit = "09ce9a70bd787d4ce188f2de1390f656f119347c",
		dependencies = { "honza/vim-snippets" },
		config = function()
			-- load snapmate snippets from plugins (eg. vim-snippets) &
			-- runtime path nvim config into luasnip's catalogue
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	},
	{ "honza/vim-snippets" },
	-- LLM Integration
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				copilot_model = "gpt-4o-copilot",
				suggestion = { enabled = false },
				panel = { enabled = true },
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
