-- Core Plugins
require("user.core.launch")
require("user.core.options")
require("user.core.keymaps")
require("user.core.autocmds")

-- UI Plugins
spec("user.UI.colorscheme")
spec("user.UI.aura-theme")
spec("user.UI.devicons")

-- Main Plugins
spec("user.alpha")
spec("user.autopairs")
spec("user.autosession")
spec("user.autotag")
spec("user.breadcrumbs")
spec("user.bufdelete")
spec("user.cmp")
spec("user.comment")
spec("user.dap")
spec("user.gitsigns")
spec("user.harpoon")
spec("user.indentline")
spec("user.lspconfig")
spec("user.lualine")
spec("user.mason")
spec("user.navic")
spec("user.neogit")
spec("user.noice")
spec("user.null-ls")
spec("user.nvimtree")
spec("user.project")
spec("user.schemastore")
spec("user.telescope")
spec("user.toggleterm")
spec("user.treesitter")
spec("user.whichkey")
spec("user.zen-mode")

-- Extra Plugings
spec("user.extras.auto-save")
spec("user.extras.bqf");
spec("user.extras.cellular-automaton");
spec("user.extras.cmp-tabnine");
spec("user.extras.code_runner")
spec("user.extras.colorizer")
spec("user.extras.extras")
spec("user.extras.dial");
spec("user.extras.fidget")
spec("user.extras.illuminate");
spec("user.extras.lab");
spec("user.extras.modicator")
spec("user.extras.navbuddy")
spec("user.extras.neoscroll")
spec("user.extras.neotab");
spec("user.extras.numb");
spec("user.extras.oil");
spec("user.extras.rainbow")
spec("user.extras.surround")
spec("user.extras.tabby")
spec("user.extras.neotest")
spec("user.extras.telescope-tabs")
spec("user.extras.todo-comments");
spec("user.extras.trouble")
spec("user.extras.tsc")
spec("user.extras.ufo");
spec("user.extras.various-textobjs");

-- Lazy Plugin Manager
require("user.core.lazy")
