local M = {
   "baliestri/aura-theme",
    lazy = false,
    priority = 1000
}

function M.config(plugin)
    vim.cmd.colorscheme "aura-dark"
    vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    
end

return M
