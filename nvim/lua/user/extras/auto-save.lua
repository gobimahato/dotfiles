local M = {"Pocco81/auto-save.nvim", event = "VimEnter"}

function M.config()

    require("auto-save").setup {
        enabled = true,
        trigger_events = {"InsertLeave", "TextChanged"},
        execution_message = {
            message = function()
                return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
            end,
            dim = 0.18,
            cleaning_interval = 1250
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 1000,
        debounce_delay = 135
    }

end

return M
