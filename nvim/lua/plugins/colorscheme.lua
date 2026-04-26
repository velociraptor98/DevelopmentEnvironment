return {
  -- Add everforest
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme here
      -- vim.g.everforest_background = "hard"
      vim.cmd([[colorscheme everforest]])
    end,
  },

  -- Configure LazyVim to load everforest
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
