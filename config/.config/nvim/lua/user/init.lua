return {
  diagnostics = {
    virtual_text = false,
  },
  mappings = {
    n = {
      ["<leader>rf"] = {"<cmd>vsplit | terminal fasterer %<cr>", desc = "Run fasterer on current file"},
      ["<leader>rr"] = {"<cmd>vsplit | terminal rspec %<cr>", desc = "Run rspec on current file"}
    }
  },
  lsp = {
    formatting = {
      format_on_save = false, -- enable or disable automatic formatting on save
      ignore_filetypes = { -- disable format on save for specified filetypes
        "markdown",
        "python",
        "bash",
        "Vagrantfile",
      },
    },
  },
  telescope = {
    builtin = {},
  },
  -- neotree = {
  --   window = {
  --     position = "right",
  --   }
  -- },
  signs = {
    -- current_line_blame_formatter = " <author>, <author_time> - <summary> "
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
  },
  colorscheme = "catppuccin",
  plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
      "Exafunction/codeium.vim",
      event = "BufEnter",
      config = function()
        vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
        vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
        vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
        vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
      end,
    },
    -- { 'nvim-treesitter.configs', {
    --   config = function()
    --     endwise = {
    --         enable = true,
    --     }
    --   end
    -- },
    -- {
    --   "nvim-telescope/telescope-file-browser.nvim",
    --   lazy = false,
    --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    -- },
    {
      "nvim-pack/nvim-spectre",
      lazy = false,
      config = function()
        vim.keymap.set("n", "<leader>rt", '<cmd>lua require("spectre").toggle()<CR>', {
          desc = "Toggle Spectre",
        })
        vim.keymap.set("n", "<leader>rc", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
          desc = "Search on current file",
        })
      end,
    },
    {
      "goolord/alpha-nvim",
      opts = function(_, opts)
        opts.section.header.val = {
          "██╗  ██╗███████╗██╗     ██╗██╗  ██╗",
          "██║  ██║██╔════╝██║     ██║╚██╗██╔╝",
          "███████║█████╗  ██║     ██║ ╚███╔╝ ",
          "██╔══██║██╔══╝  ██║     ██║ ██╔██╗ ",
          "██║  ██║███████╗███████╗██║██╔╝ ██╗",
          "╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝",
        }
        -- opts.section.header.val = {
        --   "                       _oo0oo_                                 ",
        --   "                      o8888888o                                ",
        --   "                      88'' .''88                               ",
        --   "                      (| -_- |)                                ",
        --   "                      0\\  =  /0                               ",
        --   "                    ___/`---'\\___                             ",
        --   "                  .' \\|     | '.                              ",
        --   "                 / \\|||  :  ||| \\                            ",
        --   "                / _||||| -:- |||||- \\                         ",
        --   "               |   | \\\\  -  / |   |                          ",
        --   "               | \\_|  ''\\---/''  |_/ |                       ",
        --   "               \\  .-\\__  '-'  ___/-. /                       ",
        --   "             ___'. .'  /--.--\\  `. .'___                      ",
        --   "          .'''' '<  `.___\\_<|>_/___.' >' ''''.                ",
        --   "         | | :  `- \\`.;`\\ _ /`;.`/ - ` : | |                 ",
        --   "         \\  \\ `_.   \\_ __\\ /__ _/   .-` /  /               ",
        --   "     =====`-.____`.___ \\_____/___.-`___.-'=====               ",
        --   "                       `=---='                                 ",
        -- }
        opts.config.opts.noautocmd = true
      end,
    },
  },
}
