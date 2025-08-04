-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- -- Themes
  require("ahowley.plugins.tokyonight"),
  require("ahowley.plugins.posterpole"),
  require("ahowley.plugins.kanagawa"),
  require("ahowley.plugins.catppuccin"),
  require("ahowley.plugins.vague"),
  require("ahowley.plugins.onedark"),

  -- -- -- CORE
  require("ahowley.plugins.nvim-treesitter"),
  require("ahowley.plugins.telescope"),

  -- -- -- CODE
  -- -- LSP
  require("ahowley.plugins.lsp-setup"),
  -- require("ahowley.plugins.typescript-tools"),
  require("ahowley.plugins.roslyn"),
  require("ahowley.plugins.rust-tools"),

  -- -- LSP Functionality Extensions
  require("ahowley.plugins.inc-rename"),

  -- -- Snippets
  require("ahowley.plugins.nvim-cmp"),

  -- -- Highlighting
  require("ahowley.plugins.nvim-treesitter-context"),
  require("ahowley.plugins.todo-comments"),
  require("ahowley.plugins.vim-highlighter"),
  require("ahowley.plugins.nvim-colorizer"),

  -- -- Formatting
  require("ahowley.plugins.conform"),
  require("ahowley.plugins.nvim-autopairs"),

  -- -- Shortcuts
  require("ahowley.plugins.which-key"),
  require("ahowley.plugins.comment"),
  require("ahowley.plugins.nvim-surround"),
  require("ahowley.plugins.mini"),

  -- -- Automagic
  require("ahowley.plugins.vim-sleuth"),
  require("ahowley.plugins.guess-indent"),
  require("ahowley.plugins.indent-blankline"),
  require("ahowley.plugins.dial"),

  -- -- -- GUI
  -- -- LSP
  require("ahowley.plugins.goto-preview"),
  require("ahowley.plugins.lsp_signature"),
  require("ahowley.plugins.nvim-lightbulb"),
  require("ahowley.plugins.nvim-lsp-endhints"),
  require("ahowley.plugins.actions-preview"),
  require("ahowley.plugins.symbols-outline"),
  require("ahowley.plugins.syntax-tree-surfer"),

  -- -- Git
  require("ahowley.plugins.gitsigns"),
  require("ahowley.plugins.git-conflict-nvim"),
  require("ahowley.plugins.diffview"),

  -- -- Windows
  require("ahowley.plugins.windows"),

  -- -- Folds
  require("ahowley.plugins.pretty-fold"),

  -- -- Registers
  -- require("ahowley.plugins.nvim-neoclip"),

  -- -- File/Directory Explorer
  require("ahowley.plugins.oil"),

  -- -- Tabline
  require("ahowley.plugins.tabby"),

  -- -- Statusline
  require("ahowley.plugins.feline"),

  -- -- Homepage
  require("ahowley.plugins.alpha"),

  -- -- Markdown
  require("ahowley.plugins.markdown-preview"),
  require("ahowley.plugins.markdown-nvim"),

  -- -- CSV
  require("ahowley.plugins.csvview"),

  -- -- -- OFF BUT MAY WANT ONE DAY SO REMINING YOURSELF EXISTS
  -- -- require("ahowley.plugins.nvim-dap"),

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
