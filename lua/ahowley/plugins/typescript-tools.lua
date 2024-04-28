return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	init = function()
		require("typescript-tools").setup({
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeCompletionsForModuleExports = true,
					includeAutomaticOptionalChainCompletions = true,
					importModuleSpecifierPreference = "shortest",
				},
			},
			keys = {
				{
					"<leader>cs",
					"<cmd>TSToolsSortImports<CR>",
					mode = "n",
					desc = "[c]ode [s]ort imports",
				},
				{
					"<leader>co",
					"<cmd>TSToolsOrganizeImports<CR>",
					mode = "n",
					desc = "[c]ode [o]rganize imports",
				},
			},
		})
	end,
}
