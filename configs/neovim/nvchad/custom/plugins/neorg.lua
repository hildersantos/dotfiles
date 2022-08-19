local present, neorg = pcall(require, "neorg")

if not present then
  return
end

local icons = require "custom.plugins.icons"

local options = {
  load = {
    ["core.defaults"] = {},

    ["core.keybinds"] = {
      config = {
        neorg_leader = "<Leader>",
      },
    },

    ["core.gtd.base"] = {
      config = {
        workspace = "gtd",
      },
    },

    ["core.presenter"] = {
      config = {
        zen_mode = "truezen",
      },
    },

    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          dev = "~/Documents/notes/dev",
          gtd = "~/Documents/notes/gtd",
          -- linux = "~/Documents/notes/linux",
          -- design = "~/Documents/notes/design",
        },
      },
    },

    ["core.norg.concealer"] = {
      config = {
        icons = {
          todo = icons.todo,
          list = icons.list,
          heading = icons.heading,
        },
      },
    },
  },
}

neorg.setup(options)
