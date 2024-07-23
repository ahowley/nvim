require("ahowley.remap")

return {
	"aznhe21/actions-preview.nvim",
	event = "VeryLazy",
	config = function()
		require("actions-preview").setup()
		Map("n", L("ca"), require("actions-preview").code_actions, "[c]ode [a]ction")
	end,
}
