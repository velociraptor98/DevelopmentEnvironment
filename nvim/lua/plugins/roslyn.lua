return {
  {
    -- mason-lspconfig's `automatic_enable` starts every installed server, which fights roslyn.nvim
    -- over `cs` buffers: omnisharp used to claim them outright, and roslyn_ls (mason's own config
    -- for roslyn-language-server) attaches a second, duplicate client alongside roslyn.nvim's.
    -- Disabling both puts them in LazyVim's mason_exclude list so `automatic_enable` skips them,
    -- leaving roslyn.nvim as the single owner of C#.
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = { enabled = false },
        roslyn_ls = { enabled = false },
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- Unity projects often have multiple solution files; broad_search helps find them.
      broad_search = true,
      -- Using the server's internal watcher is generally more stable for large Unity projects.
      filewatching = "roslyn",
      -- Unity projects migrated to SDK-style generation (com.ikistudio.ide.uvim) have a new
      -- .slnx next to the leftover legacy .sln; prefer the .slnx instead of prompting.
      -- Returning nil falls back to the plugin's normal target selection.
      choose_target = function(targets)
        local slnx = vim.tbl_filter(function(t)
          return t:match("%.slnx$") ~= nil
        end, targets)
        if #slnx == 1 then
          return slnx[1]
        end
      end,
    },
    init = function()
      -- Unity generates legacy .NET Framework (net471) csprojs. Roslyn's build host wants Mono
      -- MSBuild for those, but Homebrew's mono ships without MSBuild, so it falls back to the
      -- .NET SDK — which then can't resolve framework assemblies referenced by simple name
      -- (netstandard, System.*), leaving every Unity project with broken references and no
      -- completion. FrameworkPathOverride points reference resolution at Mono's 4.7.1 reference
      -- assemblies instead; it only kicks in for .NET Framework-targeting projects, so modern
      -- SDK-style projects are unaffected. Works for both Homebrew mono (bin/mono) and the
      -- official framework install (Commands/mono) since lib/ sits beside the binary's parent.
      local cmd_env
      local mono = vim.fn.exepath("mono")
      if mono ~= "" then
        local api_dir = vim.fs.normalize(vim.fn.resolve(mono) .. "/../../lib/mono/4.7.1-api")
        if vim.uv.fs_stat(api_dir) then
          cmd_env = { FrameworkPathOverride = api_dir }
        end
      end

      -- Server settings go through vim.lsp.config, not the plugin's opts: roslyn.nvim's config
      -- table only accepts filewatching/broad_search/choose_target/ignore_target/lock_target/
      -- debug, and tbl_deep_extends anything else into oblivion.
      vim.lsp.config("roslyn", {
        cmd_env = cmd_env,
        settings = {
          ["csharp|background_analysis"] = {
            dotnet_compiler_diagnostics_scope = "fullSolution",
            dotnet_analyzer_diagnostics_scope = "fullSolution",
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
          },
        },
      })
    end,
  },
}
