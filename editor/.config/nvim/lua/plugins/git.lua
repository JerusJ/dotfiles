-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim", -- required
	-- 		"sindrets/diffview.nvim", -- optional - Diff integration
	--
	-- 		-- Only one of these is needed, not both.
	-- 		"nvim-telescope/telescope.nvim", -- optional
	-- 	},
	-- 	config = function()
	-- 		local neogit = require("neogit")
	-- 		neogit.setup({
	-- 			kind = "split",
	-- 		})
	--
	-- 		local map = require("helpers.keys").map
	-- 		map("n", "<leader>gg", neogit.open, "Open NeoGit")
	-- 	end,
	-- },
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
        "nvim-lua/plenary.nvim",
		},
		config = function()
			local lazy = require("lazy")
			local map = require("helpers.keys").map
			map("n", "<leader>gg", "<cmd>LazyGit<cr>", "Open LazyGit")
		end,
	},
}
