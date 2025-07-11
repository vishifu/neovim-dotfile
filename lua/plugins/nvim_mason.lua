-- This file used to setup LSP installation managed by Mason

return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
			},
		},
		config = function(_, opts)
			require("mason").setup({
				ui = {
					border = "single",
					backdrop = 60,
				},
				log_level = vim.log.levels.ERROR,
			})

			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					if mr.has_package(tool) then
						local p = mr.get_package(tool)
						if not p:is_installed() then
							vim.notify("Mason: installing " .. tool .. "...", vim.log.levels.INFO)

							p:install():once("closed", function()
								if p:is_installed() then
									vim.notify("Mason: install " .. tool .. " succeeds!", vim.log.levels.INFO)
								else
									vim.notify("Mason: failed to install " .. tool, vim.log.levels.ERROR)
								end
							end)
						end
					else
						vim.notify("Mason: package " .. tool .. " not found!", vim.log.levels.WARN)
					end
				end
			end

			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
