local config

vim = vim or {g = {}, o = {}}

local function opt(key, default)
    key = "pcode_" .. key
    if vim.g[key] == nil then return default end
    return vim.g[key]
end

config = {
    colorscheme = opt("colorscheme", "moonfly"),
    progress = opt("progress", 2),
    model = opt("model", 1),
    lsp_installer = opt("lsp_installer", {}),
    mason_ensure_installed = opt("mason_ensure_installed", {}),
    unregister_lsp = opt("unregister_lsp", {}),
    null_ls_sources = opt("null_ls_sources", {}),
    null_ls_ensure_installed = opt("null_ls_ensure_installed", {}),
    dap_ensure_installed = opt("dap_ensure_installed", {}),
    lsp_virtualtext = opt("lsp_virtualtext", false),
    lspghost_text = opt("lspghost_text", false),
    loadnvimtree_lazy = opt("loadnvimtree_lazy", false)
}

return config
