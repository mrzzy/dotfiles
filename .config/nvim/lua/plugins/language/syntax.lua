--
-- dotfiles
-- Neovim config
-- Language Support: Syntax
--

return {
	-- neovim lua
	{
		"folke/neodev.nvim",
		tag = "v2.5.2",
	},

	-- treesitter: syntax tree
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.0",
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
			})
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
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
	-- treesitter textobjects selection & navigation
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- automatically jump forward to textobjects
						lookahead = true,
						-- mappings for textobjects
						keymaps = {
							["am"] = "@function.outer",
							["im"] = "@function.inner",
							["a]"] = "@class.outer",
							["i]"] = "@class.inner",
							["a<TAB>"] = "@block.outer",
							["i<TAB>"] = "@block.inner",
							["a,"] = "@parameter.outer",
							["i,"] = "@parameter.inner",
							["a/"] = "@comment.outer",
							["i/"] = "@comment.inner",
						},
					},
					move = {
						enable = true,
						-- whether to set jumps in the jumplist
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
							["]<TAB>"] = "@block.inner",
							["],"] = "@parameter.inner",
							["]/"] = "@comment.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]}"] = "@class.outer",
							["]<CR>"] = "@block.inner",
							["]<"] = "@parameter.inner",
							["]?"] = "@comment.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
							["[<TAB>"] = "@block.inner",
							["[,"] = "@parameter.inner",
							["[/"] = "@comment.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[}"] = "@class.outer",
							["[<CR>"] = "@block.inner",
							["[<"] = "@parameter.inner",
							["[?"] = "@comment.outer",
						},
					},
				},
			})

			-- key bindings
			-- repeat movement with ; and ,
			local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_opposite)
			-- make builtin f, F, t, T also repeatable with ; and ,
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f)
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F)
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t)
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T)
		end,
	},
}
