-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-sleuth",
  require("ahowley.plugins.lsp"),
  require("ahowley.plugins.lsp_signature"),
  require("ahowley.plugins.nvim-cmp"),
  require("ahowley.plugins.telescope"),
  require("ahowley.plugins.which-key"),
  require("ahowley.plugins.comment"),
  require("ahowley.plugins.gitsigns"),
  require("ahowley.plugins.nvim-surround"),
  require("ahowley.plugins.conform"),
  require("ahowley.plugins.guess-indent"),
  require("ahowley.plugins.nvim-autopairs"),
  require("ahowley.plugins.inc-rename"),
  require("ahowley.plugins.typescript-tools"),
  require("ahowley.plugins.action-hints"),
  require("ahowley.plugins.actions-preview"),
  require("ahowley.plugins.tabby"),
  require("ahowley.plugins.feline"),
  require("ahowley.plugins.tokyonight"),
  require("ahowley.plugins.todo-comments"),
  require("ahowley.plugins.mini"),
  require("ahowley.plugins.symbols-outline"),
  -- require("ahowley.plugins.neo-tree"),
  require("ahowley.plugins.oil"),
  require("ahowley.plugins.nvim-treesitter"),
  require("ahowley.plugins.nvim-treesitter-context"),
  require("ahowley.plugins.syntax-tree-surfer"),
  require("ahowley.plugins.rust-tools"),
  require("ahowley.plugins.nvim-lightbulb"),
  require("ahowley.plugins.goto-preview"),
  require("ahowley.plugins.markdown-preview"),
  require("ahowley.plugins.markdown-nvim"),
  require("ahowley.plugins.git-conflict-nvim"),
  require("ahowley.plugins.diffview"),
  require("ahowley.plugins.windows"),
  require("ahowley.plugins.nvim-neoclip"),
  require("ahowley.plugins.pretty-fold"),
  require("ahowley.plugins.indent-blankline"),
  require("ahowley.plugins.nvim-lsp-endhints"),
  require("ahowley.plugins.posterpole"),
  require("ahowley.plugins.kanagawa"),
  require("ahowley.plugins.vague"),
  require("ahowley.plugins.nvim-dap"),
  require("ahowley.plugins.vim-highlighter"),
  require("ahowley.plugins.dial"),
  require("ahowley.plugins.csvview"),
  require("ahowley.plugins.alpha"),
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
