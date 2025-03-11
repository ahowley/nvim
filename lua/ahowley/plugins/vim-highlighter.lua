require("ahowley.remap")

return {
  "azabiong/vim-highlighter",
  init = function()
    vim.cmd([[
      let HiSet   = '<Space>ha'
      let HiErase = '<Space>hx'
      let HiClear = '<Space>hX'
      let HiFind  = '<Space>h<Tab>'
      let HiSetSL = '<Space>hl'
      let HiKeywords = '~/nvim-highlights/'
    ]])

    Map("n", L("hp"), "<cmd>Hi + ", "[h]ighlight [p]attern")
    Map("n", L("hw"), "<cmd>Hi save ", "[h]ighlight [w]rite")
    Map("n", L("hW"), "<cmd>Hi load ", "[h]ighlight [W]oad")
    Map("n", L("hL"), "<cmd>Hi ls<CR>", "[h]ighlight [l]ist saved")
    Map("n", L("h>"), "<cmd>Hi><CR>", "n[>]xt similar [h]ighlight")
    Map("n", L("h<"), "<cmd>Hi<<CR>", "pr[>]vious similar [h]ighlight")
    Map("n", L("h}"), "<cmd>Hi}<CR>", "n[}]xt [h]ighlight")
    Map("n", L("h{"), "<cmd>Hi{<CR>", "pr[{]vious [h]ighlight")
    Map("n", L("h]"), "<cmd>Hi]<CR>", "n[]]xt color [h]ighlight")
    Map("n", L("h["), "<cmd>Hi[<CR>", "pr[[]vious color [h]ighlight")
  end,
}
