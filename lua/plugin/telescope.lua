local telescope = require("telescope")
local actions = require("telescope.actions")

-- format display
local function normalize_path(path)
	return path:gsub("\\", "/")
end

local function normalize_cwd()
	return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
	return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
	local normalized_path = normalize_path(path)
	local normalized_cwd = normalize_cwd()
	local filename = normalized_path:match("[^/]+$")

	if is_subdirectory(normalized_cwd, normalized_path) then
		local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
		return stripped_path, filename
	else
		local stripped_path = normalized_path:sub(1, -(#filename + 1))
		return stripped_path, filename
	end
end

local function display_path(_, path)
	local stripped_path, filename = split_filepath(path)
	if filename == stripped_path or stripped_path == "" then
		return filename
	else
		return filename .. " ~ " .. stripped_path
	end
end


telescope.setup({
        defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = display_path,
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                        horizontal = {
                                promp_position = "top",
                                preview_width = 0.5,
                                result_width = 0.8,
                        },
                        vertical = {
                                mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_preview_maker = require("telescope.previewers").buffer_previewer_maker,
        extensions = {
                fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                },
        },
        pickers = {
                find_files = {
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
                live_grep = {
                        addtional_args = function()
                                return { "--hidden" }
                        end
                },
                buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        mappings = {
                                i = {
                                        ["<C-d>"] = actions.delete_buffer,
                                },
                                n = {
                                        ["dd"] = actions.delete_buffer,
                                },
                        },
                },
        },
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
--telescope.load_extension("dap")

-- Setup mappings
local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep",opts)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", opts)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", opts)
vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                previewer = false,
                layout_config = { width = 0.7 },
        }))
end, opts)
vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<CR>", opts)
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branchs<CR", opts)
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts)
