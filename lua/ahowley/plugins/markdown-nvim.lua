require("ahowley.remap")

return {
  "MeanderingProgrammer/markdown.nvim",
  main = "render-markdown",
  opts = {},
  ft = {
    "markdown",
  },
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  config = function()
    Map("n", L("Tr"), "<cmd>RenderMarkdown toggle<CR>", "[T]oggle [r]ender")
  end,
}
