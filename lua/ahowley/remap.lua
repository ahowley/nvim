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

	-- Easier to reach macro key
	-- map("n", l("m"), "@", "Run [m]acro")

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
	map("n", l("tq"), "<cmd>tabc<CR>", "[t]ab [q]uit")
	map("n", l("tQ"), "<cmd>bd<CR>", "[t]ab [Q]uit all (quit buffers)")
	map("n", l("t1"), "<cmd>1tabnext<CR>", "[t]ab [1]")
	map("n", l("t2"), "<cmd>2tabnext<CR>", "[t]ab [2]")
	map("n", l("t3"), "<cmd>3tabnext<CR>", "[t]ab [3]")
	map("n", l("t4"), "<cmd>4tabnext<CR>", "[t]ab [4]")
	map("n", l("t5"), "<cmd>5tabnext<CR>", "[t]ab [5]")
	map("n", l("t6"), "<cmd>6tabnext<CR>", "[t]ab [6]")
	map("n", l("t7"), "<cmd>7tabnext<CR>", "[t]ab [7]")
	map("n", l("t8"), "<cmd>8tabnext<CR>", "[t]ab [8]")
	map("n", l("t9"), "<cmd>9tabnext<CR>", "[t]ab [9]")
end
