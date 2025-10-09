require("ahowley.remap")

return {
  "rmagatti/goto-preview",
  event = "VeryLazy",
  config = function()
    require("goto-preview").setup({
      width = 120,
      height = 25,
    })
    Map(
      "n",
      L("gq"),
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      "[g]oto preview [q]uit"
    )
  end,
}
