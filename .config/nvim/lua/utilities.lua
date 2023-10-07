--
-- dotfiles
-- Neovim config
-- Utilities
--

local M = {}

-- Whether the given buffer is considered to be large (> 100KB)
-- Large buffers should be exempted from expensive operations for performance
-- (eg. treesitter indexing, buffer completion).
function M.is_large(buf)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

return M
