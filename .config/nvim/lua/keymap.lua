--
-- dotfiles
-- Neovim config
-- keymaps
--

-- Maps LHS key to RHS in the given modes & optional map options opts
local function map(modes, lhs, rhs, opts) 
  opts = opts or {}
  -- allow one mode to be passed as atomic string, multiple modes as table
  for i,mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

return {
  map=map
}
