local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"williamboman/mason.nvim", "nvim-lua/plenary.nvim"}
}

M.execs = {
    "lua_ls", "cssls", "html", "tsserver", "jsonls", "yamlls", "marksman",
    "tailwindcss", "eslint"
}

function M.config()
    local wk = require "which-key"
    wk.register {["<leader>lI"] = {"<cmd>Mason<cr>", "Mason Info"}}

    require("mason").setup {ui = {border = "rounded"}}
    require("mason-lspconfig").setup {ensure_installed = M.execs}
end

return M
