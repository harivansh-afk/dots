return {
    { "neovim/nvim-lspconfig", lazy = false },
    { "williamboman/mason.nvim", lazy = false, opts = {} },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "gopls",
                "clangd",
                "bashls",
                "jsonls",
                "html",
                "cssls",
            },
        },
    },
}
