require("ahowley.remap")

local bufnr = vim.api.nvim_get_current_buf()

Map("n", L("cs"), "<cmd>TSToolsSortImports<CR>", "[c]ode [s]ort imports", { buffer = bufnr })
Map(
  "n",
  L("co"),
  "<cmd>TSToolsOrganizeImports<CR>",
  "[c]ode [o]rganize imports",
  { buffer = bufnr }
)

MapInlayHints(bufnr)
MapHover(bufnr)
MapDocumentSymbol(bufnr)
MapPublishDiagnostics(bufnr)
MapDefinition(bufnr)
MapDeclaration(bufnr)
MapTypeDefinition(bufnr)
MapReferences(bufnr)
MapImplementation(bufnr)
MapCodeAction(bufnr)
MapRename(bufnr)
MapPrettier(bufnr)
