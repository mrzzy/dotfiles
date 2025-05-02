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
		tag = "v0.0.2",
		config = autocomplete.setup_cmp,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "99c4e3ea26262dbe457d8fd57b1136ede6157531",
	},
	{
		"hrsh7th/cmp-path",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "853aefbca4edd58d21a6b4171a4f76a85ae01666",
	},
	{
		"hrsh7th/cmp-cmdline",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "d250c63aa13ead745e3a40f61fdd3470efde3923",
	},
	{
		"hrsh7th/cmp-buffer",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "51f42e6ef64e6ec6601f640731a94c524f165d7c",
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "031e6ba70b0ad5eee49fd2120ff7a2e325b17fa7",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		commit = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
	},
	{
		"L3MON4D3/LuaSnip",
		tag = "v2.3.0",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			-- load snapmate snippets from runtime path nvim config into luasnip's catalogue
			require("luasnip.loaders.from_snipmate").lazy_load()
			-- load vscode snippets (eg. from friendly snippets)
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "rafamadriz/friendly-snippets" },
	-- LLM Integration
	{
		"zbirenbaum/copilot.lua",
		commit = "a5c390f8d8e85b501b22dcb2f30e0cbbd69d5ff0",
		config = function()
			require("copilot").setup({
				copilot_model = "gpt-4o-copilot",
				suggestion = { enabled = false },
				panel = { enabled = true },
				-- enable on all filetypes
				filetypes = {
					yaml = true,
					markdown = true,
					help = true,
					gitcommit = true,
					gitrebase = true,
					hgcommit = true,
					svn = true,
					cvs = true,
					["."] = true,
				}
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		commit = "15fc12af3d0109fa76b60b5cffa1373697e261d1",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
