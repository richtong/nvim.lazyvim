-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- vim.env.OPENAP_API_KEY
-- vim.env.ANTHROPIC_API_KEY
-- https://github.com/olimorris/codecompanion.nvim

-- Your CodeCompanion setup
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      -- { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      { "stevearc/dressing.nvim", opts = {} },
    },
    config = true,
    -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    -- see https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
    -- Adapters use this interface https://github.com/olimorris/codecompanion.nvim/blob/main/doc/ADAPTERS.md
    opts = {
      log_level = "DEBUG",
    },
    display = {
      diff = {
        -- mini-diff part of LazyExtras
        provider = "mini-diff",
      },
    },
    strategies = {
      chat = {
        -- adapter = "qwen25_coder",
        adapter = "llama3_70b",
        -- adapter = "ollama",
        -- adapter = "gemini",
        -- adapter = "anthropic",
        -- adapter = "copilot",
        -- adapter = "openai",
      },
      inline = {
        -- adapter = "qwen25_coder",
        adapter = "llama3_70b",
        -- adapter = "ollama",
        -- adapter = "gemini",
        -- adapter = "anthropic",
        -- adapter = "openai",
      },
      agent = {
        -- adapter = "qwen25_coder",
        adapter = "llama3_70b",
        -- adapter = "ollama",
        -- adapter = "gemini",
        -- adapter = "anthropic",
        -- adapter = "openai",
      },
    },
    -- Use schema.model to change the default model used by the adapters
    -- https://github.com/olimorris/codecompanion.nvim/tree/main
    -- https://platform.openai.com/docs/models
    -- "gpt-4"
    -- "gpt-4o"
    -- "gpt-4o mini"
    -- "o1-preview"
    -- "o1-mini"
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
          schema = {
            model = {
              default = "o1-preview",
            },
          },
        })
      end,
      -- ollama list shows these models,
      -- mistral-large:latest
      -- yi-coder:latest
      -- deepseek-v2.5:latest
      -- reader-lm:latest
      -- bespoke-minicheck:latest
      -- llama3.1:70b-instruct-q4_0
      -- starcoder2:latest
      -- nemotron-mini:latest
      -- qwen2.5-coder:latest
      -- phi3.5:latest
      -- qwen2.5:latest
      -- gemma2:latest
      -- llama3.1:8b-text-q4_0
      -- llama3.1:latest
      -- this overrides the default ollama definition which looks like it finds
      -- the first model in the list that comes back from ollama
      -- which is the last model that was pulled by ollama pull
      -- this overrides that use llama3.1
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "llama3.1",
            },
          },
        })
      end,
      -- TODO
      -- to do https://github.com/olimorris/codecompanion.nvim/discussions/113
      -- add the deepseek free hosted model
      --
      -- https://github.com/olimorris/codecompanion.nvim/tree/main/doc/ADAPTERS.md
      -- To create more adapaters that have specific default models
      llama31_70b = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "llama3_70b",
          schema = {
            model = {
              default = "llama3.1:70b-instruct-q4_0",
            },
          },
        })
      end,
      qwen25_coder = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "qwen25_coder",
          schema = {
            model = {
              default = "qwen2.5-coder",
            },
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
          schema = {
            model = {
              -- https://docs.anthropic.com/en/docs/about-claude/models
              -- default = "claude-3-5-sonnet-20240620"
              default = "claude-3-5-sonnet-20240620",
            },
          },
        })
      end,
      -- https://ai.google.dev/gemini-api/docs/models/gemini
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            -- api_key = 'cmd:op item get "Google Gemini API Key Dev" --fields "api key" --reveal',
            api_key = "vim.env.GEMINI_API_KEY",
          },
          schema = {
            model = {
              -- default = "gemini-1.5-flash"
              default = "gemini-1.5-pro",
            },
          },
        })
      end,
    },
  },
}
