require("ahowley.remap")

return {
  "pmizio/typescript-tools.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup({
      on_attach = function(args)
        local bufnr = args.buf

        Map(
          "n",
          L("cs"),
          "<cmd>TSToolsSortImports<CR>",
          "[c]ode [s]ort imports",
          { buffer = bufnr }
        )
        Map(
          "n",
          L("co"),
          "<cmd>TSToolsOrganizeImports<CR>",
          "[c]ode [o]rganize imports",
          { buffer = bufnr }
        )

        Map("n", L("ch"), require("hover").open, "[c]ode [h]over", { buffer = bufnr })
        Map("n", L("cH"), require("hover").select, "[c]ode [H]over select", { buffer = bufnr })
        Map("n", "<C-p>", function()
          ---@diagnostic disable-next-line: missing-parameter
          require("hover").switch("previous")
        end, "hover.nvim (previous source)", { buffer = bufnr })
        Map("n", "<C-n>", function()
          ---@diagnostic disable-next-line: missing-parameter
          require("hover").switch("next")
        end, "hover.nvim (next source)", { buffer = bufnr })
        Map("n", "K", function()
          vim.lsp.buf.hover({
            border = "rounded",
          })
        end, "[K]over", { buffer = bufnr })

        Map("n", L("cn"), "<cmd>Navbuddy<CR>", "[c]ode [n]avigate", { buffer = bufnr })

        Map("n", "[d", function()
          vim.diagnostic.goto_prev({ float = false })
        end, "Go to previous [d]iagnostic", { buffer = bufnr })
        Map("n", "]d", function()
          vim.diagnostic.goto_next({ float = false })
        end, "Go to next [d]iagnostic", { buffer = bufnr })
        Map("n", L("ld"), function()
          require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy({}))
        end, "[l]ist [d]iagnostics", { buffer = bufnr })

        Map(
          "n",
          L("gd"),
          require("telescope.builtin").lsp_definitions,
          "[g]oto [d]efinition(s)",
          { buffer = bufnr }
        )
        Map(
          "n",
          L("gp"),
          "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
          "[g]oto [p]review definition",
          { buffer = bufnr }
        )

        Map(
          "n",
          L("gD"),
          "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
          "[g]oto [D]eclaration",
          { buffer = bufnr }
        )

        Map(
          "n",
          L("gt"),
          "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
          "[g]oto [t]ype definition",
          { buffer = bufnr }
        )

        Map(
          "n",
          L("gr"),
          "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
          "[g]oto [r]eferences",
          { buffer = bufnr }
        )

        Map(
          "n",
          L("gi"),
          "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
          "[g]oto [i]mplementation",
          { buffer = bufnr }
        )

        Map(
          "n",
          L("ca"),
          require("actions-preview").code_actions,
          "[c]ode [a]ction",
          { buffer = bufnr }
        )

        Map("n", L("cr"), function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, "[c]ode [r]ename symbol", { expr = true }, { buffer = bufnr })
        Map("n", L("fr"), vim.lsp.buf.rename, "[f]ile [r]ename", { buffer = bufnr })
      end,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          includeAutomaticOptionalChainCompletions = true,
          importModuleSpecifierPreference = "shortest",
        },
      },
    })
  end,
}
