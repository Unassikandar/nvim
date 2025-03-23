local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/workspaces/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local os_config = "linux"
if vim.fn.has("mac") == 1 then
	os_config = "mac"
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

--TODO: whatis this --> lvim.builtin.dap.active = true
local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
		"\n"
	)
)

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	capabilities = capabilities,

	settings = {
		["java.format.settings.url"] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
		["java.format.settings.profile"] = "GoogleStyle",
		java = {
			signatureHelp = { enabled = true },
			eclipse = { downloadSources = true },
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk-amd64/",
					},
				},
			},
			maven = { downloadSources = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = { enabled = false  },
		},
		signatureHelp = { enabled = true },
		extendedClientCapabilities = extendedClientCapabilities,
	},
	init_options = { bundles = bundles },
}

config.on_attach = function(client, bufnr)
	local _, _ = pcall(vim.lsp.codelens.refresh)
	jdtls.setup_dap({ hotcodereplace = "auto" })
	--require("lvim.lsp").on_attach(client, bufnr)
	local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
	if status_ok then
		jdtls_dap.setup_dap_main_class_configs()
	end
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

--local formatters = require("lvim.lsp.null-ls.formatters")
--formatters.setup({
--	{ command = "google_java_format", filetypes = { "java" } },
--})

jdtls.start_or_attach(config)
