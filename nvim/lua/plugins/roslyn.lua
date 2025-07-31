return {
  'seblyng/roslyn.nvim',
  ft = 'cs',
  ---@module 'roslyn.config',
  ---@type RoslynNvimConfig
  opts = {
    -- your configuration comes here; leave empty for default settings
    config = {
      -- Here you can pass in any options that that you would like to pass to `vim.lsp.start`.
      -- Use `:h vim.lsp.ClientConfig` to see all possible options.
      -- The only options that are overwritten and won't have any effect by setting here:
      --     - `name`
      --     - `cmd`
      --     - `root_dir`

      settings = {
        ['csharp|symbol_search'] = {
          dotnet_search_reference_assemblies = true,
        },
      },
    },

    -- NOTE: Set `filewatching` to false if you experience performance problems.
    -- Defaults to true, since turning it off is a hack.
    -- If you notice that the server is _super_ slow, it is probably because of file watching
    -- Neovim becomes super unresponsive on some large codebases, because it schedules the file watching on the event loop.
    -- This issue goes away by disabling this capability, but roslyn will fallback to its own file watching,
    -- which can make the server super slow to initialize.
    -- Setting this option to false will indicate to the server that neovim will do the file watching.
    -- However, in `hacks.lua` I will also just don't start off any watchers, which seems to make the server
    -- a lot faster to initialize.
    filewatching = true,

    -- Optional function that takes an array of targets as the only argument. Return the target you
    -- want to use. If it returns `nil`, then it falls back to guessing the target like normal
    -- Example:
    --
    -- choose_target = function(target)
    --     return vim.iter(target):find(function(item)
    --         if string.match(item, "Foo.sln") then
    --             return item
    --         end
    --     end)
    -- end
    choose_target = nil,

    -- Optional function that takes the selected target as the only argument.
    -- Returns a boolean of whether it should be ignored to attach to or not
    --
    -- I am for example using this to disable a solution with a lot of .NET Framework code on mac
    -- Example:
    --
    -- ignore_target = function(target)
    --     return string.match(target, "Foo.sln") ~= nil
    -- end
    ignore_target = nil,

    -- Whether or not to look for solution files in the child of the (root).
    -- Set this to true if you have some projects that are not a child of the
    -- directory with the solution file
    broad_search = false,

    -- Whether or not to lock the solution target after the first attach.
    -- This will always attach to the target in `vim.g.roslyn_nvim_selected_solution`.
    -- NOTE: You can use `:Roslyn target` to change the target
    lock_target = false,
  },
  --   config = function()
  --     vim.lsp.config('roslyn', {
  --       on_attach = function(client, bufnr)
  --         print('Roslyn LSP attached to buffer ' .. bufnr)
  --       end,
  --       settings = {
  --         ['csharp|symbol_search'] = {
  --           dotnet_search_reference_assemblies = true,
  --         },
  --       },
  --     })
  --   end,
}
