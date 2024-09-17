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
    opts = {
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      strategies = {
        --NOTE: Change the adapter as required
        chat = { adapter = "openai" },
        inline = { adapter = "openai" },
        agent = { adapter = "openai" },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
    config = true,
  },
}
