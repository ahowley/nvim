return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  -- or                            , branch = '0.1.x',
  event = "VeryLazy", -- Sets the loading event to 'VimEnter'
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    require("ahowley.remap")

    require("telescope").setup({
      pickers = {
        find_files = {
          hidden = true,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore-vcs",
            "-g",
            "!**/.git/*",
            "-g",
            "!**/node_modules/*",
            "-g",
            "!**/.repro/*",
          },
        },
      },
    })

    local builtin = require("telescope.builtin")

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    Map("n", L("ff"), builtin.find_files, "[f]ile [f]ind")
    Map("n", L("fv"), builtin.git_files, "[f]ile [v]ersioned")

    Map("n", L("sc"), builtin.commands, "[s]earch [c]ommands")
    Map("n", L("sk"), builtin.keymaps, "[s]earch [k]eymaps")
    Map("n", L("sg"), builtin.live_grep, "[s]earch by [g]rep")
    Map("n", L("<leader>"), builtin.current_buffer_fuzzy_find, "[s]earch current buffer")

    Map("n", L("lb"), builtin.buffers, "[l]ist [b]uffers")
    Map("n", L("lc"), builtin.command_history, "[l]ist [c]ommand history")
    Map("n", L("ls"), builtin.search_history, "[l]ist [s]earch history")
    Map("n", L("lm"), builtin.marks, "[l]ist [m]arks")
    Map("n", L("lq"), function()
      builtin.quickfix(require("telescope.themes").get_ivy({}))
    end, "[l]ist [q]uickfixes")
    Map("n", L("lj"), builtin.jumplist, "[l]ist [j]umps")
    Map("n", L("ld"), function()
      builtin.diagnostics(require("telescope.themes").get_ivy({}))
    end, "[l]ist [d]iagnostics")
    Map("n", L("ln"), function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, "[l]ist [n]eovim config")

    -- map("n", l("gi"), builtin.lsp_implementations, "[g]oto [i]mplementation(s)")
    Map("n", L("gd"), builtin.lsp_definitions, "[g]oto [d]efinition(s)")
    -- map("n", l("gt"), builtin.lsp_type_definitions, "[g]oto [t]ype definition(s)")
  end,
}
