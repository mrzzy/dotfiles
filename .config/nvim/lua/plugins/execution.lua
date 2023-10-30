--
-- dotfiles
-- Neovim config
-- Code Execution Plugins
--

return {
	-- async command dispatch
	{
		"tpope/vim-dispatch",
		commit = "6cc2691576f97d43f8751664d1a1a908b99927e5",
		keys = {
			{"<leader>` ", ":FocusDispatch "},
		},
	},
	-- running code snippets
	{
		"michaelb/sniprun",
		tags = "v1.3.3",
		build = "sh install.sh",
		config = function()
			require("sniprun").setup({
				-- use nvim's builtin luajit to evaluate lua snippets
				selected_interpreters = { "Lua_nvim" },
				display = {
					"Terminal",
					"VirtualTextOk",
				},
			})

			-- sniprun keybindings
			vim.keymap.set({ "n", "v" }, "<leader><cr><cr>", "<Plug>SnipRun")
			vim.keymap.set({ "n" }, "<leader><cr>", "<Plug>SnipRunOperator")
		end,
	},
	-- running tests
	{
		"vim-test/vim-test",
		commit = "08250c56f11cb3460c8a02c8fdb80c8d39c92173",
		config = function()
			-- use vim-dispatch to run tests
			vim.g["test#strategy"] = "dispatch"
			-- test keybindings
			vim.keymap.set({ "n" }, "<leader>tt", ":TestNearest<CR>")
			vim.keymap.set({ "n" }, "<leader>tf", ":TestFile<CR>")
			vim.keymap.set({ "n" }, "<leader>T", ":TestSuite<CR>")
			vim.keymap.set({ "n" }, "<leader>t<CR>", ":TestLast<CR>")
			vim.keymap.set({ "n" }, "<leader>tg", ":TestVisit<CR>")
		end,
	},
}
