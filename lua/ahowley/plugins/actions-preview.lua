require("ahowley.remap")

return {
  "aznhe21/actions-preview.nvim",
  event = "VeryLazy",
  config = function()
    require("actions-preview").setup()
  end,
}
