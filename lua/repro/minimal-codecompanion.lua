--@diagnostic disable: missing-fields
--
-- run with nvim --clean -u <this file>.lua

--NOTE: Set config path to enable the copilot adapter to work.
--It will search the follwoing paths for the for copilot token:
--  - "$CODECOMPANION_TOKEN_PATH/github-copilot/hosts.json"
--  - "$CODECOMPANION_TOKEN_PATH/github-copilot/apps.json"
vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")

vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

-- Your CodeCompanion setup
local plugins = {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim" },
      { "hrsh7th/nvim-cmp" },
      { "stevearc/dressing.nvim", opts = {} },
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      strategies = {
        -- NOTE: Change the adapter as required
        chat = { adapter = "openai" },
        inline = { adapter = "openai" },
        agent = { adapter = "openai" },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
  },
}

require("lazy.minit").repro({ spec = plugins })

-- Setup Tree-sitter
local ts_status, treesitter = pcall(require, "nvim-treesitter.configs")
if ts_status then
  treesitter.setup({
    ensure_installed = { "lua", "markdown", "markdown_inline", "yaml" },
    highlight = { enable = true },
  })
end

-- Setup completion
local cmp_status, cmp = pcall(require, "cmp")
if cmp_status then
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
  })
end

-- Theseting this stuff
-- this does not work in options.lua because setup is not there, so how do you
-- do this with lazyvim
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
      })
    end,
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          --  -- the slower way via 1Password
          -- api_key = 'cmd:op item get "Anthropic API Key Dev" --fields "api key" --reveal',
          -- -- depends on an environment variable
          api_key = "vim.env.ANTHROPIC_API_KEY",
        },
      })
    end,
  },
})
