require("ahowley.remap")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "smjonas/inc-rename.nvim",
    "rmagatti/goto-preview",
    "aznhe21/actions-preview.nvim",
    {
      "folke/lazydev.nvim",
      ft = { "lua" },
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
      ft = { "!json" },
      opts = {
        lsp = { auto_attach = true },
      },
    },
    {
      "SmiteshP/nvim-navbuddy",
      ft = { "!json" },
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = { lsp = { auto_attach = true } },
    },
    {
      "lewis6991/hover.nvim",
      ft = { "!json" },
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
  },
  config = function(opts)
    vim.lsp.inlay_hint.enable(true)
    vim.diagnostic.config({ virtual_text = true })
    Map("n", L("Ti"), function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "[T]oggle [i]nlay hints", { buffer = bufnr })

    local register_hover = function(client, bufnr)
      if client:supports_method("textDocument/hover") then
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
      end
    end

    local register_document_symbol = function(client, bufnr)
      if client:supports_method("textDocument/documentSymbol") then
        Map("n", L("cn"), "<cmd>Navbuddy<CR>", "[c]ode [n]avigate", { buffer = bufnr })
      end
    end

    local register_publish_diagnostics = function(client, bufnr)
      if client:supports_method("textDocument/publishDiagnostics") then
        Map("n", "[d", function()
          vim.diagnostic.goto_prev({ float = false })
        end, "Go to previous [d]iagnostic", { buffer = bufnr })
        Map("n", "]d", function()
          vim.diagnostic.goto_next({ float = false })
        end, "Go to next [d]iagnostic", { buffer = bufnr })
        Map("n", L("ld"), function()
          require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy({}))
        end, "[l]ist [d]iagnostics", { buffer = bufnr })
      end
    end

    local register_definition = function(client, bufnr)
      if client:supports_method("textDocument/definition") then
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
      end
    end

    local register_declaration = function(client, bufnr)
      if client:supports_method("textDocument/declaration") then
        Map(
          "n",
          L("gD"),
          "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
          "[g]oto [D]eclaration",
          { buffer = bufnr }
        )
      end
    end

    local register_type_definition = function(client, bufnr)
      if client:supports_method("textDocument/typeDefinition") then
        Map(
          "n",
          L("gt"),
          "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
          "[g]oto [t]ype definition",
          { buffer = bufnr }
        )
      end
    end

    local register_references = function(client, bufnr)
      if client:supports_method("textDocument/references") then
        Map(
          "n",
          L("gr"),
          "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
          "[g]oto [r]eferences",
          { buffer = bufnr }
        )
      end
    end

    local register_implementation = function(client, bufnr)
      if client:supports_method("textDocument/implementation") then
        Map(
          "n",
          L("gi"),
          "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
          "[g]oto [i]mplementation",
          { buffer = bufnr }
        )
      end
    end

    local register_code_action = function(client, bufnr)
      if client:supports_method("textDocument/codeAction") then
        Map(
          "n",
          L("ca"),
          require("actions-preview").code_actions,
          "[c]ode [a]ction",
          { buffer = bufnr }
        )
      end
    end

    local register_rename = function(client, bufnr)
      if client:supports_method("textDocument/rename") then
        Map("n", L("cr"), function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, "[c]ode [r]ename symbol", { expr = true }, { buffer = bufnr })
        Map("n", L("fr"), vim.lsp.buf.rename, "[f]ile [r]ename", { buffer = bufnr })
      end
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("ah_lsp", {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf
        register_hover(client, bufnr)
        register_document_symbol(client, bufnr)
        register_publish_diagnostics(client, bufnr)
        register_definition(client, bufnr)
        register_declaration(client, bufnr)
        register_type_definition(client, bufnr)
        register_references(client, bufnr)
        register_implementation(client, bufnr)
        register_code_action(client, bufnr)
        register_rename(client, bufnr)
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("ah_lsp", {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      end,
    })

    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    --   callback = function(event)
    --     local client = vim.lsp.get_client_by_id(event.data.client_id)
    --     if client and client.server_capabilities.documentHighlightProvider then
    --       local highlight_augroup =
    --         vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    --       vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --         buffer = event.buf,
    --         group = highlight_augroup,
    --         callback = vim.lsp.buf.document_highlight,
    --       })
    --
    --       vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    --         buffer = event.buf,
    --         group = highlight_augroup,
    --         callback = vim.lsp.buf.clear_references,
    --       })
    --     end
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("LspDetach", {
    --   group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
    --   callback = function(event)
    --     vim.lsp.buf.clear_references()
    --     -- vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
    --   end,
    -- })
  end,
}
