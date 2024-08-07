require("ahowley.remap")

return {
  "Arekkusuva/jira-nvim",
  event = "VeryLazy",
  cond = function()
    if vim.env.JIRA_HOST == nil or vim.env.JIRA_TOKEN == nil then return false end
    return true
  end,
  config = function()
    require("jira-nvim").setup({
      host = vim.env.JIRA_HOST,
      token_path = vim.env.JIRA_TOKEN,
    })

    Map("n", L("jl"), "<cmd>JiraQuery jql<CR>", "[j]ira [l]ist")
  end,
}
