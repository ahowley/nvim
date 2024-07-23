require("ahowley.remap")

return {
	"pmizio/typescript-tools.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({
			on_attach = function()
				Map("n", L("cs"), "<cmd>TSToolsSortImports<CR>", "[c]ode [s]ort imports")
				Map("n", L("co"), "<cmd>TSToolsOrganizeImports<CR>", "[c]ode [o]rganize imports")
			end,
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayVariableTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
					includeCompletionsForModuleExports = true,
					includeCompletionsForImportStatements = true,
					includeAutomaticOptionalChainCompletions = true,
					importModuleSpecifierPreference = "shortest",
				},
			},
		})
	end,
}
