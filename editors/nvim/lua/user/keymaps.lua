local opts = {noremap = true, silent = true}
local term_opts = {silent = true}
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-p>", ":bprevious<CR>", opts)
keymap("n", "<S-n>", ":bnext<CR>", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Split window
keymap("n", "sh", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<S-Down>", ":'<,'>t'><cr>", opts)

-- copy & save 
keymap("n", "<S-Down>", "<cmd>t.<cr>", opts)
keymap("i", "<S-Down>", "<cmd>t.<cr>", opts)
keymap("n", "<S-Up>", "<cmd>t -1<cr>", opts)
keymap("i", "<S-Up>", "<cmd>t -1<cr>", opts)

keymap("i", "<C-s>", "<cmd>w<cr>", opts)
keymap("n", "<C-s>", "<cmd>w<cr>", opts)

-- quit
keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<A-q>", "<cmd>q<cr>", opts)

-- tab
keymap("n", "<A-n>", "gt", opts)

-- plugins
keymap("n", "<C-z>", "<cmd>ZenMode<cr>", opts)
keymap("n", "<A-;>", ":call QuickFixToggle()<cr>", opts)

keymap("n", "<A-1>", ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<A-2>", ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", "<A-3>", ':lua require("harpoon.ui").nav_file(3)<CR>', opts)

keymap("i", "<A-f>", '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
keymap("i", "<A-r>", '<cmd>RunFile<CR>', opts)

local map = function(mode, lhs, rhs, desc)
    if desc then desc = desc end
    vim.keymap.set(mode, lhs, rhs,
                   {silent = true, desc = desc, buffer = bufnr, noremap = true})
end

if pcall(require, "dap") then
    map("n", "<F5>", function() require("dap").continue() end, "")
    map("n", "<F17>", function() require("dap").terminate() end, "") -- Shift+F5
    map("n", "<F29>", function() require("dap").restart_frame() end, "") -- Control+F5
    map("n", "<F6>", function() require("dap").pause() end, "")
    map("n", "<F9>", function() require("dap").toggle_breakpoint() end, "")
    map("n", "<F10>", function() require("dap").step_over() end, "")
    map("n", "<F11>", function() require("dap").step_into() end, "")
    map("n", "<F23>", function() require("dap").step_out() end, "") -- Shift+F11
end

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

vim.api.nvim_set_keymap("n", "<tab>",
                        "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<cr>",
                        opts)
vim.api.nvim_set_keymap("n", "<s-tab>",
                        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>",
                        opts)
