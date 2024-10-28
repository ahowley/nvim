require("ahowley.remap")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

local function recolor_indents()
  local indent_blankline_hooks = require("ibl.hooks")
  local indent_blankline_highlights = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
  }
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
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
    indent = { highlight = indent_blankline_highlights, char = "" },
    scope = { enabled = false },
  })
end

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("TextYankPostGroup", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("BufWritePre", {
  desc = "Remove whitespace on save",
  group = augroup("BufWritePreGroup", { clear = true }),
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

autocmd("ModeChanged", {
  desc = "Redraw on mode change to avoid disappearing statusline",
  group = augroup("ModeChangedGroup", { clear = true }),
  callback = function()
    vim.schedule(function()
      recolor_indents()
      vim.cmd("redraw")
    end)
  end,
})

autocmd("WinEnter", {
  desc = "Close all floating windows when changing windows",
  group = augroup("WinEnterGroup", { clear = true }),
  callback = function()
    local current_window = vim.api.nvim_win_get_config(0)
    if current_window.relative ~= "" then return end
    require("goto-preview").close_all_win()
    -- for _, window_id in ipairs(vim.api.nvim_list_wins()) do
    -- 	if vim.api.nvim_win_get_config(window_id).relative ~= "" then
    -- 		vim.api.nvim_win_close(window_id, false)
    -- 	end
    -- end
  end,
})

-- autocmd("VimResized", {
--   group = augroup("VimResizedGroup", { clear = true }),
--   pattern = "*",
--   desc = "Force redraw on window resize",
--   callback = function()
--     print("resized!")
--     vim.schedule(function()
--       vim.cmd("redraw")
--     end)
--   end,
-- })

autocmd("ColorScheme", {
  desc = "Reset float bg and border colors",
  group = augroup("FooBar", { clear = true }),
  pattern = "",
  callback = function()
    vim.schedule(function()
      vim.cmd([[
        highlight NormalFloat guifg=none guibg=none
        highlight FloatBorder guifg=none guibg=none
      ]])
    end)
  end,
})
