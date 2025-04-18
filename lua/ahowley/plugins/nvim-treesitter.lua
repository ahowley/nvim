require("ahowley.remap")

return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "typescript",
      "javascript",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { "ruby" },
      max_file_lines = 10000,
      disable = function(lang, bufnr)
        return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1048576
      end,
    },
    indent = { enable = false, disable = { "ruby" } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require("nvim-treesitter.install").prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)

    Map("n", L("Th"), function()
      if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
        vim.cmd("TSEnable highlight")
      else
        vim.cmd("TSDisable highlight")
      end
    end, "[T]oggle [h]ighlighting")
    Map("n", L("Sh"), function()
      print(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil)
    end, "[S]tatus [h]ighlighting")

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
