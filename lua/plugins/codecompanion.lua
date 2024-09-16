-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- vim.env.OPENAP_API_KEY
-- vim.env.ANTHROPIC_API_KEY
-- https://github.com/olimorris/codecompanion.nvim
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    {
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      opts = {},
    },
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
  },
  config = true,
}
