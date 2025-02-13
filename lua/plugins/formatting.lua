return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Updated syntax: use stop_after_first instead of nested tables
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        python = { "black" },
        toml = { "taplo" },
      },

      -- To specify running only the first available formatter, use this:
      default_format_opts = {
        timeout_ms = 2000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_fallback = true,
        -- Set this option to stop after the first formatter succeeds
        stop_after_first = true,
      },
    },
  },
}
