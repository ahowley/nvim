require("ahowley.remap")

return {
  "anuvyklack/windows.nvim",
  event = "VeryLazy",
  dependencies = {
    "anuvyklack/middleclass",
    -- "anuvyklack/animation.nvim",
  },
  config = function()
    vim.o.winwidth = 20
    vim.o.winminwidth = 10
    vim.o.equalalways = false

    Map("n", L("w+"), ":WindowsMaximize<CR>", "[w]indow +aximize")
    Map("n", L("w|"), ":WindowsMaximizeVertically<CR>", "[w]indow maximize |ertically")
    Map("n", L("w_"), ":WindowsMaximizeHorizontally<CR>", "[w]indow maximize _orizontally")
    Map("n", L("w="), ":WindowsEqualize<CR>", "[w]indow =qualize")
    Map("n", L("Tw"), ":WindowsToggleAutowidth<CR>", "[T]oggle [w]indow autowidth")

    require("windows").setup()
  end,
}
