--
-- dotfiles
-- Neovim config
-- Debug Adaptors
--

local dap = {}

function dap.use_plugins(use)
    use {
        "mfussenegger/nvim-dap",
        tag = "0.6.0",
        requires = { "williamboman/mason.nvim" },
        run = function()
            require("mason.api.command").MasonInstall {
                "cpptools", -- c,c++,rust
            }
        end,
        config = function()
            local d = require("dap")
            local dap_widgets = require("dap.ui.widgets")
            local install_path = require("plugins.mason").install_path

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
                vim.keymap.set({ 'n' }, key, dap_fn, { noremap = true })
            end
        end
    } -- js debugging
    use {
        "mxsdev/nvim-dap-vscode-js",
        tag = "v1.1.0",
        requires = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            -- manual installation of vscode-js-debug as mason's installer for it is broken
            {
                "microsoft/vscode-js-debug",
                opt = true,
                run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
            }
        },
        config = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("dap-vscode-js", { clear = true }),
                pattern = { "javascript", "typescript" },
                callback = function()
                    require("dap-vscode-js").setup {}
                end,
            })
        end
    }

    -- python debugging
    use {
        "mfussenegger/nvim-dap-python",
        commit = "37b4cba02e337a95cb62ad1609b3d1dccb2e5d42",
        requires = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        run = function()
            require("mason.api.command").MasonInstall { "debugpy" }
        end,
        config = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("dap-python", { clear = true }),
                pattern = { "python" },
                callback = function()
                    local install_path = require("plugins.mason").install_path
                    local dap_py = require("dap-python")
                    dap_py.setup(install_path("debugpy") .. "/venv/bin/python")
                    dap_py.test_runner = "pytest"
                    -- key binding to debug nearest test case / class
                    vim.keymap.set({ "n" }, "<leader>dt", dap_py.test_method, { buffer = true })
                    vim.keymap.set({ "n" }, "<leader>dT", dap_py.test_class, { buffer = true })
                end,
            })
        end
    }

    -- go debugging
    use {
        "leoluz/nvim-dap-go",
        commit = "cdf604a5703838f65fdee7c198f6cb59b563ef6f",
        require = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        run = function()
            require("mason.api.command").MasonInstall { "delve" }
        end,
        config = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("dap-go", { clear = true }),
                pattern = { "go" },
                callback = function()
                    local install_path = require("plugins.mason").install_path
                    local dap_go = require("dap-go")
                    dap_go.setup {
                        delve = {
                            path = install_path("delve") .. "/dlv",
                        }
                    }
                    -- key binding to debug nearest test case
                    vim.keymap.set({ "n" }, "<leader>dt", dap_go.debug_test, { buffer = true })
                end,
            })
        end
    }
end

return dap
