--
-- dotfiles
-- Neovim config
-- Language Support
--

local langserver = require("langserver")

-- Language Support Plugins
return {
	{ import = "plugins.language.jvm" },
	{ import = "plugins.language.dap" },
	{ import = "plugins.language.treesitter" },

	-- package manager for language servers & debug adaptors
	{
		"williamboman/mason.nvim",
		tag = "v1.10.0",
		build = require("debugadaptor").install,
		config = function()
			require("mason").setup()
		end,
	},

	-- language servers
	{
		"neovim/nvim-lspconfig",
		tag = "v1.4.0",
	},

	-- Mason - lspconfig integration
	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.29.0",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		build = langserver.install,
		config = function()
			require("mason-lspconfig").setup()
			langserver.setup_lsp()
		end,
	},
	-- none ls: linters, formatters & code actions
	{
		"nvimtools/none-ls.nvim",
		commit = "fff481b65d88415933b9574dc0e1947724bcf64a",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				debug = true,
				sources = {
					-- Code Actions
					-- git actions
					null_ls.builtins.code_actions.gitsigns,

					-- Linters
					-- spelling
					null_ls.builtins.diagnostics.codespell,
					-- terraform
					null_ls.builtins.diagnostics.terraform_validate,

					-- Formatters
					-- js, ts, css, html, yaml, markdown
					null_ls.builtins.formatting.prettier,
					-- sql
					null_ls.builtins.formatting.sqlfmt,
					-- python
					null_ls.builtins.formatting.black,
					-- go
					null_ls.builtins.formatting.gofmt,
					-- terraform
					null_ls.builtins.formatting.terraform_fmt,
					-- packer
					null_ls.builtins.formatting.packer,
				},
			})
		end,
	},
	-- neovim lua
	{
		"folke/neodev.nvim",
		tag = "v2.5.2",
	},

	-- typescript / javascript
	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		commit = "829b5dc4f6704b249624e5157ad094dcb20cdc6b",
		opts = {},
		build = function()
			-- install language server with mason
			require("mason.api.command").MasonInstall("typescript-language-server")
		end,
	},
	-- flutter / dart
	{
		"akinsho/flutter-tools.nvim",
		lazy = true,
		ft = {
        "dart",
    },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	}
}
