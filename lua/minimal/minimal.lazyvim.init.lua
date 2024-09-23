-- https://github.com/LazyVim/LazyVim/issues/new
-- run with nvim -u
vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("lazy.minit").repro({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- add any other plugins here
  },
})
