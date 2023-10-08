--
-- dotfiles
-- Neovim config
-- Navigation Plugins
--

return {
	-- fuzzy navigation
	{
		"ibhagwan/fzf-lua",
		commit = "446429138a841b45a2a7743cc08d7bc17493e7c8",
		config = function()
			local fzf = require("fzf-lua")
			local map = vim.keymap.set
			-- file navigation
			map({ "n" }, "<C-p>", fzf.files, {})
			map({ "n" }, "<M-p>", fzf.files, {})
			map({ "n" }, "<C-n>", fzf.args, {})
			map({ "n" }, "<M-n>", fzf.args, {})
			map({ "n" }, "<C-Space>", fzf.buffers, {})
			map({ "n" }, "<M-Space>", fzf.buffers, {})
			-- tag navigation
			map({ "n" }, "<C-t>", fzf.tags_live_grep, {})
			map({ "n" }, "<M-t>", fzf.tags_live_grep, {})
			-- lsp navigation
			map({ "n" }, "<C-j>", fzf.lsp_document_symbols, {})
			map({ "n" }, "<M-j>", fzf.lsp_document_symbols, {})
			map({ "n" }, "<C-k>", fzf.lsp_live_workspace_symbols, {})
			map({ "n" }, "<M-k>", fzf.lsp_live_workspace_symbols, {})
			-- grep search
			-- <C-_> key is received by nvim when user presses <C-/>
			map({ "n" }, "<C-_>", fzf.live_grep_native, {})
			map({ "n" }, "<M-/>", fzf.live_grep_native, {})
			-- git
			map({ "n" }, "<C-g>", fzf.git_branches, {})
			map({ "n" }, "<M-g>", fzf.git_branches, {})
			map({ "n" }, "<C-s>", fzf.git_stash, {})
			map({ "n" }, "<M-s>", fzf.git_stash, {})
			-- pasting registers
			map({ "n" }, "<C-c>", fzf.registers, {})
			map({ "n" }, "<M-c>", fzf.registers, {})

			-- register fzf.lua as ui picker for vim.ui.select()
			-- improves ux when nvim prompts for user input (eg. lsp code action)
			fzf.register_ui_select()
		end,
	},

	-- tag file manager
	{
		"ludovicchabant/vim-gutentags",
		commit = "b77b8fabcb0b052c32fe17efcc0d44f020975244",
		config = function()
			-- disable gutentags by default, unless toggled on explicitly
			vim.g.gutentags_enabled = false
			vim.g.gutentags_define_advanced_commands = true
			-- key binding to toggle gutentags
			vim.keymap.set({ "n" }, "<leader>gt", function()
				vim.g.gutentags_enabled = not vim.g.gutentags_enabled
				print("Gutentags: " .. (vim.g.gutentags_enabled and "Enabled" or "Disabled"))
			end)
			-- disable gutentags for git commit as they do not does not play well together
			-- clear any existing autocmds to prevent autocmd spam
			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = vim.api.nvim_create_augroup("gutentags", { clear = true }),
				pattern = { "gitcommit", "gitrebase" },
				callback = function(_)
					vim.b.gutentags_enabled = false
				end,
			})
		end,
	},
	-- project specific file navigation
	{
		"tpope/vim-projectionist",
		commit = "d4aee3035699b82b3789cee0e88dad0e38c423ab",
	},
	-- file drawer
	{
		"nvim-tree/nvim-tree.lua",
		commit = "59e65d88db177ad1e6a8cffaafd4738420ad20b6",
		config = function()
			-- override special glyphs used in nvim-tree that require font support
			require("nvim-tree").setup({
				renderer = {
					icons = {
						glyphs = {
							default = ".",
							symlink = "~",
							modified = "+",
							bookmark = "M",
							folder = {
								arrow_closed = "▷",
								arrow_open = "▼",
								default = "/",
								open = "/",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "U",
								staged = "S",
								unmerged = "↔",
								renamed = "⇒",
								untracked = "?",
								deleted = "D",
								ignored = "I",
							},
						},
					},
				},
			})
			-- define key bindings
			local map = vim.keymap.set
			map({ "n" }, "<leader>ff", ":NvimTreeToggle<CR>", {})
			map({ "n" }, "<leader>f.", ":NvimTreeFindFile<CR>", {})
			map({ "n" }, "<leader>fa", function()
				-- populate arglist with bookmarked files
				vim.cmd.args(vim.tbl_map(function(node)
					return node.absolute_path
				end, require("nvim-tree.api").marks.list()))
			end, {})
		end,
	},
}
