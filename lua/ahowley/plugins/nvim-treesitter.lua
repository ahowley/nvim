require("ahowley.remap")

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
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
  end,
}
