return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local oil = require("oil")
      oil.setup({
        default_file_explorer = true,
        columns = {
          "icon",
          "permissions",
          "size",
        },
        view_options = {
          show_hidden = true,
        }
      })

        local map = require("helpers.keys").map
        map("n", "<leader>.", oil.open, "Open Oil")
    end,
  }
}
