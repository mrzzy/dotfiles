-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/mrzzy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/mrzzy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/mrzzy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/mrzzy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/mrzzy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\nO\0\1\4\0\3\0\0066\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\1K\0\1\0\14lazy_load\"luasnip.loaders.from_snipmate\frequire\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  fzf = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\2\nÜ\2\0\0\a\0\22\0.6\0\0\0009\0\1\0009\0\2\0\18\1\0\0005\3\3\0'\4\4\0'\5\5\0004\6\0\0B\1\5\1\18\1\0\0005\3\6\0'\4\a\0'\5\b\0004\6\0\0B\1\5\1\18\1\0\0005\3\t\0'\4\n\0'\5\v\0004\6\0\0B\1\5\1\18\1\0\0005\3\f\0'\4\r\0'\5\v\0004\6\0\0B\1\5\1\18\1\0\0005\3\14\0'\4\15\0'\5\16\0004\6\0\0B\1\5\1\18\1\0\0005\3\17\0'\4\18\0'\5\19\0004\6\0\0B\1\5\1\18\1\0\0005\3\20\0'\4\21\0'\5\19\0004\6\0\0B\1\5\1K\0\1\0\n<M-/>\1\2\0\0\6n\f:Rg<CR>\n<C-_>\1\2\0\0\6n\17:Buffers<CR>\14<C-Space>\1\2\0\0\6n\n<M-t>\1\2\0\0\6n\14:Tags<CR>\n<C-t>\1\2\0\0\6n\16:GFiles<CR>\n<C-p>\1\2\0\0\6n\15:Files<CR>\n<M-p>\1\2\0\0\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gruvbox-material"] = {
    config = { "\27LJ\2\nu\0\0\3\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0!colorscheme gruvbox-material\bcmd\vmedium gruvbox_material_background\6g\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    config = { "\27LJ\2\nW\0\1\4\0\4\0\v6\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\0016\1\0\0'\3\3\0B\1\2\0029\1\2\1B\1\1\1K\0\1\0\20mason-lspconfig\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n9\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n\29\0\1\2\0\1\0\0029\1\0\0L\1\2\0\18absolute_pathx\1\0\a\1\t\0\0156\0\0\0009\0\1\0009\0\2\0-\2\0\0009\2\3\0026\4\4\0'\6\5\0B\4\2\0029\4\6\0049\4\a\4B\4\1\0023\5\b\0B\2\3\0A\0\0\1K\0\1\0\0\0\0\tlist\nmarks\18nvim-tree.api\frequire\bmap\targs\bcmd\bvimí\4\1\0\a\1\29\0.6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\16\0005\3\14\0005\4\f\0005\5\a\0005\6\b\0=\6\t\0055\6\n\0=\6\v\5=\5\r\4=\4\15\3=\3\17\2B\0\2\0016\0\0\0009\0\18\0009\0\19\0\18\1\0\0005\3\20\0'\4\21\0'\5\22\0004\6\0\0B\1\5\1\18\1\0\0005\3\23\0'\4\24\0'\5\25\0004\6\0\0B\1\5\1\18\1\0\0005\3\26\0'\4\27\0003\5\28\0004\6\0\0B\1\5\1K\0\1\0\0\0\0\15<leader>fa\1\2\0\0\6n\26:NvimTreeFindFile<CR>\15<leader>f.\1\2\0\0\6n\24:NvimTreeToggle<CR>\15<leader>ff\1\2\0\0\6n\bset\vkeymap\rrenderer\1\0\0\nicons\1\0\0\vglyphs\1\0\0\bgit\1\0\a\vstaged\6S\fdeleted\6D\runstaged\6U\14untracked\6?\frenamed\bâ‡’\runmerged\bâ†”\fignored\6I\vfolder\1\0\b\fdefault\6/\17arrow_closed\bâ–·\nempty\5\17symlink_open\5\15empty_open\5\topen\6/\fsymlink\5\15arrow_open\bâ–¼\1\0\4\rbookmark\6M\rmodified\6+\fsymlink\6~\fdefault\6.\nsetup\14nvim-tree\frequire\23loaded_netrwPlugin\17loaded_netrw\6g\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["obsidian.nvim"] = {
    config = { "\27LJ\2\nˆ\1\0\1\4\0\6\0\0146\1\0\0'\3\1\0B\1\2\0029\1\2\0019\1\3\1B\1\1\2\15\0\1\0X\2\3€'\1\4\0L\1\2\0X\1\2€'\1\5\0L\1\2\0K\0\1\0\agf\28:ObsidianFollowLink<CR>\28cursor_on_markdown_link\tutil\robsidian\frequire¬\3\1\0\a\0\24\0&6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0\18\1\0\0005\3\v\0'\4\f\0'\5\r\0004\6\0\0B\1\5\1\18\1\0\0005\3\14\0'\4\15\0'\5\16\0004\6\0\0B\1\5\1\18\1\0\0005\3\17\0'\4\18\0'\5\19\0004\6\0\0B\1\5\1\18\1\0\0005\3\20\0'\4\21\0003\5\22\0005\6\23\0B\1\5\1K\0\1\0\1\0\2\texpr\2\fnoremap\1\0\agf\1\2\0\0\6n\23:ObsidianToday<CR>\15<leader>oj\1\2\0\0\6n\22:ObsidianOpen<CR>\15<leader>oo\1\2\0\0\6n\27:ObsidianBacklinks<CR>\15<leader>o[\1\2\0\0\6n\bset\vkeymap\bvim\15completion\1\0\1\rnvim_cmp\2\16daily_notes\1\0\1\vfolder\fjournal\1\0\2\24disable_frontmatter\2\bdir\14~/notepad\nsetup\robsidian\frequire\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/obsidian.nvim",
    url = "https://github.com/epwalsh/obsidian.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  undotree = {
    config = { "\27LJ\2\n_\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\24:UndotreeToggle<CR>\15<leader>uu\1\2\0\0\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n^\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\22<Plug>(EasyAlign)\14<leader>=\1\3\0\0\6n\6x\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\nT\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\r:Git<CR>\15<leader>vv\1\2\0\0\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gutentags"] = {
    config = { "\27LJ\2\n3\0\1\3\0\3\0\0056\1\0\0009\1\1\1+\2\1\0=\2\2\1K\0\1\0\22gutentags_enabled\6g\bvimª\2\1\0\6\0\16\0\0266\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0005\3\a\0B\0\3\0026\1\0\0009\1\4\0019\1\b\0015\3\t\0005\4\n\0=\0\v\0045\5\f\0=\5\r\0043\5\14\0=\5\15\4B\1\3\1K\0\1\0\rcallback\0\fpattern\1\3\0\0\14gitcommit\14gitrebase\ngroup\1\0\0\1\2\0\0\rFileType\24nvim_create_autocmd\1\0\1\nclear\2\14gutentags\24nvim_create_augroup\bapi'gutentags_define_advanced_commands\22gutentags_enabled\6g\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-obsession"] = {
    config = { "\27LJ\2\nV\0\1\a\0\6\0\t6\1\0\0009\1\1\0019\1\2\0015\3\3\0'\4\4\0'\5\5\0004\6\0\0B\1\5\1K\0\1\0\15:Obsession\15<leader>ws\1\2\0\0\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  winresizer = {
    config = { "\27LJ\2\nD\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\18<leader>w<CR>\25winresizer_start_key\6g\bvim\0" },
    loaded = true,
    path = "/home/mrzzy/.local/share/nvim/site/pack/packer/start/winresizer",
    url = "https://github.com/simeji/winresizer"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: vim-gutentags
time([[Config for vim-gutentags]], true)
try_loadstring("\27LJ\2\n3\0\1\3\0\3\0\0056\1\0\0009\1\1\1+\2\1\0=\2\2\1K\0\1\0\22gutentags_enabled\6g\bvimª\2\1\0\6\0\16\0\0266\0\0\0009\0\1\0+\1\1\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0005\3\a\0B\0\3\0026\1\0\0009\1\4\0019\1\b\0015\3\t\0005\4\n\0=\0\v\0045\5\f\0=\5\r\0043\5\14\0=\5\15\4B\1\3\1K\0\1\0\rcallback\0\fpattern\1\3\0\0\14gitcommit\14gitrebase\ngroup\1\0\0\1\2\0\0\rFileType\24nvim_create_autocmd\1\0\1\nclear\2\14gutentags\24nvim_create_augroup\bapi'gutentags_define_advanced_commands\22gutentags_enabled\6g\bvim\0", "config", "vim-gutentags")
time([[Config for vim-gutentags]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\n_\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\24:UndotreeToggle<CR>\15<leader>uu\1\2\0\0\6n\bset\vkeymap\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: mason-lspconfig.nvim
time([[Config for mason-lspconfig.nvim]], true)
try_loadstring("\27LJ\2\nW\0\1\4\0\4\0\v6\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\0016\1\0\0'\3\3\0B\1\2\0029\1\2\1B\1\1\1K\0\1\0\20mason-lspconfig\nsetup\nmason\frequire\0", "config", "mason-lspconfig.nvim")
time([[Config for mason-lspconfig.nvim]], false)
-- Config for: obsidian.nvim
time([[Config for obsidian.nvim]], true)
try_loadstring("\27LJ\2\nˆ\1\0\1\4\0\6\0\0146\1\0\0'\3\1\0B\1\2\0029\1\2\0019\1\3\1B\1\1\2\15\0\1\0X\2\3€'\1\4\0L\1\2\0X\1\2€'\1\5\0L\1\2\0K\0\1\0\agf\28:ObsidianFollowLink<CR>\28cursor_on_markdown_link\tutil\robsidian\frequire¬\3\1\0\a\0\24\0&6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0\18\1\0\0005\3\v\0'\4\f\0'\5\r\0004\6\0\0B\1\5\1\18\1\0\0005\3\14\0'\4\15\0'\5\16\0004\6\0\0B\1\5\1\18\1\0\0005\3\17\0'\4\18\0'\5\19\0004\6\0\0B\1\5\1\18\1\0\0005\3\20\0'\4\21\0003\5\22\0005\6\23\0B\1\5\1K\0\1\0\1\0\2\texpr\2\fnoremap\1\0\agf\1\2\0\0\6n\23:ObsidianToday<CR>\15<leader>oj\1\2\0\0\6n\22:ObsidianOpen<CR>\15<leader>oo\1\2\0\0\6n\27:ObsidianBacklinks<CR>\15<leader>o[\1\2\0\0\6n\bset\vkeymap\bvim\15completion\1\0\1\rnvim_cmp\2\16daily_notes\1\0\1\vfolder\fjournal\1\0\2\24disable_frontmatter\2\bdir\14~/notepad\nsetup\robsidian\frequire\0", "config", "obsidian.nvim")
time([[Config for obsidian.nvim]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
try_loadstring("\27LJ\2\nÜ\2\0\0\a\0\22\0.6\0\0\0009\0\1\0009\0\2\0\18\1\0\0005\3\3\0'\4\4\0'\5\5\0004\6\0\0B\1\5\1\18\1\0\0005\3\6\0'\4\a\0'\5\b\0004\6\0\0B\1\5\1\18\1\0\0005\3\t\0'\4\n\0'\5\v\0004\6\0\0B\1\5\1\18\1\0\0005\3\f\0'\4\r\0'\5\v\0004\6\0\0B\1\5\1\18\1\0\0005\3\14\0'\4\15\0'\5\16\0004\6\0\0B\1\5\1\18\1\0\0005\3\17\0'\4\18\0'\5\19\0004\6\0\0B\1\5\1\18\1\0\0005\3\20\0'\4\21\0'\5\19\0004\6\0\0B\1\5\1K\0\1\0\n<M-/>\1\2\0\0\6n\f:Rg<CR>\n<C-_>\1\2\0\0\6n\17:Buffers<CR>\14<C-Space>\1\2\0\0\6n\n<M-t>\1\2\0\0\6n\14:Tags<CR>\n<C-t>\1\2\0\0\6n\16:GFiles<CR>\n<C-p>\1\2\0\0\6n\15:Files<CR>\n<M-p>\1\2\0\0\6n\bset\vkeymap\bvim\0", "config", "fzf.vim")
time([[Config for fzf.vim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: gruvbox-material
time([[Config for gruvbox-material]], true)
try_loadstring("\27LJ\2\nu\0\0\3\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0'\2\5\0B\0\2\1K\0\1\0!colorscheme gruvbox-material\bcmd\vmedium gruvbox_material_background\6g\bvim\0", "config", "gruvbox-material")
time([[Config for gruvbox-material]], false)
-- Config for: winresizer
time([[Config for winresizer]], true)
try_loadstring("\27LJ\2\nD\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\18<leader>w<CR>\25winresizer_start_key\6g\bvim\0", "config", "winresizer")
time([[Config for winresizer]], false)
-- Config for: vim-obsession
time([[Config for vim-obsession]], true)
try_loadstring("\27LJ\2\nV\0\1\a\0\6\0\t6\1\0\0009\1\1\0019\1\2\0015\3\3\0'\4\4\0'\5\5\0004\6\0\0B\1\5\1K\0\1\0\15:Obsession\15<leader>ws\1\2\0\0\6n\bset\vkeymap\bvim\0", "config", "vim-obsession")
time([[Config for vim-obsession]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nO\0\1\4\0\3\0\0066\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\1K\0\1\0\14lazy_load\"luasnip.loaders.from_snipmate\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\n^\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\22<Plug>(EasyAlign)\14<leader>=\1\3\0\0\6n\6x\bset\vkeymap\bvim\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n\29\0\1\2\0\1\0\0029\1\0\0L\1\2\0\18absolute_pathx\1\0\a\1\t\0\0156\0\0\0009\0\1\0009\0\2\0-\2\0\0009\2\3\0026\4\4\0'\6\5\0B\4\2\0029\4\6\0049\4\a\4B\4\1\0023\5\b\0B\2\3\0A\0\0\1K\0\1\0\0\0\0\tlist\nmarks\18nvim-tree.api\frequire\bmap\targs\bcmd\bvimí\4\1\0\a\1\29\0.6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\16\0005\3\14\0005\4\f\0005\5\a\0005\6\b\0=\6\t\0055\6\n\0=\6\v\5=\5\r\4=\4\15\3=\3\17\2B\0\2\0016\0\0\0009\0\18\0009\0\19\0\18\1\0\0005\3\20\0'\4\21\0'\5\22\0004\6\0\0B\1\5\1\18\1\0\0005\3\23\0'\4\24\0'\5\25\0004\6\0\0B\1\5\1\18\1\0\0005\3\26\0'\4\27\0003\5\28\0004\6\0\0B\1\5\1K\0\1\0\0\0\0\15<leader>fa\1\2\0\0\6n\26:NvimTreeFindFile<CR>\15<leader>f.\1\2\0\0\6n\24:NvimTreeToggle<CR>\15<leader>ff\1\2\0\0\6n\bset\vkeymap\rrenderer\1\0\0\nicons\1\0\0\vglyphs\1\0\0\bgit\1\0\a\vstaged\6S\fdeleted\6D\runstaged\6U\14untracked\6?\frenamed\bâ‡’\runmerged\bâ†”\fignored\6I\vfolder\1\0\b\fdefault\6/\17arrow_closed\bâ–·\nempty\5\17symlink_open\5\15empty_open\5\topen\6/\fsymlink\5\15arrow_open\bâ–¼\1\0\4\rbookmark\6M\rmodified\6+\fsymlink\6~\fdefault\6.\nsetup\14nvim-tree\frequire\23loaded_netrwPlugin\17loaded_netrw\6g\bvim\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\nT\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0005\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\r:Git<CR>\15<leader>vv\1\2\0\0\6n\bset\vkeymap\bvim\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
