--
-- dotfiles
-- Neovim config
-- Editor Plugins
--

return {
	-- Editor
	-- text editing
	{ "tpope/vim-repeat",     commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" },
	{ "tpope/vim-surround",   commit = "9857a874632d1b983a7f4b1c85e3d15990c8b101" },
	-- multi-subsitute command
	{ "tpope/vim-abolish",    commit = "3f0c8faadf0c5b68bcf40785c1c42e3731bfa522" },
	-- sensible key bindings
	{ "tpope/vim-unimpaired", commit = "f992923d336e93c7f50fe9b35a07d5a92660ecaf" },
	-- editor sessions
	{
		"tpope/vim-obsession",
		commit = "d2818a614ec3a5d174c6bb19e87e2eeb207f4900",
		config = function(_)
			vim.keymap.set({ "n" }, "<leader>ss", ":Obsession<cr>", {})
		end,
	},
	-- auto alignment
	{
		"junegunn/vim-easy-align",
		commit = "9815a55dbcd817784458df7a18acacc6f82b1241",
		config = function()
			vim.keymap.set({ "n", "x" }, "<leader>=", "<Plug>(LiveEasyAlign)", {})
		end,
	},
	-- undo history
	{
		"mbbill/undotree",
		tag = "rel_6.1",
		config = function()
			vim.keymap.set({ "n" }, "<leader>uu", ":UndotreeToggle<CR>", {})
		end,
	},
	-- window management
	{
		"simeji/winresizer",
		init = function()
			vim.g.winresizer_start_key = "<leader>w<CR>"
		end,
	},
	-- git integration
	{
		"tpope/vim-fugitive",
		tag = "v3.6",
		config = function()
			vim.keymap.set({ "n" }, "<leader>vv", ":Git<CR>", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		tag = "v0.6",
		config = function()
			-- annotate line numbers based on git status
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signcolumn = false,
				numhl = true,
			})
			-- keybindings to jump to changes
			local map = vim.keymap.set
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })
			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })
			-- keybinding stage hunk
			map("n", "<leader>vs", gitsigns.stage_hunk)
		end,
	},
	-- commenting code
	{
		"numToStr/Comment.nvim",
		tag = "v0.7.0",
		config = function()
			require("Comment").setup()
		end,
	},
	-- markdown viewer
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_echo_preview_url = 1
		end,
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- syntax highlighting
	"sheerun/vim-polyglot",
	-- colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		tag = "2.0.0",
		config = function(_)
			local gruvbox = require("gruvbox")
			gruvbox.setup({
				inverse = true,
				overrides = {
					-- override difftext highlighting for legibility
					DiffText = {
						-- disable default yellow highlight on difflines
						bg = "",
						reverse = true,
					}
				}
			})
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	-- indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.2",
		dependencies = { { "ellisonleao/gruvbox.nvim" } },
		config = function()
			require("indent_blankline").setup({})
		end,
	},
}
