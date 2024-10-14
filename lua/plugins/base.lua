-- copied from example.lua but remove the do nothing
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
-- make sure after each to have a comma otherwise the file cuts off and you  do not get
-- any more configurations
return {

  -- Configure LazyVim to load colorscheme
  -- add gruvbox (yuck)
  --
  -- you can see all schemese with `:colorscheme<space><tab>`
  { "ellisonleao/gruvbox.nvim" },
  -- top search hit for a neovim lua solarized doesn't work
  { "craftzdog/solarized-osaka.nvim" },
  { "maxmx03/solarized.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      -- make sure to leave off the .nvim suffix
      colorscheme = "solarized-osaka",
      -- colorscheme = "gruvbox",
      -- colorscheme = "solarized",
    },
  },

  -- { "b0o/SchemaStore.nvim" }, -- yaml and json standard schemas

  -- change trouble config enable this
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  -- { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- markdownlint-cli2 is very annoying it defaults to 80 but we format to 88
  -- https://www.lazyvim.org/plugins/formatting
  -- https://github.com/LazyVim/LazyVim/discussions/1701
  -- https://github.com/stevearc/conform.nvim
  -- the default only sets lua, sh and fish
  -- https://github.com/LazyVim/LazyVim/discussions/4545
  {
    "stevearc/conform.nvim",
    -- @module "conform"
    -- @type conform.setupOpts
    opts = {
      formatters_by_ft = {
        css = { "prettierd", "prettier" },
        graphql = { "prettierd", "prettier" },
        handlebars = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        less = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        mdx = { "prettierd", "prettier" },
        python = { "ruff" },
        sccs = { "prettierd", "prettier" },
        terraform_fmt = { "terraform" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        vue = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
      },
    },
  },
  --   -- https://www.lazyvim.org/extras/formatting/prettier
  --   -- have prettier snarf up everything it understands
  --   opts = function(_, opts)
  --     opts.formatters_by_ft = opts.formatters_by_ft or {}
  --     for _, ft in ipairs(supported) do
  --       opts.formatters_by_ft[ft] = { "prettier" }
  --     end
  --     opts.formatters = opts.formatters or {}
  --     opts.formatters.prettier = {
  --       condition = function(_, ctx)
  --         return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
  --       end,
  --     }
  --   end,
  --
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, nls.builtins.formatting.prettier)
  --   end,
  -- },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- Lazyvim has pyright by default we disable in favor of ruff
        -- https://github.com/LazyVim/LazyVim/discussions/1506
        pyright = {
          -- mason = false,
          autostart = false,
        },
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      autoformat = true,
      -- most of these are in LazyExtra
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        -- the defaults are pyright for python, json, lua and json
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
        -- look in for the string in the middle of the require('lspconfig.helm_ls.setup()')
        tsserver = {}, -- typescript
        -- marksman = { mason = false, autostart = false }, -- if you only want ltex
        -- marksman = {}, -- markdown when ltex loaded both are checking
        bashls = {}, -- shellcheck and shfmt configs are controlled outside of neovim with ~/.editorconfig
        -- dockerls = {}, -- dockerfiles
        docker_compose_language_service = {}, -- docker compose yaml
        dotls = {}, -- graphviz .dot files
        -- gopls = {}, -- Google's golang
        -- helm_ls = {}, -- K8s helm files
        jqls = {}, -- the crazy jq json query language
        -- ltex = { -- ltex alternative to LazyExtra.lang.tex with spelling as main addition
        -- use filetype is you don't want spell check for md, text, html etc
        -- filetypes = { "bib", "plaintex", "tex", "pandoc", "quarto" },
        -- },
        nginx_language_server = {}, -- The crazy nginx configuration files
        -- pyright = { mason = false, autostart = false }, -- pyright part of lazyvim, use this to disable
        -- https://docs.astral.sh/ruff/editors/settings/#linelength
        -- default <leader> co organizes imports
        -- https://www.lazyvim.org/extras/lang/python
        ruff = {
          init_options = {
            settings = {
              lineLength = 88, -- black replacement and 88 is now default
              organizeImports = true, -- isort replacement
              lint = {
                select = {
                  "F", -- pyright
                  "E", -- pycodestyle
                  "W", -- pycodestyle warnings
                  "C", -- mccabe code complexity
                  "I", -- isort
                  "N", -- PEP8 naming
                  "D", -- pydocstyle docstrings
                  "UP", -- pyupgrade
                  "YTT", -- flake8-2020
                  "ANN", -- flake8-annotations
                  "S", -- flake8-bandit
                  "FBT", -- flake8-boolean-trap
                  "B", -- flake8-bugbear
                  "A", -- flake8-builtin showing
                  "COM", -- flake8-commas missing
                  "C4", -- flake8-comprehensions simplification
                  "DTZ", -- flake8-datetimez errors
                  "EM", -- flake8-errmsg
                  "EXE", -- flake8-executalbe
                  "PTH", -- flake8-use-pathlib no os.path
                  "PD", -- pandas-vet
                  "PL", -- pylint refactor, warn, errors
                  "NPY", -- numpy
                  "PERF", -- perflint
                  "DOC", -- pydoclint
                  "RUF", -- ruff specific rules
                },
              },
            },
          },
        },
        sqls = {}, -- editing .sql files
        -- yamlls = {}, -- already includes schema store support
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- in example template this is overridden not sure why
  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "prettier",
        "prettierd",
        -- "flake8",
      },
    },
  },
}
