-- =============================
-- =    Debug Setup (DAP)
-- =============================
return {
    {
        -- VSCode like debug UI
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

-- Debug settings from old setup. Convert to lazy.nvim.
-- local DAP = require('dap')
-- local DAPUI = require('dapui')
--
-- -- Configure dap-ui to auto open/close with DAP
-- DAP.listeners.after.event_initialized["dapui_config"] = function()
--     DAPUI.open()
-- end
-- DAP.listeners.before.event_terminated["dapui_config"] = function()
--     DAPUI.close()
-- end
-- DAP.listeners.before.event_exited["dapui_config"] = function()
--     DAPUI.close()
-- end
--
-- DAPUI.setup()
--
--
-- require('dap-python').setup(
--     '/Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10'
-- )
--
--
-- -- require("neotest").setup({
-- --     adapters = {
-- --         -- neotest-python does not have a setup function
-- --         require("neotest-python")({})
-- --     }
-- -- })
