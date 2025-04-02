require("ahowley.remap")

return {
  "monaqa/dial.nvim",
  event = "VeryLazy",
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%m/%d/%Y"],
        augend.constant.alias.bool,
        augend.constant.new({ elements = { "let", "const" } }),
        augend.constant.new({ elements = { "private", "protected", "public" } }),
        augend.constant.new({ elements = { "class", "record" } }),
      },
      ymd = {
        augend.date.alias["%Y-%m-%d"],
      },
    })

    Map("n", "<C-a>", function()
      require("dial.map").manipulate("increment", "normal")
    end, "dial increment")
    Map("n", "<C-x>", function()
      require("dial.map").manipulate("decrement", "normal")
    end, "dial decrement")
    Map("v", "<C-a>", function()
      require("dial.map").manipulate("increment", "visual")
    end, "dial increment")
    Map("v", "<C-x>", function()
      require("dial.map").manipulate("decrement", "visual")
    end, "dial decrement")
  end,
}
