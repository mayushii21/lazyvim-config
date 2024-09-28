-- * override the configuration of nvim-cmp
-- disable auto-completion and use nvim-cmp as omnifunc
local cmp = require("cmp")

cmp.setup({
  completion = {
    autocomplete = false,
  },
})

return {}
