-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
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
			})

			pcall(require("telescope").load_extension, "dap")
			pcall(require("telescope").load_extension, "git_worktree")

			local map = require("helpers.keys").map
			map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
			map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
			map("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, "Search in current buffer")

			map("n", "<leader>sf", require("telescope.builtin").find_files, "Files")
			map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
			map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
			map("n", "<leader>sg", require("telescope.builtin").live_grep, "Grep")
			map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")
			map(
				"n",
				"<leader>sr",
				"<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
				"Search Git Worktrees"
			)
			map(
				"n",
				"<leader>sR",
				"<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
				"Create Git Worktree"
			)

			map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")
		end,
	},
}
