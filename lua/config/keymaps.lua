-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open command line
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })

-- Move left and right in insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line(s) to clipboard" })

vim.keymap.set("n", "<leader>td", "<cmd>TodoQuickFix<cr>", { desc = "Open TODOs in quickfix list" })
require("telescope").load_extension("todo-comments")
vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Open TODOs in telescope" })

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown Preview" })

vim.keymap.set("n", "<leader>ci", function()
  local header = vim.fn.expand("<cfile>")
  if header:match("^<.+$") then
    header = header:match("^<(.+)>$")
  end
  local path = "/usr/include/c++/16.1.1/" .. header
  vim.cmd("edit " .. path)
end, { desc = "Open C++ header under cursor in a new buffer" })
