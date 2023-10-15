--
-- dotfiles
-- Neovim config
-- Plugins
--

-- load lazy plugin manager
local has_lazy, lazy = pcall(require, "lazy")
local lazy_dir = vim.fn.stdpath("data") .. "/site/pack/lazy/start/lazy"
if not has_lazy then
	-- download & install lazy.nvim plugin manager if not already installed
	-- requires git >= 2.19.0 to be installed on the system
	vim.fn.system({
		-- partial clone with no blobs to speed up clone
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazy_dir,
	})
end

-- Plugin Specification
local obsidian_vault_dir = vim.fn.expand("~/notepad")

lazy.setup({
	{ import = "plugins.editor" },
	{ import = "plugins.navigation" },
	{ import = "plugins.language" },
	{ import = "plugins.completion" },
	{ import = "plugins.execution" },

	-- UX
	-- syntax highlighting
	"sheerun/vim-polyglot",
	-- colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		tag = "1.0.0",
		config = function(_)
			require("gruvbox").setup({
				inverse = true,
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

	-- Obsidian notes
	{
		"epwalsh/obsidian.nvim",
		-- lazy load plugin only when opening a note from vault
		lazy = true,
		event = {
			"BufReadPre " .. obsidian_vault_dir .. "**/*.md",
			"BufNewFile " .. obsidian_vault_dir .. "**/*.md",
		},
		tag = "v1.14.2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_)
			local obsidian = require("obsidian")
			obsidian.setup({
				dir = obsidian_vault_dir,
				disable_frontmatter = true,
				daily_notes = {
					folder = "journal",
				},
				-- autocomplete wikilinks
				completion = {
					nvim_cmp = true,
				},
				-- disable automatic mappings
				mappings = {},
			})
			-- key bindings
			local map = vim.keymap.set
			map({ "n" }, "<leader>o[", ":ObsidianBacklinks<CR>", {})
			map({ "n" }, "<leader>oo", ":ObsidianOpen<CR>", {})
			map({ "n" }, "<leader>oj", ":ObsidianToday<CR>", {})
			-- override 'gf' for navigating wikilinks navigation
			map({ "n" }, "gf", obsidian.util.gf_passthrough, { noremap = false, expr = true })
		end,
	},

	-- Common utilities shared by plugins
	{ "nvim-lua/plenary.nvim", tag = "v0.1.3" },
})
