-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- vim.env.OPENAP_API_KEY
-- vim.env.ANTHROPIC_API_KEY
-- https://github.com/olimorris/codecompanion.nvim

-- Your CodeCompanion setup
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim" },
      { "hrsh7th/nvim-cmp" },
      { "stevearc/dressing.nvim", opts = {} },
      { "nvim-telescope/telescope.nvim" },
    },
    -- this stuff should be in the options aread not install
    -- opts = {
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    --adapters = { "anthropic", "openai", "gemini", "ollama", "copilot" },
    --   strategies = {
    --     chat = { adapter = "ollama" },
    --     inline = { adapter = "ollama" },
    --     agent = { adapter = "openai" },
    --   },
    --   opts = {
    --     log_level = "DEBUG",
    --   },
    -- },
    config = true,
  },
}
