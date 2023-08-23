return {
    {"hrsh7th/cmp-nvim-lsp", event = "BufRead"},
    {"hrsh7th/cmp-buffer", event = "BufRead"},
    {"hrsh7th/cmp-path", event = "BufRead"},
    {"saadparwaiz1/cmp_luasnip", event = "BufRead"},
    {"hrsh7th/cmp-nvim-lua", event = "BufRead"}, {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function() require("user.cmp") end
    }, {
        "tzachar/cmp-tabnine",
        event = "InsertEnter",
        build = "./install.sh",
        dependencies = 'hrsh7th/nvim-cmp',
        config = function() require("user.tabnine") end

    }
}
