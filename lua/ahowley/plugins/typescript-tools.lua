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
					"<leader>gm",
					"<cmd>TSToolsSortImports<CR>",
					mode = "n",
					desc = "[g]Sort I[m]ports",
				},
			},
		})
	end,
}
