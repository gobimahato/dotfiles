local M = {
    "CRAG666/code_runner.nvim",
    event = "BufRead",
    cmd = {"RunCode", "RunFile", "RunProject", "RunClose"}
}

local rfile = {
    cpp = "g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
    go = "go run $fileName",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    python = "python3 -u",
    javascript = "node $dir/$fileName",
    typescript = "deno run",
	scss = "sass $dir/$fileName $dir/$fileNameWithoutExt.css",

}

function M.config()

    require("code_runner").setup {
        filetype = rfile,
        mode = "float",
        focus = true,
        startinsert = true,
        term = {position = "bot", size = 50},
        float = {
            close_key = "<ESC>",
            border = "rounded",
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
            border_hl = "FloatBorder",
            float_hl = "Normal",
            blend = 0
        }
    }

end

return M
