require("ahowley.remap")

function CreateSymbolAutocmds(bufnr)
  local highlight_augroup = vim.api.nvim_create_augroup("ah-lsp-highlight", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })
end

function MapInlayHints(bufnr)
  Map("n", L("Ti"), function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, "[T]oggle [i]nlay hints", { buffer = bufnr })
  Map("n", L("TI"), require("lsp-endhints").toggle, "[T]oggle [I]nlay endhints", { buffer = bufnr })
end

function MapHover(bufnr)
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

function MapDocumentSymbol(bufnr)
  Map("n", L("cn"), "<cmd>Navbuddy<CR>", "[c]ode [n]avigate", { buffer = bufnr })
end

function MapPublishDiagnostics(bufnr)
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

function MapDefinition(bufnr)
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

function MapDeclaration(bufnr)
  Map(
    "n",
    L("gD"),
    "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
    "[g]oto [D]eclaration",
    { buffer = bufnr }
  )
end

function MapTypeDefinition(bufnr)
  Map(
    "n",
    L("gt"),
    "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
    "[g]oto [t]ype definition",
    { buffer = bufnr }
  )
end

function MapReferences(bufnr)
  Map(
    "n",
    L("gr"),
    "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
    "[g]oto [r]eferences",
    { buffer = bufnr }
  )
end

function MapImplementation(bufnr)
  Map(
    "n",
    L("gi"),
    "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
    "[g]oto [i]mplementation",
    { buffer = bufnr }
  )
end

function MapCodeAction(bufnr)
  Map("n", L("ca"), require("actions-preview").code_actions, "[c]ode [a]ction", { buffer = bufnr })
end

function MapRename(bufnr)
  Map("n", L("cr"), function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, "[c]ode [r]ename symbol", { expr = true }, { buffer = bufnr })
  Map("n", L("fr"), vim.lsp.buf.rename, "[f]ile [r]ename", { buffer = bufnr })
end

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

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("ah_lsp", {}),
      callback = function(args)
        local filetype = vim.fn.getbufvar(bufnr, "&filetype")
        print("Filetype for buffer " .. bufnr .. ": " .. filetype)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf

        CreateSymbolAutocmds(bufnr)
        MapInlayHints(bufnr)
        if client:supports_method("textDocument/hover") then MapHover(bufnr) end
        if client:supports_method("textDocument/documentSymbol") then MapDocumentSymbol(bufnr) end
        if client:supports_method("textDocument/publishDiagnostics") then
          MapPublishDiagnostics(bufnr)
        end
        if client:supports_method("textDocument/definition") then MapDefinition(bufnr) end
        if client:supports_method("textDocument/declaration") then MapDeclaration(bufnr) end
        if client:supports_method("textDocument/typeDefinition") then MapTypeDefinition(bufnr) end
        if client:supports_method("textDocument/references") then MapReferences(bufnr) end
        if client:supports_method("textDocument/implementation") then MapImplementation(bufnr) end
        if client:supports_method("textDocument/codeAction") then MapCodeAction(bufnr) end
        if client:supports_method("textDocument/rename") then MapRename(bufnr) end
      end,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("ah_lsp", {}),
      callback = function(args)
        vim.lsp.buf.clear_references()
      end,
    })
  end,
}
