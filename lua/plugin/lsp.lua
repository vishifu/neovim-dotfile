local lspconfig = require("lspconfig")

local vim = vim
vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "⚑", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" })

-- Configure diagnostic
vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
                border = "solid",
                source = true,
                header = "",
                prefix = "",
        },
})

-- Mapping diagnostics
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open diagnostic window!" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic!" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic!" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loc list for diagnostic!" })

-- Use LspAttach autocmd to only map the following keys after the language server attaches to the current buffer.
local telescope_builtin = require("telescope.builtin")
vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)
                vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
                vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)
                vim.keymap.set("n", "<leader>ls", telescope_builtin.lsp_document_symbols, opts)
                vim.keymap.set("n", "<leader>lw", telescope_builtin.lsp_workspace_symbols, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        end,
})


-- Configure language servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
                Lua = {
                        runtime = {
                                version = "LuaJIT",
                        },
                        diagnostics = {
                                globals = { "vim" }
                        },
                        workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                        },
                        telemetry = {
                                enable = false,
                        },
                },
        },
})

-- Go
lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
                gopls = {
                        hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                        },
                        semanticTokens = true,
                        experimentalPostfixCompletions = true,
                        experimentalWorkspaceModule = true,
                        gofumpt = true,
                }
        }
})
