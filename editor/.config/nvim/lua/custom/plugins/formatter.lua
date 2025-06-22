return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.saltlint,

					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.clang_format,
					-- null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.hclfmt,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.mdformat,
					null_ls.builtins.formatting.packer,
					null_ls.builtins.formatting.shellharden,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.formatting.terragrunt_fmt,
					null_ls.builtins.formatting.rubyfmt,
				},
			})
		end,
	},
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {}, -- needed even when using default config

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
}
