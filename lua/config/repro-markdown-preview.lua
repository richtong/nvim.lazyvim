-- https://github.com/olimorris/codecompanion.nvim#electric_plug-adaptersinimal repro lua config
-- this is automatically calledl by lazyvim if it is in ./lua/config
-- Getting keys from 1Password, but you can also get from the environment if you
-- are using .envrc there and this is faster
require("codecompanion").setup({
  adapters = {
    openai = function()
      return require("codecompanion.adapters".extend("openai", {
        env = {
          api_key = "cmd:op read op://Private/OpenAI API Key Dev/api key",
        },
      }),
    end,
    anthropic = function()
      return require("codecompanion.adapters".extend("anthropic", {
        env = {
          api_key = "cmd:op read op://Private/anthropic API Key",
        },
      }),
    end,
  },
})

