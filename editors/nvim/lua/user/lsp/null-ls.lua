local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics


local sources = {}
local ensure_installed = {}

local mason_ok, mason_null_ls = pcall(require, "mason-null-ls")
if mason_ok then mason_null_ls.setup({ensure_installed = ensure_installed}) end

null_ls.setup({
    debug = false,
    ensure_installed = ensure_installed,
    sources = sources,
    sources = {
        formatting.prettier.with({
            extra_args = {"--no-semi", "--single-quote", "--jsx-single-quote"}
        }), formatting.clang_format
    }
})

