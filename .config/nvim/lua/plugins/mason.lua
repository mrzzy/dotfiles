--
-- dotfiles
-- Neovim config
-- Mason Utilities
--

local mason = {}

-- Get the installation path of the mason package with given name
function mason.install_path(package)
  return require("mason-registry").get_package(package):get_install_path()
end

return mason
