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
    require("plugins.language.dap").use_plugins(use)

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

    -- running code snippets
    use {
        "michaelb/sniprun",
        tags = "v1.3.3",
        run = "sh install.sh",
        config = function()
            require("sniprun").setup {
                -- use nvim's builtin luajit to evaluate lua snippets
                selected_interpreters = { "Lua_nvim" },
            }

            -- sniprun keybinding
            vim.keymap.set({ "n", "v" }, "<leader><cr><cr>", "<Plug>SnipRun")
            vim.keymap.set({ "n" }, "<leader><cr>", "<Plug>SnipRunOperator")
        end
    }
end

return language
