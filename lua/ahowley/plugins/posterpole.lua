return {
  "ilof2/posterpole.nvim",
  event = "VeryLazy",
  config = function()
    require("posterpole").setup({
      transparent = false,
      colorless_bg = false, -- grayscale or not
      dim_inactive = false, -- highlight inactive splits
      brightness = 0, -- negative numbers - darker, positive - lighter
      selected_tab_highlight = false, --highlight current selected tab
      fg_saturation = 20, -- font saturation, gray colors become more brighter
      bg_saturation = 0, -- background saturation
    })
    -- vim.cmd.colorscheme("posterpole")
  end,
}
