require("ahowley.remap")

-- \v\<(\#|\/\#)(\_[^>]+)\>
Map("n", L("af"), "<cmd>%s/\\v\\<(\\#|\\/\\#)(\\_[^>]+)\\>/[\\1\\2]/g<CR>", "[a]ction [f]reemarker")
-- \v\[(\#|\/\#)(\_[^]]+)\]
Map(
  "n",
  L("aF"),
  "<cmd>%s/\\v\\[(\\#|\\/\\#)(\\_[^]]+)\\]/<\\1\\2>/g<CR>",
  "[a]ction [F]reemarker reverse"
)
