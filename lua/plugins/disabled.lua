local plugins_to_disable = {
  -- { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- Always disabled
}

if vim.g.started_by_firenvim then
  table.insert(plugins_to_disable, { "folke/noice.nvim", enabled = false })
  table.insert(plugins_to_disable, { "rcarriga/nvim-notify", enabled = false })
end

return plugins_to_disable
