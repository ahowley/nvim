require("ahowley.remap")

return {
	"akinsho/git-conflict.nvim",
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

		map("n", l("lx"), "<cmd>GitConflictListQf<CR>", "[l]ist [x]onflicts")
		map("n", l("xx"), "<cmd>GitConflictListQf<CR>", "[x]onflict [x]onflicts")

		map("n", "]x", "<cmd>GitConflictNextConflict<CR>", "next conflict")
		map("n", "[x", "<cmd>GitConflictPrevConflict<CR>", "prev conflict")

		map("n", l("xo"), "<cmd>GitConflictChooseOurs<CR>", "[x]onflict choose [o]urs")
		map("n", l("xt"), "<cmd>GitConflictChooseTheirs<CR>", "[x]onflict choose [t]heirs")
		map("n", l("xb"), "<cmd>GitConflictChooseBoth<CR>", "[x]onflict choose [b]oth")
		map("n", l("xn"), "<cmd>GitConflictChooseNone<CR>", "[x]onflict choose [n]one")
	end,
}
