local M = {"rmagatti/auto-session"}

function M.config()
    vim.o.sessionoptions =
        "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup {
        log_level = vim.log.levels.ERROR,
        auto_session_suppress_dirs = {"~/", "~/Downloads", "/"},
        auto_session_use_git_branch = false,
        auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
        auto_session_enable_last_session = false,
        bypass_session_save_file_types = {"alpha", "NvimTree"},

        session_lens = {
            load_on_setup = true,
            theme_conf = {border = true},
            previewer = false
        }
    }
    -- vim.keymap.set("n", "<C-s>",
    --                require("auto-session.session-lens").search_session,
    --                {noremap = true})
end

return M
