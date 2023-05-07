--
-- dotfiles
-- Neovim config
-- Language Support
--

local autocomplete = require("autocomplete")
local langserver = require("langserver")
local language = {}

local plenary_version = "v0.1.3"

-- Register Completion Plugins with given packer.nvim 'use' callback.
function language.use_plugins(use)
    -- language servers
    use {
        "neovim/nvim-lspconfig",
        tag = "v0.1.6",
        requires = {
            {
                "williamboman/mason.nvim",
                commit = "718966fd3204bd1e4aa5af0a032ce1e916295ecd",
                requires = { {
                    "williamboman/mason-lspconfig.nvim",
                    commit = "93e58e100f37ef4fb0f897deeed20599dae9d128",
                } },
                run = langserver.install,
                config = function()
                    require('mason').setup()
                    require('mason-lspconfig').setup()
                end
            },
            {
                "folke/neodev.nvim",
                tag = "v2.5.2",
            }
        },
        config = langserver.setup_lsp,
    }
    -- java
    use {
        "mfussenegger/nvim-jdtls",
        tag = "0.2.0",
        config = function()
            -- autocommand group to start jdtls in java filetypes
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
                pattern = { "java" },
                callback = function()
                    require("jdtls").start_or_attach {
                        -- use jdtls installed by mason
                        cmd = {
                            require("mason-registry").get_package(
                                require("mason-lspconfig.mappings.server")
                                .lspconfig_to_package["jdtls"]
                            ):get_install_path() .. "/bin/jdtls",
                        },
                    }
                end,
            })
        end
    }
    -- scala
    use {
        "scalameta/nvim-metals",
        commit = "0a83e0bfd45ab745ea35757b117a080560e8640e",
        -- install metals language server
        run = ":MetalsInstall",
        config = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("metals", { clear = true }),
                pattern = { "scala", "sbt" },
                callback = function()
                    require("metals").initialize_or_attach {}
                end,
            })
        end,
    }
    -- completion & snippets
    use {
        "hrsh7th/nvim-cmp",
        commit = "8a9e8a89eec87f86b6245d77f313a040a94081c1",
        requires = {
            { "hrsh7th/cmp-nvim-lsp",                commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" },
            { "hrsh7th/cmp-path",                    commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
            { "hrsh7th/cmp-cmdline",                 commit = "8bc9c4a34b223888b7ffbe45c4fe39a7bee5b74d" },
            { "hrsh7th/cmp-buffer",                  commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", commit = "d2768cb1b83de649d57d967085fe73c5e01f8fd7" },
            { "saadparwaiz1/cmp_luasnip",            commit = "18095520391186d634a0045dacaa346291096566" },
            {
                "L3MON4D3/LuaSnip",
                commit = "09ce9a70bd787d4ce188f2de1390f656f119347c",
                requires = { { "honza/vim-snippets" } },
                config = function()
                    -- load snapmate snippets from plugins (eg. vim-snippets) into luasnip's catalogue
                    require("luasnip.loaders.from_snipmate").lazy_load()
                end,
            },
        },
        config = autocomplete.setup_cmp,
    }

    -- linters & formatters
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
end

return language
