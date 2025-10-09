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
  dependencies = {
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
    -- require("mason-lspconfig").setup(opts)

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
