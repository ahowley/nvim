require("ahowley.remap")

return {
  "iamcco/markdown-preview.nvim",
  event = "BufEnter",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.api.nvim_exec2(
      [[
        function! OpenMarkdownPreview(url)
          execute "silent ! wslview " . a:url
        endfunction
      ]],
      {}
    )
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    Map("n", "TP", "<cmd>MarkdownPreviewToggle<CR>", "[T]oggle [P]review")
  end,
}
