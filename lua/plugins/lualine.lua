return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        globalstatus = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "buffers" },
        lualine_x = { "encoding", "fileformat", "filetype", "progress" },
        lualine_y = { "" },
        lualine_z = { "location" },
      },
      tabline = {},
    })
  end,
}
