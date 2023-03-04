--
-- dotfiles
-- Neovim config
-- Editor Plugins
--

local editor = {}

-- Register Editor Plugins with given packer.nvim 'use' callback.
function editor.use_plugins(use)
    -- Editor
    -- text editing
    use { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" }
    use { "tpope/vim-surround", commit = "9857a874632d1b983a7f4b1c85e3d15990c8b101" }
    -- multi-subsitute command
    use { "tpope/vim-abolish", commit = "3f0c8faadf0c5b68bcf40785c1c42e3731bfa522" }
    -- sensible key bindings
    use { "tpope/vim-unimpaired", commit = "f992923d336e93c7f50fe9b35a07d5a92660ecaf" }
    -- command dispatch to tmxu
    use { "tpope/vim-dispatch", commit = "6cc2691576f97d43f8751664d1a1a908b99927e5" }
    -- editor sessions
    use {
        "tpope/vim-obsession", commit = "d2818a614ec3a5d174c6bb19e87e2eeb207f4900",
        config = function(_)
            vim.keymap.set({ "n" }, "<leader>ss", ":Obsession<cr>", {})
        end
    }
    -- auto alignment
    use {
        "junegunn/vim-easy-align",
        commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
        config = function()
            vim.keymap.set({ "n", "x" }, "<leader>=", "<Plug>(EasyAlign)", {})
        end,
    }
    -- undo history
    use {
        "mbbill/undotree",
        tag = "rel_6.1",
        config = function() vim.keymap.set({ "n" }, "<leader>uu", ":UndotreeToggle<CR>", {}) end,
    }
    -- window management
    use {
        "simeji/winresizer",
        config = function()
            vim.g.winresizer_start_key = "<leader>w<CR>"
        end,
    }
    -- git integration
    use {
        "tpope/vim-fugitive",
        tag = "v3.6",
        config = function() vim.keymap.set({ "n" }, "<leader>vv", ":Git<CR>", {}) end,
    }
    -- commenting code
    use {
        "numToStr/Comment.nvim",
        tag = "v0.7.0",
        config = function()
            require('Comment').setup()
        end
    }
    -- indent guides
    use {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v2.20.2",
        config = function()
            require("indent_blankline").setup {}
        end,
    }
end

return editor
