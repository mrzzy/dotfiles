--
-- dotfiles
-- Neovim config
-- JVM Language Support
--

-- java
local nvim_jdtls = {
	"mfussenegger/nvim-jdtls",
	version = "2f7bff9b8d2ee1918b36ca55f19547d9d335a268",
	dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
	lazy = true,
	ft = { "java" },
	config = function(_)
		local jdtls = require("jdtls")
		-- autocommand group to start jdtls in java filetypes
		vim.api.nvim_create_autocmd({ "FileType" }, {
			group = vim.api.nvim_create_augroup("nvim-jdtls", { clear = true }),
			pattern = { "java" },
			callback = function(_)
				local install_path = require("utilities").mason_install_path

				-- locate debug adapters jars installed by mason
				local function find_jars(pkg)
					return vim.fn.glob(install_path(pkg) .. "/extension/server/*.jar", false, true)
				end
				local bundles = {}
				vim.list_extend(bundles, find_jars("java-debug-adapter"))
				vim.list_extend(bundles, find_jars("java-test"))
				jdtls.start_or_attach({
					-- use jdtls installed by mason
					cmd = {
						install_path("jdtls") .. "/bin/jdtls",
					},
					-- register debug adapter jars needed for nvim-dap debugging
					init_options = {
						bundles = bundles,
					},
					on_attach = function(_, _)
						-- enable nvim-jdtls's nvim-dap debugger integration
						jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
					end,
				})
			end
		})
		-- key binding to debug nearest test case / class
		vim.keymap.set({ "n" }, "<leader>dt", jdtls.test_nearest_method, { buffer = true })
		vim.keymap.set({ "n" }, "<leader>dT", jdtls.test_class, { buffer = true })
	end,
}

-- scala
local metals_config = {
	on_attach = function(_)
		require("metals").setup_dap()

		-- default dap debug configuration for scala
		require("dap").configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "Run or Test Target",
				metals = {
					runType = "runOrTestFile",
				},
			},
		}

		-- key binding to debug test case
		-- nvim-metals registers debug test case as code lenses
		vim.keymap.set({ "n" }, "<leader>dt", vim.lsp.codelens.run, { buffer = true })
	end,
}
local nvim_metals = {
	"scalameta/nvim-metals",
	dependencies = { "mfussenegger/nvim-dap" },
	commit = "0a83e0bfd45ab745ea35757b117a080560e8640e",
	lazy = true,
	ft = { "scala", "sbt" },
	-- install metals language server
	build = function(_)
		local config = require("metals.config")
		-- validate_config() fills in missing config values
		-- 0: special value to refer to current buffer
		local full_config = config.validate_config(metals_config, 0)
		config.set_config_cache(full_config)
		require("metals").install()
	end,
	config = function(_)
		require("metals").initialize_or_attach(metals_config)
	end,
}

return {
	nvim_jdtls,
	nvim_metals,
}
