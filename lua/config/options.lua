-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Override the default options
-- See defaults in https://www.lazyvim.org/configuration/general
-- https://github.com/LazyVim/LazyVim/discussions/274
-- because I can't get use to not using the space key like llll
vim.g.mapleader = "\\"

-- if you find the cursor line highlight too annoying
-- Note that g. are global variables while opt. are options as in :set cursoline=false
-- vim.opt.cursorline = false

-- https://github.com/LazyVim/LazyVim/discussions/1959
-- this should normally be set dynamically with \uw
-- note that this is soft wrapping, the underlying file doesn't change, but it
-- let's you see long lines
-- http://blog.ezyang.com/2010/03/vim-textwidth/
-- https://stackoverflow.com/questions/36950231/auto-wrap-lines-in-vim-without-inserting-newlines
-- there are two kinds of wrapping. Soft wrapping which is visual only and
-- changes as you can the window of the terminal display
-- hard wrapping which adds an actual newline
-- wrapmargin sets where if you type, it will insert an EOL for you.
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.wrapmargin = 88
vim.opt.textwidth = 88

-- https://github.com/LazyVim/LazyVim/discussions/141
-- set in
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- override her
-- vim.g.autoformat = false

-- MarkDown Preview and this does work to use firefox
-- vim.g.mkdp_browser = "firefox"

-- https://www.lazyvim.org/extras/formatting/prettier
-- vim.g.lazyvim_prettier_needs_config = false
