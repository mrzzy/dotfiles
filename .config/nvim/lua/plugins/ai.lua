--
-- dotfiles
-- Neovim config
-- AI Agent Coding Integration
--

return {
	-- Opencode AI coding agent
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			-- { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
		},
		config = function()
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
				provider = {
					enabled = "tmux",
				}
			}
			-- keymaps.
			-- keymap modes v: visual mode, x: visual mode with activive selection
			vim.keymap.set({ "n", "x" }, "<leader>ca", function() require("opencode").ask("@this: ", { submit = true }) end,
				{ desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<C-c>", function() require("opencode").select() end,
				{ desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "x" }, "<M-c>", function() require("opencode").select() end,
				{ desc = "Execute opencode action…" })

			-- toggle opencode window
			vim.keymap.set({ "n", "t" }, "<leader>cc", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

			-- send code to opencode window
			vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
				{ desc = "Add range to opencode", expr = true })
			vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
				{ desc = "Add line to opencode", expr = true })


			-- scroll opencode window
			local function scroll_up() require("opencode").command("session.half.page.up") end
			vim.keymap.set("n", "<M-u>", scroll_up, { desc = "Scroll opencode up" })
			vim.keymap.set("n", "<leader>cu", scroll_up, { desc = "Scroll opencode up" })

			local function scroll_down() require("opencode").command("session.half.page.down") end
			vim.keymap.set("n", "<M-d>", scroll_down, { desc = "Scroll opencode down" })
			vim.keymap.set("n", "<leader>cd", scroll_down, { desc = "Scroll opencode down" })
		end,
	},
	-- Copilot Completions
	{
		"zbirenbaum/copilot.lua",
		commit = "a5c390f8d8e85b501b22dcb2f30e0cbbd69d5ff0",
		config = function()
			require("copilot").setup({
				copilot_model = "gpt-4o-copilot",
				suggestion = { enabled = false },
				panel = {
					enabled = true,
					keymap = {
						open = "<C-h>"
					}
				},
				-- enable on all filetypes
				filetypes = {
					yaml = true,
					markdown = true,
					help = true,
					gitcommit = true,
					gitrebase = true,
					hgcommit = true,
					svn = true,
					cvs = true,
					["."] = true,
				}
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		commit = "15fc12af3d0109fa76b60b5cffa1373697e261d1",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
