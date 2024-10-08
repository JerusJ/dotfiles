return {
	-- Global
	{
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup()
		end,
	},

	-- GitHub
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local octo = require("octo")
			octo.setup({
				suppress_missing_scope = {
					projects_v2 = true,
				},
				mappings = {
					issue = {
						close_issue = { lhs = "<space>ic", desc = "close issue" },
						reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
						list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
						reload = { lhs = "<C-r>", desc = "reload issue" },
						open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
						copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
						add_assignee = { lhs = "<space>aa", desc = "add assignee" },
						remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
						create_label = { lhs = "<space>lc", desc = "create label" },
						add_label = { lhs = "<space>la", desc = "add label" },
						remove_label = { lhs = "<space>ld", desc = "remove label" },
						goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
						add_comment = { lhs = "<space>ca", desc = "add comment" },
						delete_comment = { lhs = "<space>cd", desc = "delete comment" },
						next_comment = { lhs = "]c", desc = "go to next comment" },
						prev_comment = { lhs = "[c", desc = "go to previous comment" },
						react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
						react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
						react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
						react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
						react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
						react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
						react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
						react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
					},
					pull_request = {
						checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
						merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
						squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
						rebase_and_merge_pr = { lhs = "<space>prm", desc = "rebase and merge PR" },
						list_commits = { lhs = "<space>pc", desc = "list PR commits" },
						list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
						show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
						add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
						remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
						close_issue = { lhs = "<space>ic", desc = "close PR" },
						reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
						list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
						reload = { lhs = "<C-r>", desc = "reload PR" },
						open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
						copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
						goto_file = { lhs = "gf", desc = "go to file" },
						remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
						add_assignee = { lhs = "<space>aa", desc = "add assignee" },
						create_label = { lhs = "<space>lc", desc = "create label" },
						add_label = { lhs = "<space>la", desc = "add label" },
						remove_label = { lhs = "<space>ld", desc = "remove label" },
						goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
						add_comment = { lhs = "<space>ca", desc = "add comment" },
						delete_comment = { lhs = "<space>cd", desc = "delete comment" },
						next_comment = { lhs = "]c", desc = "go to next comment" },
						prev_comment = { lhs = "[c", desc = "go to previous comment" },
						react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
						react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
						react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
						react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
						react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
						react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
						react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
						react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
						review_start = { lhs = "<space>vs", desc = "start a review for the current PR" },
						review_resume = { lhs = "<space>vr", desc = "resume a pending review for the current PR" },
					},
					review_thread = {
						goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
						add_comment = { lhs = "<space>ca", desc = "add comment" },
						add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
						delete_comment = { lhs = "<space>cd", desc = "delete comment" },
						next_comment = { lhs = "]c", desc = "go to next comment" },
						prev_comment = { lhs = "[c", desc = "go to previous comment" },
						select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
						select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
						select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
						select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
						react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
						react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
						react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
						react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
						react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
						react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
						react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
					},
					submit_win = {
						approve_review = { lhs = "<C-a>", desc = "approve review" },
						comment_review = { lhs = "<C-m>", desc = "comment review" },
						request_changes = { lhs = "<C-r>", desc = "request changes review" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
					},
					review_diff = {
						submit_review = { lhs = "<leader>vs", desc = "submit review" },
						discard_review = { lhs = "<leader>vd", desc = "discard review" },
						add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
						add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
						focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
						toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
						next_thread = { lhs = "]t", desc = "move to next thread" },
						prev_thread = { lhs = "[t", desc = "move to previous thread" },
						select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
						select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
						select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
						select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
						goto_file = { lhs = "gf", desc = "go to file" },
					},
					file_panel = {
						submit_review = { lhs = "<leader>vs", desc = "submit review" },
						discard_review = { lhs = "<leader>vd", desc = "discard review" },
						next_entry = { lhs = "j", desc = "move to next changed file" },
						prev_entry = { lhs = "k", desc = "move to previous changed file" },
						select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
						refresh_files = { lhs = "R", desc = "refresh changed files panel" },
						focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
						toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
						select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
						select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
						select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
						select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
					},
				},
			})

			vim.keymap.set("n", "<leader>ghprc", "<CMD>Octo pr create<CR>", { desc = "GitHub: Create PR" })
		end,
	},

	-- GitLab
	-- {
	-- 	"harrisoncramer/gitlab.nvim",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"sindrets/diffview.nvim",
	-- 		"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
	-- 		"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
	-- 	},
	-- 	enabled = true,
	-- 	build = function()
	-- 		require("gitlab.server").build(true)
	-- 	end, -- Builds the Go binary
	--
	-- 	config = function()
	-- 		local gitlab = require("gitlab")
	-- 		gitlab.setup()
	--
	-- 		vim.keymap.set("n", "<leader>glb", gitlab.choose_merge_request, { desc = "GitLab: Choose Merge Request" })
	-- 		vim.keymap.set("n", "<leader>glr", gitlab.review, { desc = "GitLab: Review" })
	-- 		vim.keymap.set("n", "<leader>gls", gitlab.summary, { desc = "GitLab: Summary" })
	-- 		vim.keymap.set("n", "<leader>glA", gitlab.approve, { desc = "Gitlab: Approve" })
	-- 		vim.keymap.set("n", "<leader>glR", gitlab.revoke, { desc = "GitLab: Revoke" })
	-- 		vim.keymap.set("n", "<leader>glc", gitlab.create_comment, { desc = "GitLab: Create Comment" })
	-- 		vim.keymap.set(
	-- 			"v",
	-- 			"<leader>glc",
	-- 			gitlab.create_multiline_comment,
	-- 			{ desc = "GitLab: Create MultiLine Comment" }
	-- 		)
	-- 		vim.keymap.set(
	-- 			"v",
	-- 			"<leader>glC",
	-- 			gitlab.create_comment_suggestion,
	-- 			{ desc = "GitLab: Create Comment Suggestion" }
	-- 		)
	-- 		vim.keymap.set("n", "<leader>glO", gitlab.create_mr, { desc = "GitLab: Create MR" })
	-- 		vim.keymap.set(
	-- 			"n",
	-- 			"<leader>glm",
	-- 			gitlab.move_to_discussion_tree_from_diagnostic,
	-- 			{ desc = "GitLab: Move To Discussion Tree from Diagnostic" }
	-- 		)
	-- 		vim.keymap.set("n", "<leader>gln", gitlab.create_note, { desc = "GitLab: Create Note" })
	-- 		vim.keymap.set("n", "<leader>gld", gitlab.toggle_discussions, { desc = "GitLab: Toggle Discussions" })
	-- 		vim.keymap.set("n", "<leader>glaa", gitlab.add_assignee, { desc = "GitLab: Add Assignee" })
	-- 		vim.keymap.set("n", "<leader>glad", gitlab.delete_assignee, { desc = "GitLab: Delete Assignee" })
	-- 		vim.keymap.set("n", "<leader>glla", gitlab.add_label, { desc = "GitLab: Add Label" })
	-- 		vim.keymap.set("n", "<leader>glld", gitlab.delete_label, { desc = "GitLab: Delete Label" })
	-- 		vim.keymap.set("n", "<leader>glra", gitlab.add_reviewer, { desc = "GitLab: Add Reviewer" })
	-- 		vim.keymap.set("n", "<leader>glrd", gitlab.delete_reviewer, { desc = "GitLab: Delete Reviewer" })
	-- 		vim.keymap.set("n", "<leader>glp", gitlab.pipeline, { desc = "GitLab: Pipeline" })
	-- 		vim.keymap.set("n", "<leader>glo", gitlab.open_in_browser, { desc = "GitLab: Open in Browser" })
	-- 		vim.keymap.set("n", "<leader>glM", gitlab.merge, { desc = "GitLab: Merge" })
	-- 		vim.keymap.set("n", "<leader>glu", gitlab.copy_mr_url, { desc = "GitLab: Copy MR URL" })
	-- 		vim.keymap.set("n", "<leader>glP", gitlab.publish_all_drafts, { desc = "GitLab: Publish All Drafts" })
	-- 	end,
	-- },
}
