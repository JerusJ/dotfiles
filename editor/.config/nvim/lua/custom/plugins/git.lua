-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				kind = "split",
			})

			vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open NeoGit" })
		end,
	},
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		local lazy = require("lazy")
	-- 		vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
	-- 	end,
	-- },
}
