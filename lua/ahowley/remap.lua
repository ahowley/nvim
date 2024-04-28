function l(s)
	return "<leader>" .. s
end

function map(mode, binding, action, description)
	opts = { desc = description or "" }
	opts.buffer = bufnr
	vim.keymap.set(mode, binding, action, opts)
end

function mapreg(keybind, name)
	require("which-key").register({
		[keybind] = { name = name, _ = "which_key_ignore" },
	})
end

function mappings()
	vim.g.mapleader = " "

	-- Open default vim explorer
	-- map("n", l("fe"), vim.cmd.Ex, "[f]ile [e]xplore")

	-- Clear search highlight on <Esc> in normal mode
	map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

	-- Diagnostic keymaps
	map("n", "[d", vim.diagnostic.goto_prev, "Go to previous [d]iagnostic")
	map("n", "]d", vim.diagnostic.goto_prev, "Go to next [d]iagnostic")

	-- Toggle cmd line
	map("n", "<M-`>", function()
		if vim.o.cmdheight == 0 then
			vim.o.cmdheight = 1
		else
			vim.o.cmdheight = 0
		end
	end, "Toggle Command Line")

	-- Navigate windows
	map("n", "<C-h>", "<C-w><C-h>", "Move to window on the left")
	map("n", "<C-l>", "<C-w><C-l>", "Move to window on the right")
	map("n", "<C-k>", "<C-w><C-k>", "Move to window above")
	map("n", "<C-j>", "<C-w><C-j>", "Move to window below")
end
