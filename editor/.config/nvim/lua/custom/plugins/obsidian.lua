return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local obsidian = require("obsidian")

		obsidian.setup({
			open_notes_in = "vsplit",

			-- otherwise this is some WHACKY RANDOM ID, "Zettelkasten" format... The heck?
			note_id_func = function(title)
				return title
			end,

			workspaces = {
				{
					name = "personal",
					path = "~/vaults/personal",
				},
				{
					name = "work",
					path = "~/vaults/work",
				},
			},
			templates = {
				folder = "templates",
				date_format = "%Y-%m-%d-%a",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},
		})

		vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<cr>")
		vim.keymap.set("n", "<leader>ns", "<cmd>ObsidianSearch<cr>")
		vim.keymap.set("n", "<leader>nb", "<cmd>ObsidianQuickSwitch<cr>")
		vim.keymap.set("n", "<leader>np", "<cmd>ObsidianPasteImg<cr>")
	end,
}
