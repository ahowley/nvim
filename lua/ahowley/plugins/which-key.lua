require("ahowley.remap")

return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		mapreg(l("f"), "[f]ile")
		mapreg(l("s"), "[s]earch")
		mapreg(l("l"), "[l]ist")
		mapreg(l("g"), "[g]oto")
		mapreg(l("h"), "[h]unk")
		mapreg(l("t"), "[t]oggle")
		mapreg(l("c"), "[c]ode, [c]omment")
		mapreg(l("b"), "code [b]lock")
	end,
}
