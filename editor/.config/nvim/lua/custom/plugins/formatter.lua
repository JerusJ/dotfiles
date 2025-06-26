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
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.black,
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
		"kevinhwang91/nvim-ufo",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
		dependencies = { "kevinhwang91/promise-async" },
	},
}
