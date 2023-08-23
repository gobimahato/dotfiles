require("onedark").setup({
    style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,

    -- toggle theme style ---
    toggle_style_key = nil, --
    toggle_style_list = {
        "dark", "darker", "cool", "deep", "warm", "warmer", "light"
    },

    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "bold",
        strings = "none",
        variables = "none"
    },

    -- custom colors
    colors = {},
    highlights = {},

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true -- use background color for virtual text
    }
})
