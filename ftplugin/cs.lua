require("ahowley.remap")

Map("n", L("gd"), require("omnisharp_extended").telescope_lsp_definition, "[g]oto [d]efinition")
Map(
  "n",
  L("gt"),
  require("omnisharp_extended").telescope_lsp_type_definition,
  "[g]oto [t]ype definition"
)
Map("n", L("gr"), require("omnisharp_extended").telescope_lsp_references, "[g]oto [r]eferences")
Map(
  "n",
  L("gi"),
  require("omnisharp_extended").telescope_lsp_implementation,
  "[g]oto [i]mplementation"
)
