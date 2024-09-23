---@diagno1stic disable: missing-fields

--NOTE: Set config path to enable the copilot adapter to work.
--It will search the follwoing paths for the for copilot token:
--  "$CODECOMPANION_TOKEN_PATH/github-copilot/hosts.json"
--  "$CODECOMPANION_TOKEN_PATH/github-copilot/apps.json"
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
      opts = {
        log_level = "DEBUG",
      },

      -- codecompanion
      -- run with nvim --clear -u
      -- the default setup is here so do this to make changes
      -- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      -- see https://github.com/olimorris/codecompanion.nvim/tree/main/lua/codecompanion/adapters
      -- r
      -- Adapters use this interface https://github.com/olimorris/codecompanion.nvim/blob/main/doc/ADAPTERS.md
      display = {
        diff = {
          -- mini-diff part of LazyExtras
          provider = "mini-diff",
        },
      },
      -- strategies = {
      --   --NOTE: Change the adapter as required
      --   chat = { adapter = "openai" },
      --   inline = { adapter = "openai" },
      --   agent = { adapter = "openai" },
      -- },
      strategies = {
        chat = {
          -- adapter = "qwen25_coder",
          adapter = "llama31_70b",
          -- adapter = "ollama",
          -- adapter = "gemini",
          -- adapter = "anthropic",
          -- adapter = "copilot",
          -- adapter = "openai",
        },
        inline = {
          -- adapter = "qwen25_coder",
          adapter = "llama31_70b",
          -- adapter = "ollama",
          -- adapter = "gemini",
          -- adapter = "anthropic",
          -- adapter = "openai",
        },
        agent = {
          -- adapter = "qwen25_coder",
          adapter = "llama31_70b",
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
            name = "llama31_70b",
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
