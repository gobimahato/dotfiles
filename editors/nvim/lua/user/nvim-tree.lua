vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local icons = require("user.icons")

nvim_tree.setup({
    hijack_directories = {enable = false},
    update_cwd = true,
    -- disable_netrw = true,
    -- hijack_netrw = true,
    -- hijack_cursor = true,
    -- hijack_unnamed_buffer_when_opening = false,
    -- sync_root_with_cwd = true,
    update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},

    filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {"node_modules", "\\.cache", "\\.git"},
        exclude = {".gitignore"}
    },

    view = {
        adaptive_size = false,
        width = 30,
        side = "left",
        hide_root_folder = false,
        preserve_window_proportions = true
    },

    -- git = {enable = false, ignore = true},
    git = {enable = true, ignore = true, timeout = 500},

    actions = {open_file = {resize_window = true}},

    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":t",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " "
            }
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                git = false,
                folder = true,
                file = true,
                folder_arrow = true
            },
            glyphs = {
                default = icons.ui.Text,
                symlink = icons.ui.FileSymlink,
                bookmark = icons.ui.BookMark,

                folder = {
                    arrow_open = icons.ui.ChevronShortDown,
                    arrow_closed = icons.ui.ChevronShortRight,
                    default = icons.ui.Folder,
                    empty = icons.ui.EmptyFolder,
                    empty_open = icons.ui.EmptyFolderOpen,
                    open = icons.ui.FolderOpen,
                    symlink = icons.ui.FolderSymlink,
                    symlink_open = icons.ui.FolderSymlink
                },
                git = {
                    deleted = icons.git.FileDeleted,
                    ignored = icons.git.FileIgnored,
                    renamed = icons.git.FileRenamed,
                    staged = icons.git.FileStaged,
                    unmerged = icons.git.FileUnmerged,
                    unstaged = icons.git.FileUnstaged,
                    untracked = icons.git.FileUntracked
                }
            }
        },
        special_files = {"Cargo.toml", "Makefile", "README.md", "readme.md"},
        symlink_destination = true
    },

    diagnostics = {
        enable = true,
        -- show_on_dirs = true,
        icons = {
            hint = icons.diagnostics.BoldHint,
            info = icons.diagnostics.BoldInformation,
            warning = icons.diagnostics.BoldWarning,
            error = icons.diagnostics.BoldError
        }
    }

})
