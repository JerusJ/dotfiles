return {
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()

      local map = require("helpers.keys").map
      map("n", "<leader>ts", "<cmd>lua require('spectre').toggle()<CR>", "[T]oggle [S]pectre")
    end
  }
}
