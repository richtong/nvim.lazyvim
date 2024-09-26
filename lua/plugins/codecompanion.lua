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
    -- the double opts is not a typo, in LazyVim the entire opts is fed to
    -- require("codecompanion").setup
    opts = {
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
          -- adapter = "llama31_70b",
          adapter = "ollama",
          -- adapter = "gemini",
          -- adapter = "anthropic",
          -- adapter = "copilot",
          -- adapter = "openai",
        },
        inline = {
          -- adapter = "qwen25_coder",
          -- adapter = "llama31_70b",
          adapter = "ollama",
          -- adapter = "gemini",
          -- adapter = "anthropic",
          -- adapter = "openai",
        },
        agent = {
          -- adapter = "qwen25_coder",
          -- adapter = "llama31_70b",
          adapter = "ollama",
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
        -- https://console.groq.com/docs/quickstart
        -- because groq is also openai api compliant
        groq = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = vim.env.GROQ_API_KEY,
            },
            name = "Groq",
            url = "https://api.groq.com/openai/v1/chat/completions",
            schema = {
              model = {
                default = "llama3.2-11-text-preview",
                -- https://console.groq.com/docs/models
                choices = {
                  "distil-whisper-large-v3-en",
                  "whisper-large-v3",
                  "gemma2-9b-it",
                  "gemma-7b-it",
                  "llama3-groq-70b-8192-tool-use-preview",
                  "llama3-groq-8b-8192-tool-use-preview",
                  -- 132K context
                  "llama-3.1-70b-versatile",
                  -- 128K native but only 8k tokens now
                  "llama-3.2-1b-preview",
                  "llama-3.2-11b-text-preview",
                  "llama-3.2-3b-preview",
                  "llama-3.2-11b-text-preview",
                  "llama-3.2-90b-text-preview",
                  "llama-guard-3-8b",
                  "llava-v1.5-7b-4096-preview",
                },
              },
            },
            max_tokens = {
              default = 8192,
            },
            temperature = {
              default = 1,
            },
          })
        end,
        -- https://github.com/olimorris/codecompanion.nvim/discussions/113
        -- deepseek emulates the openai api so you can just openai adapter
        deepseek25 = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "deepseek 2.5",
            env = {
              api_key = vim.env.DEEPSEEK_API_KEY,
            },
            -- 4K but beta is 8K output context, all are 128K input context
            -- or set max_tokens = 8192
            url = "https://api.deepseek.com/chat/completions",
            schema = {
              model = {
                default = "deepseek-chat",
              },
              -- deepseek-coder and deepseek-chat were v2, v2.5 merges them
              -- note that this will still present openai models as well which
              -- doesn't work
              choices = {
                "deepseek-chat",
              },
            },
            max_tokens = {
              default = 8192,
            },
            temperature = {
              default = 1,
            },
          })
        end,
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
            name = "llama 3.1 70b",
            schema = {
              model = {
                default = "llama3.1:70b",
              },
            },
          })
        end,
        qwen25_coder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen2.5-coder",
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
              api_key = vim.env.ANTHROPIC_API_KEY,
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
              -- api_key = 'cmd:op item get "Google Gemini API Key Dev" --fields "api otken" --reveal',
              api_key = vim.env.GEMINI_API_TOKEN,
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
  },
}
