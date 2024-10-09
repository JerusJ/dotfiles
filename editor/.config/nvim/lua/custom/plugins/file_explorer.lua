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
				skip_confirm_for_simple_edits = true,
				-- columns = {
				-- 	"icon",
				-- 	"permissions",
				-- 	"size",
				-- },
				view_options = {
					show_hidden = true,
				},
			})

			vim.keymap.set("n", "<leader>.", oil.open, { desc = "Open Oil" })
			vim.keymap.set("n", "<C-x>d", oil.open, { desc = "Open Oil" })
			vim.keymap.set("n", "<leader>s.", function()
				require("telescope.builtin").live_grep({ search_dirs = { require("oil").get_current_dir() } })
			end, { desc = "Search word in Oil directory" })
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
