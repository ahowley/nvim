function l(s)
	return "<leader>" .. s
end

function map(mode, binding, action, description, opts)
	opts = opts or {}
	opts.desc = description
	---@diagnostic disable-next-line: undefined-global
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
	map("n", "[d", function()
		vim.diagnostic.goto_prev({ float = false })
	end, "Go to previous [d]iagnostic")
	map("n", "]d", function()
		vim.diagnostic.goto_next({ float = false })
	end, "Go to next [d]iagnostic")

	-- Toggle cmd line
	map("n", "<M-`>", function()
		if vim.o.cmdheight == 0 then
			vim.o.cmdheight = 1
		else
			vim.o.cmdheight = 0
		end
	end, "Toggle Command Line")

	-- Navigate windows
	map("n", "<C-h>", "<C-w><C-h>", "move to [w]indow on the left")
	map("n", "<C-l>", "<C-w><C-l>", "move to [w]indow on the right")
	map("n", "<C-k>", "<C-w><C-k>", "move to [w]indow above")
	map("n", "<C-j>", "<C-w><C-j>", "move to [w]indow below")
	map("n", l("wh"), "<C-w><C-h>", "move to [w]indow on the left")
	map("n", l("wl"), "<C-w><C-l>", "move to [w]indow on the right")
	map("n", l("wk"), "<C-w><C-k>", "move to [w]indow above")
	map("n", l("wj"), "<C-w><C-j>", "move to [w]indow below")
	map("n", l("wr"), "<C-w>R", "[w]indow rotate")
	map("n", l("ws"), "<C-w>v<C-[><CR><C-w>30<<CR>", "[w]indow [s]plit")
	map("n", l("wb"), "<C-w>60><CR>", "[w]indow [b]ig")
	map("n", l("wB"), "<C-w>60<<CR>", "[w]indow not [B]ig")
	map("n", l("w<leader>"), "<C-w>T<CR><cmd>tabonly<CR>", "fullscreen current [w]indow")
	map("n", l("ww"), "<cmd>q<CR>", "[w]indow [w]rite")
	map("n", l("wq"), "<cmd>q<CR>", "[w]indow [q]uit")

	-- Navigate tabs
	map("n", l("tn"), "gt<CR>", "[t]ab [n]ext")
	map("n", l("tp"), "gT<CR>", "[t]ab [p]revious")
	map("n", l("t<leader>"), "<cmd>tab ba<CR>", "edit all buffers as [t]abs")
	map("n", l("ts"), "<C-w>T<CR>", "[s]plit new [t]ab")
	map("n", l("to"), "<cmd>tabonly<CR>", "[t]ab [o]nly")
	map("n", l("tq"), "<cmd>bd<CR>", "[t]ab [q]uit (close buffer)")
end
