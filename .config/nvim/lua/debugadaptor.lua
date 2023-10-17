--
-- dotfiles
-- Neovim config
-- Debug Adaptors Plugins
--

local M = {}

-- Debug Adaptors providing debug support via Debug Adaptor Plugins
M.debug_adaptors = {
	"cpptools", -- c,c++,rust
	"debugpy", -- python,
	"delve", -- golang
	"java-debug-adapter", -- java
	"java-test", -- java (tests)
}

-- Install debug adaptors
function M.install()
	local MasonInstall = require("mason.api.command").MasonInstall
	for _, server in ipairs(M.debug_adaptors) do
		MasonInstall({ server })
	end
end

return M
