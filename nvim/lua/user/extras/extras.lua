local M = {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            {"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"}
        },
        event = "BufEnter"
    }, {"ThePrimeagen/vim-be-good", cmd = "VimBeGood"}

}

return M
