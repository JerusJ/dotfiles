return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"leoluz/nvim-dap-go",
		},
		config = function()
			require("go").setup()
			require("go.format").goimports() -- goimports + gofmt
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
