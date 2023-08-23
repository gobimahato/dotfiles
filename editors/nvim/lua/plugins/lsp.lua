return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = "BufRead",
        cmd = {
            "TSBufDisable", "TSBufEnable", "TSBufToggle", "TSDisable",
            "TSEnable", "TSToggle", "TSInstall", "TSInstallInfo",
            "TSInstallSync", "TSModuleInfo", "TSUninstall", "TSUpdate",
            "TSUpdateSync"
        },
        build = function()
            local status_ok, ts = pcall(require, "nvim-treesitter.install")
            if not status_ok then return end
            ts.update({with_sync = true})()
        end,
        config = function()
            local status_ok, _ = pcall(require, "nvim-treesitter")
            if not status_ok then return end
            require("user.treesitter")
        end
    }, {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        event = "BufRead",
        dependencies = "nvim-treesitter/nvim-treesitter"
    }, {
        "p00f/nvim-ts-rainbow",
        event = "BufRead",
        dependencies = "nvim-treesitter/nvim-treesitter"
    }, {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        event = "BufRead",
        config = function() require("symbols-outline").setup() end
    }, {
        "ErichDonGubler/lsp_lines.nvim",
        event = "BufRead",
        config = function()
            require("lsp_lines").setup()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"*"},
                callback = function()
                    local exclude_ft = {"lazy"}
                    if vim.tbl_contains(exclude_ft, vim.o.filetype) then
                        vim.diagnostic.config({virtual_lines = false})
                    else
                        vim.diagnostic.config({virtual_lines = true})
                    end
                end
            })
        end
    }, {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("user.snippets")
            end
        },
        opts = {history = true, delete_check_events = "TextChanged"},
        -- stylua: ignore
        keys = {
            {"<tab>", function() require("luasnip").jump(1) end, mode = "s"},
            {
                "<s-tab>",
                function() require("luasnip").jump(-1) end,
                mode = {"i", "s"}
            }
        }
    }, {"williamboman/nvim-lsp-installer", event = "VeryLazy", lazy = true}, {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {"williamboman/mason-lspconfig.nvim"},
        config = function() require("user.lsp") end
    }, {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = "Mason",
        keys = {{"<leader>cm", "<cmd>Mason<cr>", desc = "Mason"}}
    }, -- for formater linter
    {
        "jayp0521/mason-null-ls.nvim",
        lazy = true,
        dependencies = "jose-elias-alvarez/null-ls.nvim",
        event = "BufRead",
        opts = function() require("user.mason-null-ls") end
    }, -- debuging
    {
        "rcarriga/nvim-dap-ui",
        event = "BufWinEnter",
        dependencies = "mfussenegger/nvim-dap",
        enabled = vim.fn.has("win32") == 0,
        config = function() require("user.dapui") end
    }, {
        "jayp0521/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
        enabled = vim.fn.has("win32") == 0,
        init = function() require("user.mason_dap") end
    }
}
