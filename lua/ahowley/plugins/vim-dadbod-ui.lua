return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.dbs = {
      {
        name = "prod-staging",
        url = vim.env.DB_PROD_STAGING,
      },
      {
        name = "prod",
        url = vim.env.DB_PROD,
      },
      {
        name = "qa-staging",
        url = vim.env.DB_QA_STAGING,
      },
      {
        name = "qa",
        url = vim.env.DB_QA,
      },
    }
  end,
}
