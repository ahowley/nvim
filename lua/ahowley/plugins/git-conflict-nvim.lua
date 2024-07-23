require("ahowley.remap")

return {
	"akinsho/git-conflict.nvim",
	event = "VeryLazy",
	version = "*",
	config = function()
		require("git-conflict").setup({
			default_mappings = false,
			default_commands = true,
			disable_diagnostics = false,
			list_opener = "copen",
			highlights = {
				incoming = "DiffAdd",
				current = "DiffText",
			},
			debug = false,
		})

		Map("n", L("lx"), "<cmd>GitConflictListQf<CR>", "[l]ist [x]onflicts")
		Map("n", L("xx"), "<cmd>GitConflictListQf<CR>", "[x]onflict [x]onflicts")

		Map("n", "]x", "<cmd>GitConflictNextConflict<CR>", "next conflict")
		Map("n", "[x", "<cmd>GitConflictPrevConflict<CR>", "prev conflict")

		Map("n", L("xo"), "<cmd>GitConflictChooseOurs<CR>", "[x]onflict choose [o]urs")
		Map("n", L("xt"), "<cmd>GitConflictChooseTheirs<CR>", "[x]onflict choose [t]heirs")
		Map("n", L("xb"), "<cmd>GitConflictChooseBoth<CR>", "[x]onflict choose [b]oth")
		Map("n", L("xn"), "<cmd>GitConflictChooseNone<CR>", "[x]onflict choose [n]one")
	end,
}
