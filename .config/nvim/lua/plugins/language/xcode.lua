--
-- dotfiles
-- Neovim config
-- JVM Language Support
--

return {
  "wojciech-kulik/xcodebuild.nvim",
  ft = { 'swift', 'objc', 'objcpp', 'c', 'cpp' },
  cmd = {
    "XcodebuildSetup",
    "XcodebuildBuild",
    "XcodebuildBuild",
    "XcodebuildBuildForTesting",
    "XcodebuildTest",
    "XcodebuildTestClass",
    "XcodebuildTestNearest",
    "XcodebuildDebug",
    "XcodebuildDebugClass",
    "XcodebuildDebugNearest",
    "XcodebuildBootSimulator",
    "XcodebuildPicker",
    "XcodebuildToggleLogs",
    "XcodebuildCleanProject",
  },
  dependencies = {
    "ibhagwan/fzf-lua",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("xcodebuild").setup({
        -- put some options here or leave it empty to use default settings
    })
  end,
}
