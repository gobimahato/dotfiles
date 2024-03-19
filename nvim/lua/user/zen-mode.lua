local M = {"folke/zen-mode.nvim", event = "VeryLazy"}

function M.config()

    require("zen-mode").setup {
        window = {
            backdrop = 1,
            height = 0.9,
            -- width = 0.5,
            width = 80,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                cursorline = true,
                cursorcolumn = false -- disable cursor column
                -- foldcolumn = "0", -- disable fold column
                -- list = false, -- disable whitespace characters
            }
        },
        plugins = {
            gitsigns = {enabled = false},
            tmux = {enabled = false},
            twilight = {enabled = false}
        }
    }

end

return M
