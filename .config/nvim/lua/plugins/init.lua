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
lazy.setup({
	-- Common utilities shared by plugins
	{ "nvim-lua/plenary.nvim",      tag = "v0.1.3" },
	{ import = "plugins.editor" },
	{ import = "plugins.navigation" },
	{ import = "plugins.language" },
	{ import = "plugins.completion" },
	{ import = "plugins.execution" },
})
