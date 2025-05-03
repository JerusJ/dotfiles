return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- NOTE(jesse): https://github.com/nvimtools/none-ls.nvim?tab=readme-ov-file#setup
		local null_ls = require("null-ls")
		null_ls.setup({
			-- NOTE(jesse): list of them are here: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
			sources = {
				null_ls.builtins.diagnostics.saltlint,

				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.hclfmt,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.mdformat,
				null_ls.builtins.formatting.packer,
				null_ls.builtins.formatting.shellharden,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.formatting.terragrunt_fmt,
				null_ls.builtins.formatting.yamlfmt,
			},
		})
	end,
}
