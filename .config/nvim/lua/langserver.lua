--
-- dotfiles
-- Neovim config
-- Language Servers
--

local M = {}

-- LSPConfig Language servers providing completion support & their custom setup functions.
-- Each setup function returns a table that is passed to the lspconfig's setup()
local noop = function()
	return {}
end
M.language_servers = {
	-- lua
	["lua_ls"] = function()
		-- setup vim lua api completion, must be done before lspconfig setup of lua lsp
		require("neodev").setup({})

		return {
			settings = {
				Lua = {
					runtime = {
						-- neovim uses luajit for its lua language version
						version = "LuaJIT",
					},
					diagnostics = {
						-- silence undefined global 'vim' neovim lua config.
						globals = { "vim" },
					},
					workspace = {
						-- make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						-- disable prompts to configure work environment
						checkThirdParty = false,
					},
					-- disable telemetry
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end,
	-- terraform
	["terraformls"] = noop,
	-- docker
	["dockerls"] = noop,
	-- bash
	["bashls"] = noop,
	-- python
	["pyright"] = noop,
	-- golang
	-- TODO(mrzzy): remove version peg once golang is updated
	["gopls@v0.14.2"] = noop,
	-- yaml
	["yamlls"] = function()
		return {
			settings = {
				yaml = {
					keyOrdering = false,
				},
			},
		}
	end,
	-- html
	["html"] = function()
		return {
			on_attach = function(client, _)
				-- disable diagnostics as html lsp does not support diagnostics
				client.server_capabilities.diagnosticProvider = false
			end
		}
	end,
	-- ansible
	["ansiblels"] = noop,
	-- rust
	["rust_analyzer"] = noop,
	-- c/c++
	["clangd"] = function()
		-- clangd needs to query native gcc compiler for build config
		return {
			cmd = { "clangd", "--query-driver=/usr/bin/*" },
		}
	end,
	-- latex
	["texlab"] = function()
		-- configure texlab to use tectonic
		-- https://github.com/latex-lsp/texlab/wiki/Tectonic
		return {
			settings = {
				texlab = {
					build = {
						executable = "tectonic",
						args = {
							"-X",
							"compile",
							"%f",
							"--synctex",
							"--keep-logs",
							"--keep-intermediates",
						},
					},
				},
			},
		}
	end,
	-- Astro
	["astro"] = noop,
}

-- Mason Install ignore list assume LSP preinstalled in system
M.mason_ignore = { ["clangd"] = true }

-- Install language servers
function M.install()
	local map_package = require("mason-lspconfig.mappings.server").lspconfig_to_package
	-- convert lsp server name to mason naming scheme
	local mason_servers = {}
	for server, _ in pairs(require("langserver").language_servers) do
		-- only install servers supported by mason
		if map_package[server] ~= nil and not M.mason_ignore[server] then
			table.insert(mason_servers, map_package[server])
		end
	end
	-- additional language servers installed by mason but not configured by lspconfig
	table.insert(mason_servers, map_package["jdtls"])

	-- install language servers with mason
	require("mason.api.command").MasonInstall(mason_servers)
end

-- Setup LSPConfig language servers
function M.setup_lsp()
	local lsp = require("lspconfig")
	-- add additional LSP capabilities supported by nvim-cmp
	lsp.util.default_config = vim.tbl_extend("force", lsp.util.default_config, {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})
	-- configure language servers
	for server, setup_fn in pairs(require("langserver").language_servers) do
		-- remove version (if exists) from server name
		local name = string.gsub(server, "([^@]+)@?.*", "%1")
		lsp[name].setup(setup_fn())
	end
end

return M
