return {
  lazy = false,
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  opts = {},
  config = function()
    require("fzf-lua").setup()
    vim.keymap.set("n", "<leader>ss", function()
      require("fzf-lua").lsp_document_symbols()
    end, { desc = "FZF LSP Document Symbols" })
  end,
}
