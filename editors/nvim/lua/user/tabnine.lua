local tabnine = require("cmp_tabnine.config")

tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    ignored_file_types = {
        ["aerial"] = true,
        ["checkhealth"] = true,
        ["dap-repl"] = true,
        ["dapui_breakpoints"] = true,
        ["dapui_console"] = true,
        ["dapui_hover"] = true,
        ["dapui_scopes"] = true,
        ["dapui_stacks"] = true,
        ["dapui_watches"] = true,
        ["DressingInput"] = true,
        ["DressingSelect"] = true,
        ["html"] = true,
        ["fern"] = true,
        ["lazy"] = true,
        ["lspinfo"] = true,
        ["mason"] = true,
        ["nerdterm"] = true,
        ["noice"] = true,
        ["notify"] = true,
        ["null-ls-info"] = true,
        ["qf"] = true,
        ["TelescopePrompt"] = true
    },
    show_prediction_strength = true

})

