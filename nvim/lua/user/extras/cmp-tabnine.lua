local M = {"tzachar/cmp-tabnine", event = "InsertEnter", build = "./install.sh"}

function M.config()
    require("cmp_tabnine.config"):setup{
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = {html = true},
        show_prediction_strength = false,
    }

end

return M
