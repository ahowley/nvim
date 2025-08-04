return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({ n_lines = 500 }) -- a/i key for around/inside extensions
  end,
}
