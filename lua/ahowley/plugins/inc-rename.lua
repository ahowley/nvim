return {
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
  config = function()
    require("inc_rename").setup({})

    require("ahowley.remap")
    Map("n", L("cr"), function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, "[c]ode [r]ename symbol", { expr = true })
  end,
}
