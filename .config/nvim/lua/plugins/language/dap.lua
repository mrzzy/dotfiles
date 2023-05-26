--
-- dotfiles
-- Neovim config
-- Debug Adaptors
--

local dap = {}

function dap.use_plugins(use)
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

return dap
