return {
  { "habamax/vim-godot" },
  { "skywind3000/asyncrun.vim" },
  { "teatek/gdscript-extended-lsp.nvim", opts = { view_type = "floating", picker = "snacks" } },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- show hidden files
            ignored = false, -- don't show gitignored files
            exclude = { -- exclude specific patterns
              "*.uid", -- glob pattern for files ending with .uid
              "server.pipe", -- exact filename match
            },
          },
        },
      },
    },
  },
  {
    "lommix/godot.nvim",
    lazy = true,
    cmd = { "GodotDebug", "GodotBreakAtCursor", "GodotStep", "GodotQuit", "GodotContinue" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          name = "godot",
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gdscript", "godot_resource", "gdshader" })
      end
    end,
  },
}
