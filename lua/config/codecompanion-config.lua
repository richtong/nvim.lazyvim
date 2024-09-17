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
