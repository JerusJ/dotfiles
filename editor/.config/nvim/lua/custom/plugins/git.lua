-- Git related plugins
return {
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>gbb", "<cmd>Gitsigns blame<cr>", { desc = "[G]it [b]lame [b]uffer" })
			vim.keymap.set("n", "<leader>gbl", "<cmd>Gitsigns blame_line<cr>", { desc = "[G]it [b]lame [l]ine" })
		end,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			-- "sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				kind = "vsplit",
				use_per_project_settings = false,
				integrations = {
					telescope = true,
					-- diffview = true,
				},
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
	-- 		vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
	-- 	end,
	-- },
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	config = function()
	-- 		vim.keymap.set("n", "<leader>gc", "<CMD>DiffviewClose<CR>", { desc = "Diffview Close" })
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>go",
	-- 			"<CMD>DiffviewOpen<CR>",
	-- 			{ desc = "Diffview view Git File History compared to main" }
	-- 		)
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>go",
	-- 			"<CMD>DiffviewOpen<CR>",
	-- 			{ desc = "Diffview view Git File History compared to main" }
	-- 		)
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>gl",
	-- 			"<CMD>DiffviewOpen main<CR>",
	-- 			{ desc = "Diffview view Git File History compared to main" }
	-- 		)
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>gL",
	-- 			"<CMD>DiffviewFileHistory<CR>",
	-- 			{ desc = "Diffview view Git File History" }
	-- 		)
	-- 	end,
	-- },
}
