return {
    "mfussenegger/nvim-dap",
    event = "BufRead",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "folke/neodev.nvim",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local virtual_text = require("nvim-dap-virtual-text")
        local dap_go = require("dap-go")

        dapui.setup()
        virtual_text.setup()
        dap_go.setup()
    end
}
