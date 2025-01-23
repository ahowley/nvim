return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function()
    require("treesitter-context").setup({
      max_lines = 10,
      on_attach = function(bufnr)
        return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) <= 1048576
      end,
    })
  end,
}
