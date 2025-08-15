-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"Myzel394/easytables.nvim",
			"Myzel394/jsonfly.nvim",
			"Myzel394/telescope-last-positions",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"isak102/telescope-git-file-history.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"tpope/vim-fugitive",
			},
		},
		keys = {
			{
				"<leader>sj",
				"<cmd>Telescope jsonfly<cr>",
				desc = "Open json(fly)",
				ft = { "json", "xml", "yaml" },
				mode = "n",
			},
		},
		config = function()
			local project_actions = require("telescope._extensions.project.actions")
			local gfh_actions = require("telescope").extensions.git_file_history.actions
			local theme = "ivy"

			require("telescope").setup({
				pickers = {
					find_files = {
						theme = theme,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!**/{node_modules,.git}/*",
							"--sortr=path",
						},
					},
					live_grep = {
						theme = theme,
					},
					buffers = {
						theme = theme,
						sort_mru = true,
						ignore_current_buffer = true,
						mappings = {
							i = {
								["<C-w>"] = "delete_buffer",
							},
							n = {
								["<C-w>"] = "delete_buffer",
							},
						},
					},
				},

				defaults = {
					color_devicons = false,
					layout_config = {
						-- width = 0.99,
						-- height = 0.99,
					},
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						-- Own additions
						"--trim",
						"--sortr=path",
					},
				},

				extensions = {
					git_file_history = {
						-- Keymaps inside the picker
						mappings = {
							i = {
								["<C-g>"] = gfh_actions.open_in_browser,
							},
							n = {
								["<C-g>"] = gfh_actions.open_in_browser,
							},
						},

						-- The command to use for opening the browser (nil or string)
						-- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
						browser_command = nil,
					},

					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},

					project = {
						base_dirs = {
							{ "~/code", max_depth = 4 },
						},

						ignore_missing_dirs = true, -- default: false
						hidden_files = true, -- default: false
						theme = theme,
						order_by = "asc",
						search_by = "title",
						sync_with_nvim_tree = true, -- default false
						-- default for on_project_selected = find project files
						on_project_selected = function(prompt_bufnr)
							-- Do anything you want in here. For example:
							project_actions.change_working_directory(prompt_bufnr, false)
							-- require("harpoon.ui").nav_file(1)
						end,

						mappings = {
							n = {
								["d"] = project_actions.delete_project,
								["r"] = project_actions.rename_project,
								["c"] = project_actions.add_project,
								["C"] = project_actions.add_project_cwd,
								["f"] = project_actions.find_project_files,
								["b"] = project_actions.browse_project_files,
								["s"] = project_actions.search_in_project_files,
								["R"] = project_actions.recent_project_files,
								["w"] = project_actions.change_working_directory,
								["o"] = project_actions.next_cd_scope,
							},
							i = {
								["<c-d>"] = project_actions.delete_project,
								["<c-v>"] = project_actions.rename_project,
								["<c-a>"] = project_actions.add_project,
								["<c-A>"] = project_actions.add_project_cwd,
								["<c-f>"] = project_actions.find_project_files,
								["<c-b>"] = project_actions.browse_project_files,
								["<c-s>"] = project_actions.search_in_project_files,
								["<c-r>"] = project_actions.recent_project_files,
								["<c-l>"] = project_actions.change_working_directory,
								["<c-o>"] = project_actions.next_cd_scope,
								["<c-w>"] = project_actions.change_workspace,
							},
						},
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "dap")
			pcall(require("telescope").load_extension, "git_worktree")
			pcall(require("telescope").load_extension, "jsonfly")
			pcall(require("telescope").load_extension, "project")
			pcall(require("telescope").load_extension, "git_file_history")

			vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Recently opened" })
			vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, { desc = "Open buffers" })
			vim.keymap.set(
				"n",
				"<leader>sb",
				require("telescope.builtin").current_buffer_fuzzy_find,
				{ desc = "Search current buffer" }
			)
			vim.keymap.set("n", "<leader>sB", require("telescope.builtin").buffers, { desc = "Search ALL buffers" })
			vim.keymap.set("n", "<leader><leader>", require("telescope.builtin").find_files, { desc = "Files" })
			vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Help" })
			vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "Current word" })
			vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Grep" })
			vim.keymap.set("n", "<leader>sp", require("telescope.builtin").live_grep, { desc = "Grep" })
			vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Diagnostics" })
			vim.keymap.set(
				"n",
				"<leader>sf",
				"<CMD>lua require('telescope').extensions.git_file_history.git_file_history()<CR>",
				{ desc = "Search [F]ile Git History" }
			)
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
			vim.keymap.set(
				"n",
				"<leader>pp",
				"<CMD>lua require('telescope').extensions.project.project{}<CR>",
				{ desc = "Create Git Worktree" }
			)

			vim.keymap.set("n", "<C-p>", require("telescope.builtin").keymaps, { desc = "Search keymaps" })

			-- Disable inner borders (so we look cool, like NVChad)
			local normal_bg = vim.api.nvim_get_hl_by_name("Normal", true).background
			local bg_hex = string.format("#%06x", normal_bg)

			for _, grp in ipairs({
				"TelescopeBorder",
				"TelescopePromptBorder",
				"TelescopeResultsBorder",
				"TelescopePreviewBorder",
				"TelescopePromptTitle",
				"TelescopeResultsTitle",
				"TelescopePreviewTitle",
			}) do
				vim.api.nvim_set_hl(0, grp, { fg = bg_hex, bg = bg_hex })
			end
		end,
	},
}
