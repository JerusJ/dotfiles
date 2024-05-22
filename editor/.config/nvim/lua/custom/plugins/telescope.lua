-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
						file_ignore_patterns = { "node_modules", ".git", ".venv" },
					},
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--no-ignore-vcs",
						"-g",
						"!**/.git/*",
						"-g",
						"!**/node_modules/*",
					},
				},

				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},

				extensions = {
					"fzf",
				},
			})

			pcall(require("telescope").load_extension, "dap")
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "git_worktree")

			vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Recently opened" })
			vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Open buffers" })
			vim.keymap.set(
				"n",
				"<leader>sb",
				require("telescope.builtin").current_buffer_fuzzy_find,
				{ desc = "Search current buffer" }
			)
			vim.keymap.set("n", "<leader>sB", require("telescope.builtin").buffers, { desc = "Search ALL buffers" })
			vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "Files" })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Help" })
			vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "Current word" })
			vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Grep" })
			vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Diagnostics" })
			vim.keymap.set(
				"n",
				"<leader>sr",
				"<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
				{ desc = "Search Git Worktrees" }
			)
			vim.keymap.set(
				"n",
				"<leader>sR",
				"<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
				{ desc = "Create Git Worktree" }
			)

			vim.keymap.set("n", "<C-p>", require("telescope.builtin").keymaps, { desc = "Search keymaps" })
		end,
	},
}
