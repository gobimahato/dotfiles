local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end

local setup = {
    plugins = {
        marks = false,
        registers = false,
        spelling = {enabled = true, suggestions = 20},
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true,
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = false
        }
    },
    operators = {gc = "Comments"},

    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "⚡" -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>" -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = {min = 4, max = 25},
        width = {min = 30, max = 50},
        spacing = 5,
        align = "center"
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true,
    show_keys = true,
    triggers = "auto",
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        i = {"j", "k"},
        v = {"j", "k"}
    },
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

local opts2 = {
    mode = "v", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true -- use `nowait` when creating keymaps
}

local trn = ""
if vim.fn.has("win32") == 1 then trn = "pwsh<cr>" end
-- for debug
local debug_key = {}
-- local is_dap = pcall(require, "dap")

if vim.fn.has("win32") == 0 then
    debug_key = {
        name = "Debug",
        t = {
            "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"
        },
        b = {"<cmd>lua require'dap'.step_back()<cr>", "Step Back"},
        c = {"<cmd>lua require'dap'.continue()<cr>", "Continue"},
        C = {"<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor"},
        d = {"<cmd>lua require'dap'.disconnect()<cr>", "Disconnect"},
        g = {"<cmd>lua require'dap'.session()<cr>", "Get Session"},
        i = {"<cmd>lua require'dap'.step_into()<cr>", "Step Into"},
        o = {"<cmd>lua require'dap'.step_over()<cr>", "Step Over"},
        u = {"<cmd>lua require'dap'.step_out()<cr>", "Step Out"},
        p = {"<cmd>lua require'dap'.pause()<cr>", "Pause"},
        r = {"<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl"},
        s = {"<cmd>lua require'dap'.continue()<cr>", "Start"},
        q = {"<cmd>lua require'dap'.close()<cr>", "Quit"},
        U = {"<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI"}
    }
end
-- end debug

local mappings = {
    ["a"] = {'<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon Mark"},
    ["b"] = {"<cmd>Telescope buffers<cr>", "Buffers"},
    ["e"] = {"<cmd>NvimTreeToggle<cr>", "Explorer"},
    -- ["H"] = {"<cmd>nohlsearch<CR>", "No Highlight"},
    -- ["S"] = {"<cmd>ASToggle<CR>", "Auto Save"},
    ["p"] = {"<cmd>Telescope find_files<cr>", "Find files"},
    ["q"] = {"<cmd>lua require('user.functions').smart_quit()<CR>", "Quit"},
    ["r"] = {"<cmd>RunFile<CR>", "Code Runner"},

    ["/"] = {
        function() require("Comment.api").toggle.linewise.current() end,
        "Comment line"
    },

    g = {
        name = "Git",
        g = {"<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit"},
        j = {"<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk"},
        k = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk"},
        l = {"<cmd>GitBlameToggle<cr>", "Blame"},
        p = {"<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk"},
        r = {"<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk"},
        R = {"<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer"},
        s = {"<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk"},
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk"
        },
        n = {":!git checkout -b ", "Checkout New Branch"},
        o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        f = {"<cmd>Telescope git_bcommits<cr>", "Checkout buffer commit"},
        d = {"<cmd>Gitsigns diffthis HEAD<cr>", "Diff"}
    },

    l = {
        name = "LSP",
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
        d = {"<cmd>TroubleToggle<cr>", "Diagnostics"},
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics"
        },
        f = {"<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        I = {"<cmd>LspInstallInfo<cr>", "Installer Info"},
        j = {
            "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
            "Next Diagnostic"
        },
        k = {
            "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
            "Prev Diagnostic"
        },
        v = {"<cmd>lua require('lsp_lines').toggle()<cr>", "Lsp Virtual Text"},
        l = {"<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action"},
        o = {"<cmd>SymbolsOutline<cr>", "Outline"},
        q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix"},
        r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        R = {"<cmd>TroubleToggle lsp_references<cr>", "References"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols"
        },
        t = {
            '<cmd>lua require("user.functions").toggle_diagnostics()<cr>',
            "Toggle Diagnostics"
        }

    },

    f = {
        name = "Find",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        t = {"<cmd>Telescope live_grep<cr>", "Find Text"},
        s = {"<cmd>Telescope grep_string<cr>", "Find String"},
        h = {"<cmd>Telescope help_tags<cr>", "Help"},
        H = {"<cmd>Telescope highlights<cr>", "Highlights"},
        l = {"<cmd>Telescope resume<cr>", "Last Search"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<cr>", "Recent File"},
        R = {"<cmd>Telescope registers<cr>", "Registers"},
        k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
        C = {"<cmd>Telescope commands<cr>", "Commands"}
    },

    h = {
        name = "Harpoon",
        p = {
            '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
            "Harpoon List "
        },
        n = {'<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next"},
        p = {'<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev"},
        s = {"<cmd>Telescope harpoon marks<cr>", "Search Files"}

    },

    R = {
        name = "Replace",
        r = {"<cmd>lua require('spectre').open()<cr>", "Replace"},
        w = {
            "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
            "Replace Word"
        },
        f = {
            "<cmd>lua require('spectre').open_file_search()<cr>",
            "Replace Buffer"
        }

    },

    t = {
        name = "Terminal",
        f = {"<cmd>ToggleTerm direction=float<cr>" .. trn, "Float"},
        h = {"<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal"},
        v = {
            "<cmd>ToggleTerm size=80 direction=vertical<cr>" .. trn, "Vertical"
        }
    },

    T = {
        name = "Tab",
        n = {"<cmd>tabnew %<cr>", "New Tab"},
        c = {"<cmd>tabclose<cr>", "Close Tab"},
        o = {"<cmd>tabonly<cr>", "Only Tab"}
    }

}

local wkey = {}
local data_exists, key = pcall(require, "core.config")
if data_exists then wkey = key.whichkey end

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(wkey, opts)
