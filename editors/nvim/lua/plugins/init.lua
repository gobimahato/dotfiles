return {
    {
        "Pocco81/auto-save.nvim",
        event = "VimEnter",
        config = function()
            require("auto-save").setup({
                enabled = true,
                trigger_events = {"InsertLeave", "TextChanged"},
                execution_message = {
                    message = function()
                        return ("AutoSave: saved at " ..
                                   vim.fn.strftime("%H:%M:%S"))
                    end,
                    dim = 0.18,
                    cleaning_interval = 1250
                },
                write_all_buffers = false,
                on_off_commands = true,
                clean_command_line_interval = 1000,
                debounce_delay = 135
            })
        end
    }, {"nvim-lua/plenary.nvim", lazy = true}, {
        "numToStr/Comment.nvim",
        event = "BufRead",
        config = function() require("user.comment") end
    }, {
        "lewis6991/impatient.nvim",
        event = "VeryLazy",
        config = function() require("user.impatient") end
    }, {"mg979/vim-visual-multi", event = "BufRead"}, {
        "windwp/nvim-ts-autotag",
        event = "BufRead",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function() require("nvim-ts-autotag").setup() end
    }, {
        "CRAG666/code_runner.nvim",
        event = "BufRead",
        cmd = {"RunCode", "RunFile", "RunProject", "RunClose"},
        config = function() require("user.coderunner") end
    }, {
        "lewis6991/gitsigns.nvim",
        enabled = vim.fn.executable("git") == 1,
        ft = "gitcommit",
        event = "BufRead",
        config = function() require("user.gitsigns") end
    }, {"tpope/vim-repeat", event = "VeryLazy"},
    {"dstein64/vim-startuptime", cmd = "StartupTime", event = "BufRead"},

    {"moll/vim-bbye", event = "BufRead"}, {
        "folke/trouble.nvim",
        event = "BufRead",
        cmd = {"TroubleToggle", "Trouble"},
        opts = {use_diagnostic_signs = true},
        keys = {
            {
                "<leader>xx",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc = "Document Diagnostics (Trouble)"
            }, {
                "<leader>xX",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc = "Workspace Diagnostics (Trouble)"
            }
        }
    }, {
        "akinsho/toggleterm.nvim",
        cmd = "Toggleterm",
        event = "VeryLazy",
        config = function() require("user.toggleterm") end
    }, {
        "kylechui/nvim-surround",
        cmd = "InsertEnter",
        event = "VeryLazy",
        config = function() require("user.surround") end
    }, {
        "windwp/nvim-spectre",
        event = "VeryLazy",
        config = function() require("user.spectre") end
    }, {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false,
        config = function() require("user.telescope") end
    }, {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function() require("user.whichkey") end
    }

    -- {"famiu/bufdelete.nvim", event = "BufRead"},
    --  {
    --     "akinsho/bufferline.nvim",
    --     event = "BufRead",
    --     config = function() require("user.bufferline") end
    -- }, 
}
