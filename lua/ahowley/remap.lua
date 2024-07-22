function L(s)
	return "<leader>" .. s
end

function SendKeys(keys)
	local escaped = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(escaped, "m", false)
end

function Map(mode, binding, action, description, opts)
	opts = opts or {}
	opts.desc = description
	---@diagnostic disable-next-line: undefined-global
	opts.buffer = bufnr
	vim.keymap.set(mode, binding, action, opts)
end

function MapReg(keybind, name)
	require("which-key").add({
		{ keybind, group = name },
	})
end

function Mappings()
	vim.g.mapleader = " "

	-- Open default vim explorer
	-- map("n", l("fe"), vim.cmd.Ex, "[f]ile [e]xplore")

	-- Clear search highlight on <Esc> in normal mode
	Map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

	-- Diagnostic keymaps
	Map("n", "[d", function()
		vim.diagnostic.goto_prev({ float = false })
	end, "Go to previous [d]iagnostic")
	Map("n", "]d", function()
		vim.diagnostic.goto_next({ float = false })
	end, "Go to next [d]iagnostic")

	-- Easier to reach macro key
	Map("n", L("m"), "@", "Run [m]acro")

	-- Toggle cmd line
	Map("n", L("Tc"), function()
		if vim.o.cmdheight == 0 then
			vim.o.cmdheight = 1
		else
			vim.o.cmdheight = 0
		end
	end, "[T]oggle [c]ommand line")

	-- Modes
	Map("x", "v", "<Esc>`>", "alternate escape key")
	Map("x", "V", "<Esc>`<", "alternate escape key")
	Map("i", "jk", "<Esc>", "alternate escape key")
	Map("n", L("o"), "o<esc>", "add line below and jump")
	Map("n", L("O"), "O<esc>", "add line above and jump")

	-- Navigate windows
	Map("n", L("wh"), "<C-w><C-h>", "move to [w]indow on the left")
	Map("n", L("wl"), "<C-w><C-l>", "move to [w]indow on the right")
	Map("n", L("wk"), "<C-w><C-k>", "move to [w]indow above")
	Map("n", L("wj"), "<C-w><C-j>", "move to [w]indow below")
	Map("n", L("wr"), "<C-w>R", "[w]indow rotate")
	Map("n", L("ws"), "<C-w>v<C-[><CR><C-w>30<<CR>", "[w]indow [s]plit")
	Map("n", L("wb"), "<C-w>60><CR>", "[w]indow [b]ig")
	Map("n", L("wB"), "<C-w>60<<CR>", "[w]indow not [B]ig")
	Map("n", L("wo"), "<C-w>o<CR>", "[w]indow [o]nly")
	Map("n", L("ww"), "<cmd>w<CR>", "[w]indow [w]rite")
	Map("n", L("wq"), "<cmd>q<CR>", "[w]indow [q]uit")

	-- Navigate tabs
	Map("n", L("th"), "gt<CR>", "move to [t]ab on the left")
	Map("n", L("tl"), "gT<CR>", "move to [t]ab on the right")
	Map("n", L("t<leader>"), "<cmd>tab ba<CR>", "edit all buffers as [t]abs")
	Map("n", L("ts"), "<C-w>T<CR>", "[s]plit new [t]ab")
	Map("n", L("to"), "<cmd>tabonly<CR>", "[t]ab [o]nly")
	Map("n", L("tq"), "<cmd>tabc<CR>", "[t]ab [q]uit")
	Map("n", L("tQ"), "<cmd>bd<CR>", "[t]ab [Q]uit all (quit buffers)")
	Map("n", L("t1"), "<cmd>1tabnext<CR>", "[t]ab [1]")
	Map("n", L("t2"), "<cmd>2tabnext<CR>", "[t]ab [2]")
	Map("n", L("t3"), "<cmd>3tabnext<CR>", "[t]ab [3]")
	Map("n", L("t4"), "<cmd>4tabnext<CR>", "[t]ab [4]")
	Map("n", L("t5"), "<cmd>5tabnext<CR>", "[t]ab [5]")
	Map("n", L("t6"), "<cmd>6tabnext<CR>", "[t]ab [6]")
	Map("n", L("t7"), "<cmd>7tabnext<CR>", "[t]ab [7]")
	Map("n", L("t8"), "<cmd>8tabnext<CR>", "[t]ab [8]")
	Map("n", L("t9"), "<cmd>9tabnext<CR>", "[t]ab [9]")

	-- Special
	Map("n", "<tab>", "/[a-zA-Z0-9\\_\\-]\\+<CR><cmd>noh<CR>", "next word (no punctuation)")
	Map("n", "<S-tab>", "?[a-zA-Z0-9\\_\\-]\\+<CR><cmd>noh<CR>", "previous word (no punctuation)")
	Map("n", L("ss"), "/", "[s]earch [s]earch")
	Map("n", L("sr"), function()
		vim.ui.input({ prompt = "number of lines: " }, function(num_lines)
			local search_string = ":+0,+" .. num_lines .. " s/"
			vim.ui.input({ prompt = "search for: " }, function(search_for)
				search_string = search_string .. search_for .. "/"
				vim.ui.input({ prompt = "replace with: " }, function(replace_with)
					search_string = search_string .. replace_with
					SendKeys(search_string)
				end)
			end)
		end)
	end, "[s]earch [r]eplace (forward, relative)")
	Map("n", L("sR"), function()
		vim.ui.input({ prompt = "number of lines: " }, function(num_lines)
			local search_string = ":-0,-" .. num_lines .. " s/"
			vim.ui.input({ prompt = "search for: " }, function(search_for)
				search_string = search_string .. search_for .. "/"
				vim.ui.input({ prompt = "replace with: " }, function(replace_with)
					search_string = search_string .. replace_with
					SendKeys(search_string)
				end)
			end)
		end)
	end, "[s]earch [R]eplace (backward, relative)")
	Map("n", L("Tn"), function()
		if vim.opt.listchars.eol == "" then
			vim.opt.listchars.eol = ""
		else
			vim.opt.listchars.eol = ""
		end
	end, "[T]oggle [n]ewlines")
end
