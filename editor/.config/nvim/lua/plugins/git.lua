-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"akinsho/git-conflict.nvim",
		commit = "2957f74",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					ours = "co",
					theirs = "ct",
					none = "c0",
					both = "cb",
					next = "cn",
					prev = "cp",
				},
			})
		end,
	},
	{
	  "NeogitOrg/neogit",
	  dependencies = {
		"nvim-lua/plenary.nvim",         -- required
		"sindrets/diffview.nvim",        -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua",              -- optional
	  },
    config = function()
      local neogit = require("neogit")
        neogit.setup({
            kind = "split",
        })

        local map = require("helpers.keys").map
        map("n", "<leader>gg", neogit.open, "Open NeoGit")
    end,
    }
}
