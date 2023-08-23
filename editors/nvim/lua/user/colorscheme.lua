local colorscheme = "onedark"
local lst_onedark = {
    "onedark", "onedark_darker", "onedark_cool", "onedark_deep", "onedark_warm",
    "onedark_warmer", "onedark_light"
}
local data_exists, config = pcall(require, "core.config")
if data_exists then
    if config.colorscheme ~= nil then
        colorscheme = config.colorscheme
    else
        colorscheme = "onedark"
    end
end

for _, v in pairs(lst_onedark) do
    if v == colorscheme then
        colorscheme = "onedark"
        break
    end
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    local ok, _ = pcall(vim.cmd, "colorscheme " .. "onedark")
    if not ok then return end
end

