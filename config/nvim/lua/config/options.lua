require("config.remote_clipboard").setup()
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.conceallevel = 0

--- Break lines at word boundaries
vim.opt.wrap = true
vim.opt.linebreak = true

--- Copy the indent of the current line when inserting a new line
vim.opt.autoindent = true

--- Disable the inlay hints (additional information about types and parameters names) because it clutters my view
vim.g.lazyvim_no_inlay_hints = true

--- Disable UI animations
vim.g.snacks_animate = false
