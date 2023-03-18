-- =============================
-- =    Debug Setup (DAP)
-- =============================
return {
    { -- VSCode like debug UI
        "rcarriga/nvim-dap-ui",
        dependencies = {
            { "mfussenegger/nvim-dap" },
            { "mfussenegger/nvim-dap-python" },
        },
        cmd = { "DapContinue" }, -- TODO: may want to change these commands
    },
    {
        "nvim-neotest/neotest",
        cmd = { "DapContinue" }, -- TODO: load when DapUI loads
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            -- Debug adapters
            { "nvim-neotest/neotest-python" },
        }
    },
}
