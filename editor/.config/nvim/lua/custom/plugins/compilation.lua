return {
	"ej-shafran/compile-mode.nvim",
	branch = "latest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- if you want to enable coloring of ANSI escape codes in
		-- compilation output, add:
		-- { "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		---@type CompileModeOpts
		vim.g.compile_mode = {
			-- to add ANSI escape code support, add:
			baleia_setup = true,
		}

		-- NOTE(jesse): for keybindings, see: https://github.com/ej-shafran/compile-mode.nvim/blob/main/doc/compile-mode.txt#L45
		vim.keymap.set("n", "<leader>cc", "<CMD>Compile<CR>", { desc = "Run compilation command" })
		vim.keymap.set("n", "<leader>cC", "<CMD>Recompile<CR>", { desc = "Re-run last compilation command" })
	end,
}
