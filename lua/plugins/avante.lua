return {
  "yetone/avante.nvim",
  -- dir = "~/.config/nvim/plugins/avante.nvim",
  name = "avante.nvim",
  -- build = function()
  --   -- conditionally use the correct build system for the current OS
  --   if vim.fn.has("win32") == 1 then
  --     return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --   else
  --     return "make BUILD_FROM_SOURCE=true"
  --   end
  -- end,
  -- init = function()
  --   vim.schedule(function()
  --     vim.notify("🧪 Using local development version of avante.nvim", vim.log.levels.INFO, {
  --       title = "Avante Dev",
  --     })
  --   end)
  -- end,
  event = "VeryLazy",
  keys = {
    {
      "<leader>a+",
    },
  },
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "openrouter", -- default provider
    providers = {
      openrouter = {
        endpoint = "https://openrouter.ai/api/v1",
        __inherited_from = "openai",
        api_key_name = "OPENROUTER_API_KEY",
        model = "openai/gpt-4.1",
      },
      openrouter_kimi_k2 = {
        endpoint = "https://openrouter.ai/api/v1",
        __inherited_from = "openai",
        api_key_name = "OPENROUTER_API_KEY",
        model = "moonshotai/kimi-k2",
      },
      vertex = {
        __inherited_from = "gemini",
        model = "gemini-2.5-flash",
        api_key_name = "GEMINI_API_KEY",
        endpoint = "https://generativelanguage.googleapis.com",
      },
    },
  },
  behaviour = {
    enable_fastapply = true, -- Enable Fast Apply feature
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  windows = {
    ---@alias AvantePosition "right" | "left" | "top" | "bottom" | "smart"
    ---@type AvantePosition
    position = "right",
    wrap = true, -- similar to vim.o.wrap
    fillchars = "eob: ",
    width = 40, -- default % based on available width in vertical layout
    height = 40, -- default % based on available height in horizontal layout
    sidebar_header = {
      enabled = true, -- true, false to enable/disable the header
      align = "center", -- left, center, right for title
      rounded = true,
    },
    spinner = {
      editing = {
        "⡀",
        "⠄",
        "⠂",
        "⠁",
        "⠈",
        "⠐",
        "⠠",
        "⢀",
        "⣀",
        "⢄",
        "⢂",
        "⢁",
        "⢈",
        "⢐",
        "⢠",
        "⣠",
        "⢤",
        "⢢",
        "⢡",
        "⢨",
        "⢰",
        "⣰",
        "⢴",
        "⢲",
        "⢱",
        "⢸",
        "⣸",
        "⢼",
        "⢺",
        "⢹",
        "⣹",
        "⢽",
        "⢻",
        "⣻",
        "⢿",
        "⣿",
      },
      generating = { "·", "✢", "✳", "∗", "✻", "✽" },
      thinking = { "🤯", "🙄" },
    },
    input = {
      prefix = "> ",
      height = 6, -- Height of the input window in vertical layout
    },
    edit = {
      border = { " ", " ", " ", " ", " ", " ", " ", " " },
      start_insert = true, -- Start insert mode when opening the edit window
    },
    ask = {
      floating = false, -- Open the 'AvanteAsk' prompt in a floating window
      border = { " ", " ", " ", " ", " ", " ", " ", " " },
      start_insert = true, -- Start insert mode when opening the ask window
      ---@alias AvanteInitialDiff "ours" | "theirs"
      ---@type AvanteInitialDiff
      focus_on_apply = "ours", -- which diff to focus after applying
    },
  },
  --- @class AvanteConflictConfig
  diff = {
    autojump = true,
    --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
    --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
    --- Disable by setting to -1.
    override_timeoutlen = 500,
  },
  --- @class AvanteHintsConfig
  hints = {
    enabled = true,
  },
}
