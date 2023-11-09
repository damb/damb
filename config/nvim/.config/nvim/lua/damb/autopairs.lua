local success, autopairs = pcall(require, "nvim-autopairs")
if not success then
  vim.notify("WARN: failed to load 'nvim-autopairs' plugin")
  return
end

autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local success, cmp = pcall(require, "cmp")
if not success then
  vim.notify("WARN: failed to load 'cmp' plugin")
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
