local tokyonight = false
local onedark = false

local onedark_style = "dark"

_G.switch = function(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table["default"]
    return def and def() or nil
end

local data_exists, config = pcall(require, "core.config")
if data_exists then
    if config.colorscheme ~= nil then
        local color = config.colorscheme
        switch(color, {
            ["tokyonight"] = function()
                gruvbox = false
                tokyonight = true
            end,
            ["tokyonight-night"] = function()
                gruvbox = false
                tokyonight = true
            end,
            ["tokyonight-storm"] = function()
                gruvbox = false
                tokyonight = true
            end,
            ["tokyonight-day"] = function()
                gruvbox = false
                tokyonight = true
            end,
            ["tokyonight-moon"] = function()
                gruvbox = false
                tokyonight = true
            end,
            ["onedark"] = function()
                gruvbox = false
                onedark = true
            end,
            ["onedark_darker"] = function()
                gruvbox = false
                onedark = true
                onedark_style = "darker"
            end,
            ["onedark_cool"] = function()
                gruvbox = false
                onedark = true
                onedark_style = "cool"
            end,
            ["onedark_deep"] = function()
                gruvbox = false
                onedark = true
                onedark_style = "deep"
            end,
            ["onedark_warm"] = function()
                gruvbox = false
                onedark = true
                onedark_style = "warm"
            end,
            ["onedark_warmer"] = function()
                gruvbox = false
                onedark = true
                onedark_style = "warmer"
            end,
            ["onedark_light"] = function()
                gruvbox = false
                onedark = true
                onedark_style = "light"
            end,
            default = function() gruvbox = true end
        })
    end
end

return {
    -- color scheme
    {
        "folke/tokyonight.nvim",
        enabled = tokyonight,
        config = function() require("user.tokyonight") end
    }, {
        "navarasu/onedark.nvim",
        enabled = onedark,
        priority = 1000,
        config = function()
            -- Lua
            require("onedark").setup({
                style = onedark_style,
                highlights = {},
                transparent = transparent,
                lualine = {transparent = transparent}
            })
            require("onedark").load()
        end
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000
    }
}
