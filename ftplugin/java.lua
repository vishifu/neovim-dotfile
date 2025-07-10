-- Java LSP configuration

local vim = vim
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.textwidth = 120

-- See `:help vim.lsp.start_client` for an overview of the supported config option
local jdtls = require("jdtls")

local jdtls_path = vim.fn.stdpath("data") .. "/lsp_servers/jdtls"
local path_to_config = jdtls_path .. "/config_mac"
local path_to_plugins = jdtls_path .. "/plugins/"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
local lombok_path = path_to_plugins .. "lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root" .. project_name

os.execute("mkdir" .. workspace_dir)

local lsputils = require("utils.lsp_utils")

-- main config
local config = {
	-- See the command starts the LSP
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	flags = {
		debounce_text_changes = 80,
	},
	on_attach = lsputils.on_attach,
	root_dir = root_dir,
	cmd = {
		"/Users/vishifu/javauser/jdk-17.0.2.jdk/Contents/Home/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. lombok_path,
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		path_to_jar,
		"-configuration",
		path_to_config,
		"-data",
		workspace_dir,
	},
	settings = {
		java = {
			home = "/Users/vishifu/javauser/jdk-17.0.2.jdk/Contents/Home",
			maven = {
				downloadSources = true,
			},
			format = {
				settings = {
					url = vim.fn.stdpath("config") .. "/lang-server/intellij-java-google_style.xml",
					profile = "GoogleStyle",
				},
			},
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			-- Specify any options for organizing imports
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			-- How code generation should act
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/Users/vishifu/javauser/jdk-17.0.2.jdk/Contents/Home",
						default = true,
					},
				},
			},
		},
	},
}

jdtls.start_or_attach(config)
