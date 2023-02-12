--
-- dotfiles
-- Neovim config
-- Functional Primitives
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

return M
