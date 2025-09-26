local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.icons").diagnostic_signs

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "windwp/nvim-autopairs",
      "mason-org/mason.nvim",
      "creativenull/efmls-configs-nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
    lazy = false,
    config = function()
      require("neoconf").setup({})
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local lspconfig = require("lspconfig")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.go",
        command = "set filetype=go",
      })

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            complete_unimported = true,
            use_placeholders = true,
            analyses = {
              unusedparams = true,
              nilness = true,
              unusedwrite = true,
              fieldalignment = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      -- Proto
      lspconfig.bufls.setup({
        filetypes = { "proto" },
        cmd = { "bufls", "serve" },
      })

      -- Solidity
      lspconfig.solidity_ls_nomicfoundation.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
        filetypes = { "solidity" },
        root_dir = lspconfig.util.root_pattern("hardhat.config.*", "foundry.toml", "remappings.txt", ".git"),
        settings = {
          solidity = {
            includePath = "",
            remappings = {
              -- OpenZeppelin (common import forms)
              ["@openzeppelin/contracts/"] = "lib/openzeppelin-contracts/contracts/",
              ["@openzeppelin/contracts-upgradeable/"] = "lib/openzeppelin-contracts-upgradeable/contracts/",
              -- Foundry libs
              ["forge-std/"] = "lib/forge-std/src/",
              ["ds-test/"] = "lib/ds-test/src/",
              -- EigenLayer
              ["@eigenlayer/"] = "lib/eigenlayer-middleware/lib/eigenlayer-contracts/src/",
              ["@eigenlayer-middleware/"] = "lib/eigenlayer-middleware/",
              -- Your other libs
              ["tnt-core/"] = "lib/tnt-core/src/",
              ["v4-core/"] = "lib/v4-core/src/",
              -- Local alias (optional)
              ["core/"] = "src/",
            },
          },
        },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
              },
            },
          },
        },
      })

      -- JSON
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "json", "jsonc" },
      })

      -- TypeScript/JavaScript LSP setup
      -- typescript
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
        },
        settings = {
          typescript = {
            indentStyle = "space",
            indentSize = 2,
          },
        },
      })

      -- Bash
      lspconfig.bashls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "sh", "aliasrc" },
      })

      -- SourceKit LSP setup (for Swift)
      lspconfig.sourcekit.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = on_attach,
      })

      -- Python LSP setup
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pyright = {
            disableOrganizeImports = false,
            analysis = {
              useLibraryCodeForTypes = true,
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              autoImportCompletions = true,
            },
          },
        },
      })

      -- Rust LSP setup
      lspconfig.rust_analyzer.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = on_attach,
      })

      -- C# LSP setup
      lspconfig.omnisharp.setup({
        cmd = { "omnisharp" }, -- Ensure `omnisharp` is in your PATH
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = on_attach,
      })

      -- SQL LSP setup
      lspconfig.sqls.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = on_attach,
      })

      -- Docker
      lspconfig.dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- C/C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      })

      for type, icon in pairs(diagnostic_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local solhint = require("efmls-configs.linters.solhint")
      local prettier_d = require("efmls-configs.formatters.prettier_d")
      local luacheck = require("efmls-configs.linters.luacheck")
      local stylua = require("efmls-configs.formatters.stylua")
      local flake8 = require("efmls-configs.linters.flake8")
      local black = require("efmls-configs.formatters.black")
      local eslint = require("efmls-configs.linters.eslint")
      local fixjson = require("efmls-configs.formatters.fixjson")
      local shellcheck = require("efmls-configs.linters.shellcheck")
      local shfmt = require("efmls-configs.formatters.shfmt")
      local hadolint = require("efmls-configs.linters.hadolint")
      local cpplint = require("efmls-configs.linters.cpplint")
      local clangformat = require("efmls-configs.formatters.clang_format")
      local sql_formatter = require("plugins.efm.sql_formatter")

      -- configure efm server
      lspconfig.efm.setup({
        filetypes = {
          "lua",
          "python",
          "json",
          "jsonc",
          "sh",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "svelte",
          "vue",
          "markdown",
          "docker",
          "html",
          "css",
          "c",
          "cpp",
          "sql",
          "solidity",
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
        settings = {
          languages = {
            sql = { sql_formatter },
            -- solidity = { solhint, prettier_d },
            lua = { luacheck, stylua },
            python = { flake8, black },
            typescript = { eslint, prettier_d },
            json = { eslint, fixjson },
            jsonc = { eslint, fixjson },
            sh = { shellcheck, shfmt },
            javascript = { eslint, prettier_d },
            javascriptreact = { eslint, prettier_d },
            typescriptreact = { eslint, prettier_d },
            svelte = { eslint, prettier_d },
            vue = { eslint, prettier_d },
            markdown = { prettier_d },
            docker = { hadolint, prettier_d },
            html = { prettier_d },
            css = { prettier_d },
            c = { clangformat, cpplint },
            cpp = { clangformat, cpplint },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          -- LazyVim default keymaps
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

          -- Diagnostic keymaps
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", opts)

          -- Format
          vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, opts)
        end,
      })
    end,
  },
}
