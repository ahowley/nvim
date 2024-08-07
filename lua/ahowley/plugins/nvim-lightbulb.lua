return {
  "kosayoda/nvim-lightbulb",
  event = "VeryLazy",
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
      sign = {
        enabled = false,
        -- Text to show in the sign column.
        -- Must be between 1-2 characters.
        text = "💡",
        -- Highlight group to highlight the sign column text.
        hl = "LightBulbSign",
      },
      -- 2. Virtual text.
      virtual_text = {
        enabled = true,
        -- Text to show in the virt_text.
        text = "💡",
        -- Position of virtual text given to |nvim_buf_set_extmark|.
        -- Can be a number representing a fixed column (see `virt_text_pos`).
        -- Can be a string representing a position (see `virt_text_win_col`).
        pos = "eol",
        -- Highlight group to highlight the virtual text.
        hl = "LightBulbVirtualText",
        -- How to combine other highlights with text highlight.
        -- See `hl_mode` of |nvim_buf_set_extmark|.
        hl_mode = "combine",
      },
    })
  end,
}
