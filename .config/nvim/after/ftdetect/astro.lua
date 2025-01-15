--
-- dotfiles
-- Neovim config
-- .astro filetype detection
-- 

-- autocmd for nvim to recognize .astro files as astro filetype
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("astro", { clear = true }),
  pattern = { "*.astro" },
  callback = function(_)
    vim.cmd.setfiletype("astro")
  end,
})
