return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function() require("user.alpha") end
    }, {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function() require("user.project") end
    }, {
        "nvim-lualine/lualine.nvim",
        event = "BufRead",
        config = function() require("user.lualine") end
    }, {
        "kyazdani42/nvim-web-devicons",
        dependencies = {"DaikyXendo/nvim-material-icon"},
        event = "BufRead",
        config = function() require("user.webdevicons") end
    }, {
        "kyazdani42/nvim-tree.lua",
        event = "InsertEnter",
        cmd = {"NvimTree", "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose"},
        config = function()
            local data_exists, treeconfig = pcall(require, "core.config")
            if data_exists then
                if treeconfig.loadnvimtree_lazy then
                    require("user.nvim-tree")
                end
            end
        end
    }, {
        "NvChad/nvim-colorizer.lua",
        event = "BufRead",
        opts = function() require("user.colorizer") end
    }, {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({silent = true, pending = true})
                end,
                desc = "Delete all Notifications"
            }
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end
        },
        init = function()
            local notify = require("notify")

            notify.setup({background_colour = "#000000"})
            vim.notify = notify.notify
        end
    }, {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        config = function() require("user.smartspit") end
    }, {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({plugins = {"dressing.nvim"}})
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({plugins = {"dressing.nvim"}})
                return vim.ui.input(...)
            end
        end
    }, {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            -- options
        }
    }, {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function() require("user.indentline") end
    }, {
        "windwp/nvim-autopairs",
        lazy = true,
        dependencies = "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function() require("user.autopairs") end
    }, {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function() require("user.zen-mode") end
    }, {
        "christianchiarulli/harpoon",
        event = "BufRead",
        config = function() require("user.harpoon") end
    }, {
        "karb94/neoscroll.nvim",
        event = "BufRead",
        config = function() require("user.neoscroll") end
    }, {
        "echasnovski/mini.indentscope",
        version = false,
        event = "BufReadPre",
        opts = {symbol = "│", options = {try_as_border = true}},
        config = function(_, opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy",
                    "mason"
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end
            })
            require("mini.indentscope").setup(opts)
        end
    }, {
        "folke/todo-comments.nvim",
        event = {"BufReadPost", "BufNewFile"},
        config = function() require("todo-comments").setup() end
    }

}

