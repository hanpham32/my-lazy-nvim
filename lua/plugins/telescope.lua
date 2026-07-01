return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
      end,
      desc = "Find Hidden Files",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files",
    },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>fa",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Grep files",
    },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = { "Function", "Method" },
        })
      end,
      desc = "Find functions in buffer",
    },
  },
}
