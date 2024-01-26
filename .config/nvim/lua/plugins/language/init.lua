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
		tag = "v1.9.0",
		build = require("debugadaptor").install,
		config = function()
			require("mason").setup()
		end,
	},

	-- language servers
	{
		"neovim/nvim-lspconfig",
		commit = "9099871a7c7e1c16122e00d70208a2cd02078d80",
	},

	-- Mason - lspconfig integration
	{
		"williamboman/mason-lspconfig.nvim",
		tag = "v1.26.0",
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
	-- neovim lua
	{
		"folke/neodev.nvim",
		tag = "v2.5.2",
	},

	-- typescript / javascript
	{
		"pmizio/typescript-tools.nvim",
		-- ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		commit = "829b5dc4f6704b249624e5157ad094dcb20cdc6b",
		opts = {},
		build = function()
			-- install language server with mason
			require("mason.api.command").MasonInstall("typescript-language-server")
		end,
	}
}
