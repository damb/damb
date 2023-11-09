return {
  settings = {

    cmd = {
      "clangd",
      "--background-index",
      -- XXX(damb): by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
      -- to add more checks, create .clang-tidy file in the root directory
      -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
      "--clang-tidy",
      "--log=verbose",
      "--pretty",
      "--cross-file-rename",
      "-header-insertion=iwyu",
    },
  },
}
