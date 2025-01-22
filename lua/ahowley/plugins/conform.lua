return { -- Autoformat
  "stevearc/conform.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>fp",
      function()
        local autoformat_is_disabled_globally = vim.g.disable_autoformat
        local autoformat_is_disabled_locally = vim.b.disable_autoformat

        if autoformat_is_disabled_globally then
          vim.g.disable_autoformat = false
        elseif autoformat_is_disabled_locally then
          vim.b.disable_autoformat = false
        end

        require("conform").format({ async = true, lsp_fallback = true })

        if autoformat_is_disabled_globally then
          vim.g.disable_autoformat = true
        elseif autoformat_is_disabled_locally then
          vim.b.disable_autoformat = true
        end
      end,
      mode = "n",
      desc = "[f]ile make [p]retty",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = {
        c = true,
        cpp = true,
        cs = true,
        ftl = true,
      }
      return {
        timeout_ms = 5000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform can also run multiple formatters sequentially
      python = { "ruff format", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { "prettierd" },
      typescript = { "prettier" },
      markdown = { "prettierd" },
      bash = { "prettierd" },
      sh = { "prettierd" },
      html = { "prettierd", "prettier" },
      ftl = { "prettierd", "prettier" },
      json = { "prettierd" },
      sql = { "sleek" },
      cs = { "csharpier" },
      xml = { "xmlformatter" },
    },
  },
}
