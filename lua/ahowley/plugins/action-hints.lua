return {
  "roobert/action-hints.nvim",
  event = "VeryLazy",
  config = function()
    require("action-hints").setup({
      template = {
        definition = { text = " 󰯂", color = "#add8e6" },
        references = { text = "  %s", color = "#ff6666" },
      },
    })
  end,
}
