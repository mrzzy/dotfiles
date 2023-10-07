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
		"--branch=v10.7.0",
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

	-- Colors
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

	-- Obsidian notes
	{
		"epwalsh/obsidian.nvim",
		-- lazy load plugin only when opening a note from vault
		lazy = true,
		event = {
			"BufReadPre " .. obsidian_vault_dir,
			"BufNewFile " .. obsidian_vault_dir,
		},
		tag = "v1.7.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_)
			require("obsidian").setup({
				dir = obsidian_vault_dir,
				disable_frontmatter = true,
				daily_notes = {
					folder = "journal",
				},
				-- autocomplete wikilinks
				completion = {
					nvim_cmp = true,
				},
			})
			-- key bindings
			local map = vim.keymap.set
			map({ "n" }, "<leader>o[", ":ObsidianBacklinks<CR>", {})
			map({ "n" }, "<leader>oo", ":ObsidianOpen<CR>", {})
			map({ "n" }, "<leader>oj", ":ObsidianToday<CR>", {})
			-- override 'gf' for navigating wikilinks navigation
			map({ "n" }, "gf", function(_)
				if require("obsidian").util.cursor_on_markdown_link() then
					return ":ObsidianFollowLink<CR>"
				else
					return "gf"
				end
			end, { noremap = false, expr = true })
		end,
	},

	-- Common utilities shared by plugins
	{ "nvim-lua/plenary.nvim", tag = "v0.1.3" },
})
