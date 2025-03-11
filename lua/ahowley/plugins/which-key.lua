require("ahowley.remap")

return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VeryLazy", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    MapReg(L("f"), "[f]ile")
    MapReg(L("s"), "[s]earch, [s]tatus")
    MapReg(L("S"), "[S]tatus")
    MapReg(L("l"), "[l]ist")
    MapReg(L("g"), "[g]oto")
    MapReg(L("h"), "[h]unk")
    MapReg(L("t"), "[t]ab")
    MapReg(L("T"), "[T]oggle")
    MapReg(L("c"), "[c]ode, [c]omment")
    MapReg(L("b"), "code [b]lock")
    MapReg(L("w"), "[w]indow")
    MapReg(L("x"), "[x]onflict")
    MapReg(L("a"), "[a]ction")
    MapReg(L("v"), "[v]isual")
    MapReg(L("d"), "[d]ebug")
    if vim.env.JIRA_HOST ~= nil and vim.env.JIRA_TOKEN ~= nil then MapReg(L("j"), "[j]ira") end
  end,
}
