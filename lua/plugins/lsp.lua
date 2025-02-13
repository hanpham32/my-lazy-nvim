return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- TypeScript/JavaScript LSP setup
      lspconfig.tsserver.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
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
      })

      -- Python LSP setup
      lspconfig.pyright.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
        end,
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
      })

      -- Solidity LSP setup
      lspconfig.solidity.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
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
