require("ahowley.remap")

return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  dependencies = {
    -- you'll need at least one of these
    { "nvim-telescope/telescope.nvim" },
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    require("neoclip").setup()
    Map("n", L("lr"), "<cmd>Telescope neoclip<CR>", "[l]ist [r]egisters")
    Map("n", L("lR"), ":Telescope neoclip", "[l]ist [R]egisters (select register)")
  end,
}
