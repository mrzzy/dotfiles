--
-- dotfiles
-- Neovim config
-- Language Support
--

local langserver = require("langserver")
local language = {}

local plenary_version = "v0.1.3"

-- Register Completion Plugins with given packer.nvim 'use' callback.
function language.use_plugins(use)
    require("plugins.language.jvm").use_plugins(use)

    -- package manager for language servers & debug adaptors
    use {
        "williamboman/mason.nvim",
        commit = "718966fd3204bd1e4aa5af0a032ce1e916295ecd",
        config = function() require('mason').setup {} end,
    }

    -- language servers
    use {
        "neovim/nvim-lspconfig",
        tag = "v0.1.6",
        requires = {
            "williamboman/mason.nvim",
            {
                "williamboman/mason-lspconfig.nvim",
                commit = "93e58e100f37ef4fb0f897deeed20599dae9d128",
                config = function() require('mason-lspconfig').setup {} end,
            },
        },
        run = langserver.install,
        config = langserver.setup_lsp,
    }
    -- neovim lua
    use {
        "folke/neodev.nvim",
        tag = "v2.5.2",
    }

    -- null ls: linters, formatters & code actions
    use {
        "jose-elias-alvarez/null-ls.nvim",
        commit = "71797bb303ac99a4435592e15068f127970513d7",
        requires = { { "nvim-lua/plenary.nvim", tag = plenary_version } },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup {
                debug = true,
                sources = {
                    -- Code Actions
                    -- git actions
                    null_ls.builtins.code_actions.gitsigns,

                    -- Linters
                    -- spelling
                    null_ls.builtins.diagnostics.codespell,
                    -- terraform
                    null_ls.builtins.diagnostics.terraform_validate,

                    -- Formatters
                    -- js, ts, css, html, yaml, markdown
                    null_ls.builtins.formatting.prettier,
                    -- json
                    null_ls.builtins.formatting.jq,
                    -- sql
                    null_ls.builtins.formatting.sqlfmt,
                    -- python
                    null_ls.builtins.formatting.black,
                    -- go
                    null_ls.builtins.formatting.gofmt,
                    -- rust
                    null_ls.builtins.formatting.rustfmt,
                    -- terraform
                    null_ls.builtins.formatting.terraform_fmt,
                    -- packer
                    null_ls.builtins.formatting.packer,
                },
            }
        end,
    }

    -- debugger adaptors
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
            local dap = require("dap")
            local dap_widgets = require("dap.ui.widgets")
            local install_path = require("plugins.mason").install_path

            -- c, c++, rust
            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = install_path("cpptools") .. "/extension/debugAdapters/bin/OpenDebugAD7",
            }
            local cppdbg = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        -- prompt user for executable to debug
                        return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                }
            }
            dap.configurations.c = cppdbg
            dap.configurations.cpp = cppdbg
            dap.configurations.rust = cppdbg

            for key, dap_fn in pairs({
                    ["<leader>dc"] = dap.continue,
                    ["<leader>dn"] = dap.step_over,
                    ["<leader>ds"] = dap.step_into,
                    ["<leader>do"] = dap.step_out,
                    ["<leader>*"] = dap.toggle_breakpoint,
                    ["<leader>dd"] = function()
                        -- populate quickfix window with breakpoints and show them
                        dap.list_breakpoints()
                        vim.cmd.copen()
                    end,
                    ["<leader>D"] = dap.clear_breakpoints,
                    ["<leader>d:"] = dap.repl.open,
                    ["<leader>d<cr>"] = dap.run_last,
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
    }

    -- js debugging
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
            require("dap-vscode-js").setup {}
            -- use
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
            local install_path = require("plugins.mason").install_path
            require("dap-python").setup(install_path("debugpy") .. "/venv/bin/python")
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
            local install_path = require("plugins.mason").install_path
            require("dap-go").setup {
                delve = {
                    path = install_path("delve") .. "/dlv",
                }
            }
        end
    }
end

return language
