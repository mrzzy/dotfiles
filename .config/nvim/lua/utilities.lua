--
-- dotfiles
-- Neovim config
-- Utilities
--

local M = {}

-- Map the given 'items' with the given function 'fn'.
-- Returns the collected return values of 'fn'.
function M.map(items, fn)
	local results = {}
	for _, item in ipairs(items) do
		table.insert(results, fn(item))
	end
	return results
end

-- Filter the given 'items' with the given function 'predicate'.
-- Returns a the values in 'items' where 'predicate' evaluated to true.
function M.filter(items, predicate)
	local results = {}
	for _, item in ipairs(items) do
		if predicate(item) then
			table.insert(results, item)
		end
	end
	return results
end

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
