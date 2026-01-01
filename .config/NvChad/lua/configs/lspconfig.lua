local servers = {
    simple = { "pyright", "cssls", "html" },
    custom = {
        "clangd",
        "lua_ls",
        "glsl_analyzer",
        "gopls",
        "golangci_lint_ls",
        -- "hls"
    },
}
vim.lsp.enable(servers.simple)

-- C++ and C
require("cmake-tools").setup({})
vim.lsp.config("clangd", {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    cmd = { "clangd", "--background-index" },
    root_dir = vim.fs.root(0, { "CMakeLists.txt", ".git" }),
})
vim.lsp.enable("clangd")

-- LUA
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { enable = false },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})
vim.lsp.enable("lua_ls")

-- GO
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})
vim.lsp.enable("gopls")

-- GO Linter (golangci-lint)
vim.lsp.config("golangci_lint_ls", {
    cmd = { "golangci-lint-langserver" },
    filetypes = { "go", "gomod" },
    root_dir = vim.fs.root(0, { 
        ".golangci.yml", 
        ".golangci.yaml", 
        ".golangci.toml", 
        ".golangci.json", 
        "go.work", 
        "go.mod", 
        ".git" 
    }),
    init_options = {
        command = { 
            "golangci-lint", 
            "run", 
            "--output.json.path=stdout", 
            "--show-stats=false" 
        },
    },
})
vim.lsp.enable("golangci_lint_ls")

return servers
