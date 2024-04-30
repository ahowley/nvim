local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
	desc = "Remove whitespace on save",
	pattern = "",
	command = ":%s/\\s\\+$//e",
})

autocmd("ModeChanged", {
	desc = "Redraw on mode change to avoid disappearing statusline",
	callback = function()
		vim.schedule(function()
			vim.cmd("redraw")
		end)
	end,
})
