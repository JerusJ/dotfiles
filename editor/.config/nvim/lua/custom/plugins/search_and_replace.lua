return {
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()

			vim.keymap.set(
				"n",
				"<leader>ts",
				"<cmd>lua require('spectre').toggle()<CR>",
				{ desc = "[T]oggle [S]pectre" }
			)
		end,
	},

	{
		"gabrielpoca/replacer.nvim",
		config = function()
			require("replacer").setup()

			vim.keymap.set(
				"n",
				"<leader>h",
				'<cmd>lua require("replacer").run()<CR>',
				{ desc = "Edit quickfix window" }
			)
		end,
	},
}
