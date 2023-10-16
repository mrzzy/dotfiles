--
-- dotfiles
-- Neovim config
-- Debug Adaptors Plugins
--

return {
	{
		"mfussenegger/nvim-dap",
		tag = "0.6.0",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local d = require("dap")
			local dap_widgets = require("dap.ui.widgets")
			local install_path = require("utilities").mason_install_path

			-- c, c++, rust
			d.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = install_path("cpptools") .. "/extension/debugAdapters/bin/OpenDebugAD7",
			}

			-- debugging key bindings
			for key, dap_fn in pairs({
				["<leader>dc"] = function()
					-- load launch.json debugging if one exists
					local launch_json = ".vscode/launch.json"
					if vim.fn.filereadable(launch_json) then
						require("dap.ext.vscode").load_launchjs(launch_json, {
							-- adapters -> filetype mapping
							cppdbg = { "c", "cpp", "rust" },
							["pwa-node"] = { "javascript", "typescript" },
						})
					end
					d.continue()
				end,
				["<leader>dn"] = d.step_over,
				["<leader>ds"] = d.step_into,
				["<leader>do"] = d.step_out,
				["<leader>*"] = d.toggle_breakpoint,
				["<leader>dd"] = function()
					-- populate quickfix window with breakpoints and show them
					d.list_breakpoints()
					vim.cmd.copen()
				end,
				["<leader>D"] = d.clear_breakpoints,
				["<leader>d:"] = d.repl.open,
				["<leader>d<cr>"] = d.run_last,
				["<Leader>dk"] = dap_widgets.hover,
				["<Leader>df"] = function()
					dap_widgets.centered_float(dap_widgets.frames)
				end,
				["<Leader>dS"] = function()
					dap_widgets.centered_float(dap_widgets.scopes)
				end,
			}) do
				vim.keymap.set({ "n" }, key, dap_fn, { noremap = true })
			end
		end,
	},
	-- js debugging
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out && rm package-lock.json",
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		lazy = true,
		ft = { "javascript", "typescript" },
		tag = "v1.1.0",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"microsoft/vscode-js-debug",
		},
	},

	-- python debugging
	{
		"mfussenegger/nvim-dap-python",
		commit = "37b4cba02e337a95cb62ad1609b3d1dccb2e5d42",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		lazy = true,
		ft = { "python" },
		config = function()
			local install_path = require("utilities").mason_install_path
			local dap_py = require("dap-python")
			dap_py.setup(install_path("debugpy") .. "/venv/bin/python")
			dap_py.test_runner = "pytest"
			-- key binding to debug nearest test case / class
			vim.keymap.set({ "n" }, "<leader>dt", dap_py.test_method, { buffer = true })
			vim.keymap.set({ "n" }, "<leader>dT", dap_py.test_class, { buffer = true })
		end,
	},

	-- go debugging
	{
		"leoluz/nvim-dap-go",
		commit = "cdf604a5703838f65fdee7c198f6cb59b563ef6f",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		lazy = true,
		ft = { "go" },
		config = function()
			local install_path = require("utilities").mason_install_path
			local dap_go = require("dap-go")
			dap_go.setup({
				delve = {
					path = install_path("delve") .. "/dlv",
				},
			})
			-- key binding to debug nearest test case
			vim.keymap.set({ "n" }, "<leader>dt", dap_go.debug_test, { buffer = true })
		end,
	},
}
