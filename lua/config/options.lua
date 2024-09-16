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
-- and is sensitive to
-- vim.opt.wrap = true

-- http://blog.ezyang.com/2010/03/vim-textwidth/
-- this is not documented, if you do not set them vim.g.wrap does not work
-- https://www.lazyvim.org/configuration/general#options in default
-- sets vim.opt.local.wrap = true, and vim.opt_local.spell = true but not...
-- textwidth 88 is black and textwidth 80 is markdown-cli2
vim.opt.textwidth = 80

-- https://github.com/LazyVim/LazyVim/discussions/141
-- set in
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- override her
-- vim.g.autoformat = false

-- MarkDown Preview trying to get it to start firefox does not work
vim.g.mkdp_browser = "firefox"

-- https://github.com/olimorris/codecompanion.nvim?tab=readme-ov-file#gear-configuration
-- three ways to get keys
require("codecompanion").setup({
  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        env = {
          -- this is a direct read for 1Password api v1
          -- api_key = "cmd:op read op://personal/OpenAI/credential --no-newline",
          -- this actually does a 1Password search so more robust the double
          -- quotes are needed since this is a shell command
          -- api_key = 'cmd:op item get "OpenAI API Key Dev" --fields "api key" --reveal',
          -- If in the environment this is fastest
          api_key = vim.env.OPENAI_API_KEY,
        },
      }),
    end,
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
      --  -- the slower way via 1Password
          -- api_key = 'cmd:op item get "Anthropic API Key Dev" --fields "api key" --reveal',
      -- -- depends on an environment variable
          api_key = "vim.env.ANTHROPIC_API_KEY",
        },
      }),
    end,
  },
})
