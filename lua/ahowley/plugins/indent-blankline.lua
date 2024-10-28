local function get_vim_color(darken)
  local recording_register = vim.fn.reg_recording()
  local colors = require("tokyonight.colors").setup()
  local util = require("tokyonight.util")
  if require("feline.providers.vi_mode").get_vim_mode() == "INSERT" then
    return util.darken(colors.red, darken)
  elseif require("feline.providers.vi_mode").get_vim_mode() == "VISUAL" then
    return util.darken(colors.green, darken)
  elseif require("feline.providers.vi_mode").get_vim_mode() == "LINES" then
    return util.darken(colors.green2, darken)
  elseif recording_register ~= "" then
    return util.darken(colors.magenta, darken)
  else
    return util.darken(colors.blue, darken)
  end
end

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    local indent_blankline_hooks = require("ibl.hooks")
    indent_blankline_hooks.register(indent_blankline_hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = get_vim_color(0.8) })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = get_vim_color(0.7) })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = get_vim_color(0.6) })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = get_vim_color(0.5) })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = get_vim_color(0.4) })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = get_vim_color(0.3) })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = get_vim_color(0.2) })
    end)
    require("ibl").setup({
      indent = { highlight = highlight, char = "" },
      scope = { enabled = false },
    })
  end,
}
