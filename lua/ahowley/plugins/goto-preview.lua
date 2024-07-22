require("ahowley.remap")

return {
	"rmagatti/goto-preview",
	config = function()
		require("goto-preview").setup({
			width = 120,
			height = 25,
		})
		Map(
			"n",
			L("gp"),
			"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
			"[g]oto [p]review definition"
		)
		Map(
			"n",
			L("gt"),
			"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
			"[g]oto [t]ype definition"
		)
		Map(
			"n",
			L("gi"),
			"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
			"[g]oto [i]mplementation"
		)
		Map("n", L("gD"), "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", "[g]oto [D]eclaration")
		Map("n", L("gq"), "<cmd>lua require('goto-preview').close_all_win()<CR>", "[g]oto preview [q]uit")
		Map("n", L("gr"), "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "[g]oto [r]eferences")
	end,
}
