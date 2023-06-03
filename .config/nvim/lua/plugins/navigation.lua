--
-- dotfiles
-- Neovim config
-- Navigation Plugins
--


local navigation = {}
-- Register Editor Plugins with given packer.nvim 'use' callback.
function navigation.use_plugins(use)
    -- Navigation
    use {
        "ibhagwan/fzf-lua",
        commit = "446429138a841b45a2a7743cc08d7bc17493e7c8",
        config = function()
            local fzf = require("fzf-lua")
            local map = vim.keymap.set
            -- file navigation
            map({ "n" }, "<C-p>", fzf.git_files, {})
            map({ "n" }, "<M-p>", fzf.files, {})
            map({ "n" }, "<C-Space>", fzf.buffers, {})
            -- tag navigation
            map({ "n" }, "<C-t>", fzf.tags_live_grep, {})
            map({ "n" }, "<M-t>", fzf.tags_live_grep, {})
            -- lsp navigation
            map({ "n" }, "<C-j>", fzf.lsp_document_symbols, {})
            map({ "n" }, "<C-k>", fzf.lsp_live_workspace_symbols, {})
            -- grep search
            -- <C-_> key is received by nvim when user presses <C-/>
            map({ "n" }, "<C-_>", fzf.live_grep_native, {})
            map({ "n" }, "<M-/>", fzf.live_grep_native, {})
            -- switching buffers & branches
            map({ "n" }, "<C-g>", fzf.git_branches, {})

            -- register fzf.lua as ui picker for vim.ui.select()
            -- improves ux when nvim prompts for user input (eg. lsp code action)
            fzf.register_ui_select()
        end,
    }
    -- tag file manager
    use {
        "ludovicchabant/vim-gutentags",
        commit = "b77b8fabcb0b052c32fe17efcc0d44f020975244",
        config = function()
            -- disable gutentags by default, unless toggled on explicitly
            vim.g.gutentags_enabled = false
            vim.g.gutentags_define_advanced_commands = true
            -- disable gutentags for git commit as they do not does not play well together
            -- clear any existing autocmds to prevent autocmd spam
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = vim.api.nvim_create_augroup("gutentags", { clear = true }),
                pattern = { "gitcommit", "gitrebase" },
                callback = function(_)
                    vim.g.gutentags_enabled = false
                end,
            })
        end
    }
    -- project specific file navigation
    use { "tpope/vim-projectionist", commit = "d4aee3035699b82b3789cee0e88dad0e38c423ab" }
    -- file drawer
    use {
        "nvim-tree/nvim-tree.lua",
        commit = "59e65d88db177ad1e6a8cffaafd4738420ad20b6",
        config = function()
            -- override special glyphs used in nvim-tree that require font support
            require("nvim-tree").setup {
                renderer = {
                    icons = {
                        glyphs = {
                            default = ".",
                            symlink = "~",
                            modified = "+",
                            bookmark = "M",
                            folder = {
                                arrow_closed = "▷",
                                arrow_open = "▼",
                                default = "/",
                                open = "/",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                            git = {
                                unstaged = "U",
                                staged = "S",
                                unmerged = "↔",
                                renamed = "⇒",
                                untracked = "?",
                                deleted = "D",
                                ignored = "I",
                            },
                        }
                    }
                }
            }
            -- define key bindings
            local map = vim.keymap.set
            map({ "n" }, "<leader>ff", ":NvimTreeToggle<CR>", {})
            map({ "n" }, "<leader>f.", ":NvimTreeFindFile<CR>", {})
            map({ "n" }, "<leader>fa", function()
                -- populate arglist with bookmarked files
                local fn = require("functional")
                vim.cmd.args(fn.map(require("nvim-tree.api").marks.list(), function(node)
                    return node.absolute_path
                end))
            end, {})
        end,
    }
end

return navigation
