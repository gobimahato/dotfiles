local opts, _ = pcall(require, "user.options")
if opts then require("user.options") end
local cmd, _ = pcall(require, "user.autocommands")
if cmd then require("user.autocommands") end

return {}
