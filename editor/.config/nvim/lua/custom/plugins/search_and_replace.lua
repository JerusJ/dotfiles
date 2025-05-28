return {
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
