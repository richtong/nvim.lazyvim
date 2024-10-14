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
        -- diff = {
        --   -- mini.diff part of LazyExtras
        --   provider = "mini_diff",
        -- },
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
        openrouter = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = vim.env.OPENROUTER_API_KEY,
            },
            url = "https://openrouter.ai/api/v1/chat/completions",
            schema = {
              model = {
                default = "meta-llama/llama-3.2-3b-instruct",
                choices = {
                  "google/gemini-flash-1.5-8b", -- 1M context
                  "liquid/lfm-40b", -- 32K context, MoE
                  "meta-llama/llama-3.2-3b-instruct:free", -- 132K context
                  "meta-llama/llama-3.2-3b-instruct",
                  "meta-llama/llama-3.2-1b-instruct:free",
                  "meta-llama/llama-3.2-1b-instruct", -- 132K context
                  "meta-llama/llama-3.2-90b-vision-instruct", -- 128K context
                  "meta-llama/llama-3.2-11b-vision-instruct:free",
                  "meta-llama/llama-3.2-11b-vision-instruct", -- 128K context
                  "qwen/qwen-2.5-72b-instruct", -- 128K context
                  "mistral/pixtral-12b", -- image to text 4k context
                  "cohere/command-r-plus-08-2024", -- 128k context
                  "cohere/command-r-08-2024", -- 128k context
                  "ai21/jamba-21.5-large", -- 256K context mamba based
                  "ai21/jamba-21.5-mini", -- 256K context mamba based
                  "microsoft/phi-3.5-mini-128k-instruct", -- 128K context
                  "perplexity/llama-3.1-sonar-huge-128k-online", -- 127K context
                },
              },
            },
          })
        end,
        -- https://console.groq.com/docs/quickstart
        -- //ERROR: groq does not acced an "id" post field "name" is ok
        groq = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = vim.env.GROQ_API_KEY,
            },
            url = "https://api.groq.com/openai/v1/chat/completions",
            schema = {
              model = {
                default = "llama3.2-90b-vision-preview",
                -- https://console.groq.com/docs/models
                choices = {
                  "distil-whisper-large-v3-en", -- 25MB speech input
                  "gemma2-9b-it", -- 8K context
                  "gemma-7b-it", -- 8K context
                  "llama3-groq-70b-8192-tool-use-preview", -- 8K context
                  "llama3-groq-8b-8192-tool-use-preview", --8K context
                  "llama-3.1-70b-versatile", -- 128K limited to
                  "llama-3.1-8b-instant", -- 128K limited to 8K
                  "llama-3.2-1b-preview", -- 128K limited to 8K
                  "llama-3.2-3b-preview", -- 128K limited to 8K
                  "llama-3.2-11b-vision-preview", -- 128K limited to 8K
                  "llama-3.2-90b-vision-preview", -- 128K limited to 8K
                  "llama-guard-3-8b", -- 8K context
                  "llava-v1.5-7b-4096-preview", -- 4K context
                  "llama3-70b-8192", -- 8K context
                  "llama3-8b-8192", -- 8K context
                  "mixtral-8x7b-32768", -- 32K token context
                  "whisper-\alarge-v3", -- 132K context
                },
              },
            },
            max_tokens = {
              default = 8192,
            },
            temperature = {
              default = 1,
            },
            -- new properties, zeros out those that are not there
            -- based on https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/adapters/openai.lua
            unsupported_props = { "id", "opts" },
            handlers = {
              ---@param self CodeCompanion.Adapter
              ---@param messages table Format is: {{role="user", content="...}}
              ---@return table
              form_messages = function(self, messages)
                for _, msg in pairs(messages) do
                  for _, prop in pairs(self.unsupported_props) do
                    msg[prop] = nil
                  end
                end
                return { messages = messages }
              end,
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
                choices = {
                  "deepseek-chat", -- 128K context
                },
              },
              -- deepseek-coder and deepseek-chat were v2, v2.5 merges them
              -- note that this will still present openai models as well which
              -- doesn't work
            },
            max_tokens = {
              default = 131072,
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
        -- ollama autopopulates model choices
        -- the first model in the list that comes back from ollama
        -- which is the last model that was pulled by ollama pull
        -- this overrides that use llama3.1
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "llama3.2",
                -- these are just for documentation
                -- list dynamically updated from ollama server
                -- these are the ollama pull names
                -- Sized for 64GB M1 Mac
                -- do not add choices here this overrides local
                -- choices = {
                --   "llama3.2", -- llama 3.2-3B 2GB with Q4 128k context
                --   "llama3.2:3b-instruct-q8_0", -- llama 3.2-3B 6.4GB with Q4 128k context
                --   "deepseek-v2", -- deepseek v2 deprecated by v2.5
                -- },
              },
            },
          })
        end,
        -- to do https://github.com/olimorris/codecompanion.nvim/discussions/113
        -- To create more adapaters that have specific default models so you do
        -- not have to hunt down in the ollama list
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
