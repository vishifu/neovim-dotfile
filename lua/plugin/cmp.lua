local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

---@diagnostic disable-next-line: redundant-parameter
cmp.setup({
        snippet = {
                expand = function(args)
                        luasnip.lsp_expand(args.body)
                end,
        },
        sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 900, keyword_length = 2 },
                { name = "buffer",   priority = 800, keyword_length = 3 },
        }),
        preselect = cmp.PreselectMode.None,
        completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_length = 1,
        },
        view = {
                entries = { name = "custom", selection_order = "near_cursor" }
        },
        experimetal = {
                ghost_text = true,
        },
        formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function (entry, item)
                        item.kind = string.format("%s", item.kind)
                        item.menu = ({
                                buffer = "[Buffer]",
                                nvim_lsp = "[LSP]",
                                lua_snip = "[Snippet]",
                        })[entry.source.name]

                        return item
                end,
        },
        mapping = cmp.mapping.preset.insert({
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = function(fallback)
                        if cmp.visible() then
                                cmp.select_next_item()
                        else
                                fallback()
                        end
                end,
                ["<S-Tab>"] = function(fallback)
                        if cmp.visible() then
                                cmp.select_prev_item()
                        else
                                fallback()
                        end
                end,
        }),
})
