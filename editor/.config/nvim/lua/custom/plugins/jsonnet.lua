return {
	{
		"Duologic/nvim-jsonnet",
		config = function()
			local nvim_jsonnet = require("nvim-jsonnet")
			nvim_jsonnet.setup({
				-- Opinionated defaults
				-- jsonnet_bin = "tk",
				-- jsonnet_args = { "eval" },
				jsonnet_string_bin = "jsonnet",
				jsonnet_string_args = { "-S", "-J", "vendor", "-J", "lib" },
				use_tanka_if_possible = true,

				-- default to false to not break existing installs
				load_lsp_config = false,
				-- Pass along nvim-cmp capabilities if you use that.
				capabilities = require("cmp_nvim_lsp").default_capabilities(),

				-- default to false to not break existing installs
				load_dap_config = false,
				jsonnet_debugger_bin = "jsonnet-debugger",
				jsonnet_debugger_args = { "-s", "-d", "-J", "vendor", "-J", "lib" },
			})

			vim.keymap.set("n", "<leader>cj", "<CMD>vertical JsonnetEval<CR>", { desc = "Compile Jsonnet" })

			-- vim.wo.foldmethod = "expr"
			-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			-- vim.wo.foldlevel = 1000
			-- vim.wo.foldlevelstart = 20
		end,
	},
}
