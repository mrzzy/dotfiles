--
-- dotfiles
-- Neovim config
-- Language Support: Treesitter
--

return {
	-- treesitter: syntax tree
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "4916d6592ede8c07973490d9322f187e07dfefac",
		build = function()
			-- install or upgrade treesitter parsers
			local ts = require("nvim-treesitter.install")
			ts.update({ with_sync = true })({
				"python",
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"go",
				"rust",
				"java",
				"scala",
				"bash",
				"cpp",
				"css",
				"html",
				"javascript",
				"typescript",
				"dockerfile",
				"latex",
				"lua",
				"make",
				"cmake",
				"sql",
				"proto",
				"yaml",
				"verilog",
				"astro",
			})
		end,
		config = function()
			require("nvim-treesitter.config").setup({
				-- auto install parsers when opening a buffer without one
				auto_install = true,
				-- use treesitter for '=' auto indent
				indent = {
					enabled = true,
				},
				-- use treesitter for syntax highlighting
				highlight = {
					enabled = true,
					-- disable on large files
					disable = function(_, buf)
						return require("utilities").is_large(buf)
					end,
				},
				-- treesitter's incremental selection based on syntax nodes
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>v",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
			})
			-- use treesitter for code folding
			vim.o.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},
}
