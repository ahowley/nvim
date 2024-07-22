require("ahowley.remap")

return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup()

		Map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		Map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		Map("n", "<leader>hs", gitsigns.stage_hunk, "[h]unk [s]tage")
		Map("n", "<leader>hr", gitsigns.reset_hunk, "[h]unk [reset]")
		Map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "[h]unk [s]tage")
		Map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "[h]unk [r]eset")
		Map("n", "<leader>hS", gitsigns.stage_buffer, "[h]unk [S]tage buffer")
		Map("n", "<leader>hu", gitsigns.undo_stage_hunk, "[h]unk [u]ndo stage")
		Map("n", "<leader>hR", gitsigns.reset_buffer, "[h]unk [R]eset buffer")
		Map("n", "<leader>hp", gitsigns.preview_hunk, "[h]unk [p]review")
		Map("n", "<leader>hb", gitsigns.toggle_current_line_blame, "[h]unk show [b]lame")
		Map("n", "<leader>hd", gitsigns.diffthis, "[h]unk [d]iff this")
		Map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, "[h]unk [D]iff all")
	end,
}
