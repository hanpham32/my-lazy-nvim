local M = {}

-- Extend conform.nvim opts to register gdscript-formatter
function M.opts(_, opts)
  opts.formatters_by_ft = opts.formatters_by_ft or {}
  opts.formatters_by_ft.gdscript = { "gdscript-formatter" }
  return opts
end

return M
