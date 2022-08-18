-- custom/plugins/init.lua has to return a table
-- The plugin name is github user or organization name/reponame

return {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      -- require "custom.plugins.todo-comments"
      require("todo-comments").setup {}
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
    }
}

