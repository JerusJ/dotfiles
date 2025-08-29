return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },

		init = function()
			-- Folding available, but start fully open
			vim.opt.foldenable = true
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldcolumn = "0"

			-- Safety: if anything resets it on open (sessions/filetype plugins), re-open
			vim.api.nvim_create_autocmd({ "BufReadPost", "FileType" }, {
				callback = function()
					if vim.wo.foldlevel < 99 then
						vim.wo.foldlevel = 99
					end
				end,
			})
		end,

		config = function()
			require("ufo").setup({
				open_fold_hl_timeout = 0,
				-- Prevent UFO from auto-folding new buffers
				close_fold_kinds = {}, -- << key line
				provider_selector = function(_, _, _)
					return { "treesitter", "indent" }
				end,
			})

			-- Optional: convenience maps
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		end,
	},
}
