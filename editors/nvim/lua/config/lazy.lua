local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.diagnostic.config({virtual_lines = false})
require("lazy").setup({
    spec = {{import = "plugins"}, {import = "custom.plugins"}},
    defaults = {lazy = true, version = "*"},
    ui = {
        border = "rounded",
        browser = "chrome",
        throttle = 40,
        custom_keys = {["<localleader>l"] = false}
    },
    change_detection = {enabled = false, notify = false},
    checker = {enabled = true},
    performance = {
        rtp = {
            -- disable some plugins
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin",
                "tohtml", "tutor", "zipPlugin", "lazyredraw"
            }
        }
    }
})
