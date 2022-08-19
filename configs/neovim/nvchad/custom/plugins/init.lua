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
  },
    -- minimal modes
  ["Pocco81/TrueZen.nvim"] = {
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "custom.plugins.truezen"
    end,
  },
    -- notes stuff
  ["nvim-neorg/neorg"] = {
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require "custom.plugins.neorg"
    end,
  },
  -- dim inactive windows
  -- ["andreadev-it/shade.nvim"] = {
  --   module = "shade",
  --   config = function()
  --     require("custom.plugins.smolconfigs").shade()
  --   end,
  -- },
}
