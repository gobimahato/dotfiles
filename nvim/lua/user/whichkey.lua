local M = {"folke/which-key.nvim", event = "VeryLazy"}

function M.config()
    local mappings = {
        q = {"<cmd>confirm q<CR>", "Quit"},
        S = {
            require("auto-session.session-lens").search_session, "Auto Session"
        },
        H = {"<cmd>nohlsearch<CR>", "NOHL"},
        o = {"<cmd>Oil --float<CR>", "Oil", {desc = "Open parent directory"}},
        r = {"<cmd>RunFile<CR>", "Code Runner"},
        p = {"<cmd>Telescope find_files<cr>", "Find Files"},
        d = {
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            "Trouble Diagnostics"
        },
        t = {name = "Test"},
        b = {name = "Buffers"},
        d = {name = "Debug"},
        f = {name = "Find"},
        g = {name = "Git"},
        l = {name = "LSP"},
        a = {
            name = "Tab",
            n = {"<cmd>$tabnew<cr>", "New Empty Tab"},
            N = {"<cmd>tabnew %<cr>", "New Tab"},
            o = {"<cmd>tabonly<cr>", "Only"},
            h = {"<cmd>-tabmove<cr>", "Move Left"},
            l = {"<cmd>+tabmove<cr>", "Move Right"}
        }
    }

    local which_key = require "which-key"
    which_key.setup {
        plugins = {
            marks = true,
            registers = true,
            spelling = {enabled = true, suggestions = 20},
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false
            }
        },
        operators = {gc = "Comments"},
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "⚡" -- symbol prepended to a group
        },
        window = {
            border = "rounded",
            position = "bottom",
            margin = {1, 0, 1, 0},
            padding = {2, 2, 2, 2},
            winblend = 0
        },
        layout = {
            height = {min = 4, max = 25},
            width = {min = 30, max = 50},
            spacing = 5,
            align = "center"
        },
        ignore_missing = true,
        hidden = {
            "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "
        }, -- hide mapping boilerplate
        triggers = "auto",
        show_help = false,
        show_keys = false,
        triggers_blacklist = {i = {"j", "k"}, v = {"j", "k"}},
        disable = {buftypes = {}, filetypes = {"TelescopePrompt"}}
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true -- use `nowait` when creating keymaps
    }

    which_key.register(mappings, opts)
end

return M
