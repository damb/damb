local success, illuminate = pcall(require, "illuminate")
if not success then
  vim.notify("WARN: failed to load 'illuminate' plugin")
  return
end

illuminate.configure({
  providers = { "lsp" },
  filetypes_denylist = {
    "mason",
    "harpoon",
    "DressingInput",
    "NeogitCommitMessage",
    "qf",
    "dirvish",
    "minifiles",
    "fugitive",
    "alpha",
    "NvimTree",
    "lazy",
    "NeogitStatus",
    "Trouble",
    "netrw",
    "lir",
    "DiffviewFiles",
    "Outline",
    "Jaq",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "TelescopePrompt",
  },
})
