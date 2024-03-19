local M = {"eandrju/cellular-automaton.nvim"}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>y"] = {"<cmd>CellularAutomaton game_of_life<CR>", "Cellular Automaton"}
    }
end

return M
