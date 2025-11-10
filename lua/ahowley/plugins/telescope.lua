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
    { "jonarrien/telescope-cmdline.nvim" },
  },
  opts = {
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
      colorscheme = {
        enable_preview = true,
      },
    },
    extensions = {
      cmdline = {
        -- Adjust telescope picker size and layout
        picker = {
          layout_config = {
            width = 120,
            height = 25,
          },
        },
        -- Adjust your mappings
        mappings = {
          complete = "<C-y>",
          run_selection = "<C-CR>",
          run_input = "<CR>",
        },
        -- Triggers any shell command using overseer.nvim (`:!`)
        overseer = {
          enabled = false,
        },
      },
    },
  },
  config = function(_, opts)
    require("ahowley.remap")

    require("telescope").setup(opts)

    local builtin = require("telescope.builtin")

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")

    Map("n", L("ff"), builtin.find_files, "[f]ile [f]ind")
    Map("n", L("fv"), builtin.git_files, "[f]ile [v]ersioned")

    Map("n", L("sc"), builtin.commands, "[s]earch [c]ommands")
    Map("n", L("sk"), builtin.keymaps, "[s]earch [k]eymaps")
    Map("n", L("sg"), builtin.live_grep, "[s]earch by [g]rep")
    Map("n", L("sf"), builtin.current_buffer_fuzzy_find, "[s]earch current [f]ile fuzzy")

    Map("n", L("lb"), builtin.buffers, "[l]ist [b]uffers")
    Map("n", L("lu"), function(buf_opts)
      buf_opts = buf_opts or {}
      local bufnrs = {}
      -- Find all buffers with the 'modified' option set to true
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if
          vim.api.nvim_buf_is_valid(bufnr)
          and vim.api.nvim_get_option_value("modified", { buf = bufnr })
        then
          table.insert(bufnrs, bufnr)
        end
      end

      if #bufnrs == 0 then
        vim.notify("No unsaved buffers found.", vim.log.levels.INFO, { title = "Telescope" })
        return
      end

      -- Use the built-in buffers picker with the list of unsaved buffer numbers
      require("telescope.builtin").buffers(vim.tbl_extend("force", buf_opts, {
        prompt_title = "Unsaved Buffers",
        buflist = bufnrs,
      }))
    end, "[l]ist [u]nsaved buffers")
    Map("n", L("lT"), function(buf_opts)
      buf_opts = buf_opts or {}
      local bufnrs = {}
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        if vim.api.nvim_buf_is_valid(bufnr) and string.find(filetype, "typescript") then
          table.insert(bufnrs, bufnr)
        end
      end

      if #bufnrs == 0 then
        vim.notify("No typescript buffers found.", vim.log.levels.INFO, { title = "Telescope" })
        return
      end

      -- Use the built-in buffers picker with the list of unsaved buffer numbers
      require("telescope.builtin").buffers(vim.tbl_extend("force", buf_opts, {
        prompt_title = "Unsaved Buffers",
        buflist = bufnrs,
      }))
    end, "[l]ist [T]ypescript")
    Map("n", L("lC"), function(buf_opts)
      buf_opts = buf_opts or {}
      local bufnrs = {}
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        if vim.api.nvim_buf_is_valid(bufnr) and string.find(filetype, "cs") then
          table.insert(bufnrs, bufnr)
        end
      end

      if #bufnrs == 0 then
        vim.notify("No csharp buffers found.", vim.log.levels.INFO, { title = "Telescope" })
        return
      end

      -- Use the built-in buffers picker with the list of unsaved buffer numbers
      require("telescope.builtin").buffers(vim.tbl_extend("force", buf_opts, {
        prompt_title = "Unsaved Buffers",
        buflist = bufnrs,
      }))
    end, "[l]ist [C]sharp")

    Map("n", L("lc"), builtin.command_history, "[l]ist [c]ommand history")
    Map("n", L("ls"), builtin.search_history, "[l]ist [s]earch history")
    Map("n", L("lm"), builtin.marks, "[l]ist [m]arks")
    Map("n", L("lq"), function()
      builtin.quickfix(require("telescope.themes").get_ivy({}))
    end, "[l]ist [q]uickfixes")
    Map("n", L("lj"), builtin.jumplist, "[l]ist [j]umps")
    Map("n", L("ln"), function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, "[l]ist [n]eovim config")

    -- map("n", l("gi"), builtin.lsp_implementations, "[g]oto [i]mplementation(s)")
    -- map("n", l("gt"), builtin.lsp_type_definitions, "[g]oto [t]ype definition(s)")
    --
    Map("n", L("sC"), "<cmd>Telescope colorscheme<CR>", "[s]earch [C]olorschemes")

    require("telescope").load_extension("cmdline")
    Map("n", L("<leader>"), "<cmd>Telescope cmdline<CR>", "telescope-cmdline")
  end,
}
