return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- add any other languages you want here
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "ruby",
      "typescript",
      "vim",
      "yaml",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
}
