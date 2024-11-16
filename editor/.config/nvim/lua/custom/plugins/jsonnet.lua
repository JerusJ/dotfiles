return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"Myzel394/easytables.nvim",
			"Myzel394/telescope-last-positions",
			"Myzel394/jsonfly.nvim",
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
	},
	{
		"Duologic/nvim-jsonnet",
		config = function()
			local nvim_jsonnet = require("nvim-jsonnet")
			nvim_jsonnet.setup({
				-- Opinionated defaults
				-- jsonnet_bin = "jsonnet",
				-- jsonnet_args = { "-J", "vendor", "-J", "lib" },
				-- jsonnet_string_bin = "jsonnet",
				-- jsonnet_string_args = { "-S", "-J", "vendor", "-J", "lib" },
				use_tanka_if_possible = true,

				-- default to false to not break existing installs
				load_lsp_config = true,
				-- Pass along nvim-cmp capabilities if you use that.
				capabilities = require("cmp_nvim_lsp").default_capabilities(),

				-- default to false to not break existing installs
				load_dap_config = true,
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
