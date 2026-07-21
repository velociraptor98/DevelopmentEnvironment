return {
  -- Use `opts` rather than a `config` function here: LazyVim's mason spec does its
  -- `ensure_installed` auto-install inside `config`, and a second `config` would replace it.
  "mason-org/mason.nvim",
  opts = {
    -- `roslyn-language-server` lives in the default mason-org registry now, so the
    -- third-party Crashdummyy registry is no longer needed.
    ensure_installed = { "roslyn-language-server" },
  },
}
