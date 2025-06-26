require("ahowley.remap")

local servers = {
  rust_analyzer = {},
  -- omnisharp = {},
  csharpier = {},
  cssls = {},
  dockerls = {},
  emmet_ls = {},
  html = {
    filetypes = { "ftl" },
  },
  ruff = {},
  jsonls = {
    autostart = false,
  },
  sqlls = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}
local ensure_installed = vim.tbl_keys(servers or {})

return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    automatic_enable = {
      exclude = {
        "jsonls",
      },
    },
    ensure_installed = ensure_installed,
    handlers = {
      function(server_name)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
          vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local server = servers[server_name] or {}

        server.capabilities =
          vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        require("lspconfig")[server_name].setup(server)
      end,
    },
  },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          "LazyVim",
        },
      },
    },
    {
      "mason-org/mason.nvim",
      opts = {
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      },
    },
    { "j-hui/fidget.nvim", opts = {} },
    {
      "SmiteshP/nvim-navic",
      opts = {
        lsp = { auto_attach = true },
      },
    },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = { lsp = { auto_attach = true } },
    },
    {
      "Hoffs/omnisharp-extended-lsp.nvim",
      lazy = true,
    },
    {
      "lewis6991/hover.nvim",
      opts = {
        init = function()
          require("hover.providers.fold_preview")
          require("hover.providers.diagnostic")
        end,
        preview_opts = {
          border = "rounded",
        },
        preview_window = true,
        title = false,
      },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "folke/lazydev.nvim",
        "j-hui/fidget.nvim",
        "smiteshP/nvim-navbuddy",
        "Hoffs/omnisharp-extended-lsp.nvim",
        "lewis6991/hover.nvim",
      },
    },
  },
  config = function(opts)
    vim.lsp.inlay_hint.enable(true)
    vim.diagnostic.config({ virtual_text = true })

    Map("n", L("fr"), vim.lsp.buf.rename, "[f]ile [r]ename")
    -- map("n", l("ca"), vim.lsp.buf.code_action, "[c]ode [a]ction")
    Map("n", L("ch"), require("hover").hover, "[c]ode [h]over")
    -- map("n", l("ch"), vim.lsp.buf.hover, "[c]ode [h]over")
    -- map("n", l("gD"), vim.lsp.buf.declaration, "[g]oto [d]eclaration")
    Map("n", L("cH"), require("hover").hover_select, "[c]ode [H]over select")
    Map("n", "<C-p>", function()
      ---@diagnostic disable-next-line: missing-parameter
      require("hover").hover_switch("previous")
    end, "hover.nvim (previous source)")
    Map("n", "<C-n>", function()
      ---@diagnostic disable-next-line: missing-parameter
      require("hover").hover_switch("next")
    end, "hover.nvim (next source)")
    Map("n", L("Ti"), function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "[T]oggle [i]nlay hints")
    Map("n", L("cn"), "<cmd>Navbuddy<CR>", "[c]ode [n]avigate")

    Map("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end, "[K]over")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup =
            vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
      end,
    })

    require("mason-lspconfig").setup(opts)

    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = false,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
        },
      },
    })
  end,
}
