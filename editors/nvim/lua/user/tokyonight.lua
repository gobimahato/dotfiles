local status_ok, tokyonight = pcall(require, "tokyonight")

if not status_ok then return end
local sidebar = "dark"
local data_exists, config = pcall(require, "core.config")

tokyonight.setup({
    style = "night",
    terminal_colors = true,
    styles = {
        comments = {italic = true},
        keywords = {italic = true},
        functions = {bold = true},
        variables = {},
        sidebars = sidebar,
        floats = sidebar
    },
    sidebars = {"qf", "help"},
    day_brightness = 0.2,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    ---@param colors ColorScheme
    on_colors = function(colors) end,

    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)
        highlights.NvimTreeFolderIcon = {bg = colors.none, fg = "#e0af68"}
    end
})
