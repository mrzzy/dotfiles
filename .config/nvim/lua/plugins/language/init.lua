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
	{ import = "plugins.language.syntax" },

	-- package manager for language servers & debug adaptors
	{
		"williamboman/mason.nvim",
		tag = "v1.8.0",
		build = require("debugadaptor").install,
		config = function()
			require("mason").setup()
		end,
	},

	-- language servers
	{
		"neovim/nvim-lspconfig",
		tag = "v0.1.6",
	},

	-- Mason - lspconfig integration
	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.17.1",
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
	-- null ls: linters, formatters & code actions
	{
		"jose-elias-alvarez/null-ls.nvim",
		commit = "71797bb303ac99a4435592e15068f127970513d7",
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
					-- json
					null_ls.builtins.formatting.jq,
					-- sql
					null_ls.builtins.formatting.sqlfmt,
					-- python
					null_ls.builtins.formatting.black,
					-- go
					null_ls.builtins.formatting.gofmt,
					-- rust
					null_ls.builtins.formatting.rustfmt,
					-- terraform
					null_ls.builtins.formatting.terraform_fmt,
					-- packer
					null_ls.builtins.formatting.packer,
				},
			})
		end,
	},
}
