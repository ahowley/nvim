require("ahowley.remap")

return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "current",
        mappings = {
          ["<cr>"] = "open",
        },
      },
      popup_border_style = "rounded",
    })
    Map("n", L("lf"), "<cmd>Neotree filesystem reveal current<CR>", "[l]ist [f]iles")
    Map("n", L("fe"), "<cmd>Neotree float filesystem<CR>", "[f]ile [e]xplore")
  end,
}
