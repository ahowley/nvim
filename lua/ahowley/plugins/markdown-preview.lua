require("ahowley.remap")

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.cmd([[
			function! OpenMarkdownPreview(url)
				execute "silent ! wslview " . a:url
			endfunction

			let g:mkdp_browserfunc = 'OpenMarkdownPreview'
		]])

		map("n", "TP", "<cmd>MarkdownPreviewToggle<CR>", "[T]oggle [P]review")
	end,
}
