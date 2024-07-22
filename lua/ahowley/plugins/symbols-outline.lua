require("ahowley.remap")

return {
	"hedyhli/outline.nvim",
	config = function()
		require("outline").setup({
			-- Your setup opts here (leave empty to use defaults)
		})

		Map("n", L("Tu"), "<cmd>Outline<CR>", "[T]oggle o[u]tline")
	end,
}
