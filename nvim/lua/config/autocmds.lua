-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start nvim server for Godot
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.has("win32") == 1 then
      vim.fn.serverstart([[\\.\pipe\godot.pipe]])
    else
      vim.fn.serverstart("/tmp/godot.pipe")
    end
  end,
})
