--
-- dotfiles
-- Neovim config
-- JVM Language Support
--

return {
  -- java
  {
    "mfussenegger/nvim-jdtls",
    tag = "365811ecf97a08d0e2055fba210d65017344fd15",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    build = function()
      require("mason.api.command").MasonInstall {
        "java-debug-adapter",         -- java
        "java-test",                  -- java (tests)
      }
    end,
    config = function(_)
      -- autocommand group to start jdtls in java filetypes
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
        pattern = { "java" },
        callback = function()
          local jdtls = require("jdtls")
          local install_path = require("plugins.mason").install_path

          -- locate debug adaptors jars installed by mason
          local function find_jars(package)
            return vim.fn.glob(
              install_path(package) .. "/extension/server/*.jar",
              false, true)
          end
          local bundles = {}
          vim.list_extend(bundles, find_jars("java-debug-adaptor"))
          vim.list_extend(bundles, find_jars("java-test"))
          jdtls.start_or_attach {
            -- use jdtls installed by mason
            cmd = {
              install_path(require("mason-lspconfig.mappings.server"))
              .. "/bin/jdtls",
            },
            -- register debug adaptor jars needed for nvim-dap debugging
            init_options = {
              bundles = bundles
            },
            on_attach = function(_, _)
              -- enable nvim-jdtls's nvim-dap debugger integration
              jdtls.setup_dap({ hotcodereplace = "auto" })
            end,
          }

          -- key binding to debug nearest test case / class
          vim.keymap.set({ "n" }, "<leader>dt", jdtls.test_nearest_method, { buffer = true })
          vim.keymap.set({ "n" }, "<leader>dT", jdtls.test_class, { buffer = true })
        end,
      })
    end
  },
  -- scala
  {
    "scalameta/nvim-metals",
    dependencies = { "mfussenegger/nvim-dap" },
    commit = "0a83e0bfd45ab745ea35757b117a080560e8640e",
    -- install metals language server
    build = ":MetalsInstall",
    config = function(_)
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("metals", { clear = true }),
        pattern = { "scala", "sbt" },
        callback = function()
          local metals = require("metals")
          metals.initialize_or_attach {
            on_attach = function(_)
              metals.setup_dap()

              -- default dap debug configuration for scala
              require("dap").configurations.scala = {
                {
                  type = "scala",
                  request = "launch",
                  name = "Run or Test Target",
                  metals = {
                    runType = "runOrTestFile",
                  },
                },
              }

              -- key binding to debug test case
              -- nvim-metals registers debug test case as code lenses
              vim.keymap.set({ "n" }, "<leader>dt", vim.lsp.codelens.run, { buffer = true })
            end
          }
        end,
      })
    end,
  },
}
