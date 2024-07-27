return {
  -- "anuvyklack/pretty-fold.nvim",
  "bbjornstad/pretty-fold.nvim",
  config = function()
    require("pretty-fold").setup({
      keep_indentation = false,
      fill_char = "━",
      sections = {
        left = {
          "━ ",
          function()
            return string.rep("*", vim.v.foldlevel)
          end,
          " ━┫",
          "content",
          "┣",
        },
        right = {
          "┫ ",
          "number_of_folded_lines",
          ": ",
          "percentage",
          " ┣━━",
        },
      },
    })
    require("pretty-fold").ft_setup("typescript", {
      keep_indentation = false,
      fill_char = "━",
      sections = {
        left = {
          "━ ",
          function()
            return string.rep("*", vim.v.foldlevel)
          end,
          " ━┫",
          "content",
          "┣",
        },
        right = {
          "┫ ",
          "number_of_folded_lines",
          ": ",
          "percentage",
          " ┣━━",
        },
      },
      process_comment_signs = false,
      comment_signs = {
        "/**", -- C++ Doxygen comments
      },
      stop_words = {
        -- ╟─ "*" ──╭───────╮── "@brief" ──╭───────╮──╢
        --          ╰─ WSP ─╯              ╰─ WSP ─╯
        "%*%s*@brief%s*",
      },
    })
  end,
}
