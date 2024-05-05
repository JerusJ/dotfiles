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
}
