--
-- dotfiles
-- Neovim config
-- JVM Language Support
--

-- java
local nvim_java = {
  'nvim-java/nvim-java',
  dependencies = {
    {
      'JavaHello/spring-boot.nvim',
      commit = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
    },
    'MunifTanjim/nui.nvim',
    'mfussenegger/nvim-dap',
    'nvim-java/nvim-java',
  },
  tag = 'v4.1.2',
  config = function()
    require('java').setup()
    vim.lsp.enable('jdtls')
    end,
  lazy = true,
  ft = { "java" },
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
	nvim_java,
	nvim_metals,
}
