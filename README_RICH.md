# Rich's Nvim

This NVIM is inspired by LazyVIM, but built by hand to remove some of the things in it. You can always access LunarVim which is quite close
by running `lvim`. Overally, it is very hard to make this all work, so instead, I'm going to try to just get the LazyVim Starter working

## 💤 LazyVim Starter

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started. This is forked at
[nvim.lazyvim](https://github.com/richtong/nvim.lazyvim)

## Decomposing the LazyVim Starter

This uses Lazy.nvim to install components

- [LazyVim](https://www.lazyvim.org/configuration/examples):
- [Gruvbox](ellisonleao/gruvbox.nvim) - Theme
- [Trouble](https://github.com/folke/trouble.nvim) - pretty list for all the trouble in your code
- [Nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) - Like airline, this is for status

Major components for an IDE so Mason > Nvim-lspconfig, nvim-telescope, nvim-treesitter

- [Mason](https://github.com/williamboman/mason.nvim) - Manager for LSP, DAP (Debug Adapter Protocol), linters, formatters, it needs plugins to add LSPs, DSPs, Linters and Formatters. so it need Nvim-lspconfig, nvim-dap. In the old days CoC grew into this by adding an LSP plugin system since code completion, linting and formatting are highly related.
- [Nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - configuration helper for the native Language Server Protocol. It adds some standard keystrokes like \-] to goto definition and C-X, C-O to do manual completion. YOu need an autocompletion plugin to do this automatically. [d and ]d is go to previous and next. Use `:LspInfo` to control it. With opts.servers, you can add things like pyright or typescript etc. LSPs provide syntax, they provide linting and other things.
- [Nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) - A fuzzy finder like fzf and has modular components and can use fzf underneath. \fp finds telescope plugins
- [Nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - much smarter highlighting as it understands the abstract symbol tree for code and so coloring works well.

Note sure why this is needed above what mason adds
- [Nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Code completion manager can use LSPs, needs a snippet engine like vsnip, luasnip, ultisnips or snippy and use [cmp-emoji](https://github.com/hrsh7th/cmp-emoji) to add Emoji completions. Source downstream components. This is like CoC in the vim days.

Here are some optional things that are not in LazyVim
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) to add dedicated linters if the ones in LSPs aren't good enough. This is alot like ALE in the old vim days.
- [formatter.nvim](https://github.com/mhartington/formatter.nvim) - not sure whey this is needed with both treesitter and nvim-lspconfig 
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Set breakpoints with [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - Adds pretty UI

## Things that are still missing

- [Codeium](https://github.com/Exafunction/codeium.vim) or other ai thingies which act like big code adders so can conflict with mason tools.
- [Avante](https://github.com/yetone/avante.nvim) - attempts to emulate VS Code cursor

## LunarVim

This is another opiniated versino so goo to analyze it [LunarVim](https://lunarvim.org) and not surprisingly it uses the same base components

Base components that are the same as LazyVim

- [Lazy.nvim](https://github.com/folke/lazy.nvim). Sames as Lazyvim
- [https://github.com/williamboman/mason.nvim](https://github.com/williamboman/mason.nvim). Same as Lazyvim to install LSP, DAP, linters, and formatters
- [NVim-lspconfig](https://github.com/neovim/nvim-lspconfig). Same as Lazyvim. To ease LSP configuration
- https://github.com/nvim-telescope/telescope.nvim. Same as Lazyvim
- https://github.com/folke/lazydev.nvim has replaced neodev.nvim for configuring the Lua LSP
- https://github.com/mfussenegger/nvim-dap. Debugger
- [https://github.com/rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui). Debugger UI
- [https://github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter). The Treesitter for parsing things. In Lazyvim too.
- [https://github.com/JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring). Treesitter plugin for comments
- [https://github.com/nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim). Same as Lazyvim
- [https://github.com/SmiteshP/nvim-navic](https://github.com/SmiteshP/nvim-navic). Adds code location to lualine
- [https://github.com/b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim). Really useful, a place on the internet that validates YAML and JSON. I've been using this with comment lines in CoC
- [https://github.com/lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim). Figures out where to indent sounds like a smart autoindent.


There are things for completions:

- https://github.com/hrsh7th/nvim-cmp. The completion tool
- https://github.com/rafamadriz/friendly-snippets preconfigured snipets
- https://github.com/L3MON4D3/LuaSnip - snips are needef ro the completion stuff
- https://github.com/saadparwaiz1/cmp_luasnip. completions for lua source
- https://github.com/hrsh7th/cmp-buffer. For buffers
- https://github.com/hrsh7th/cmp-path. for paths


Additional components it has:

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim). Some glue logic I don't understand really important for Windows users apparently and adds LspInstall.
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim/). So that you can use LSPs that are not pure lua. Coc.nvim allows this natively, but this needs a plugin.
- [https://github.com/nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim). Recommended to run FZF
- [https://github.com/windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs). The highlighting or matching parenthesis. Useful!
- [https://github.com/numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim). Handles comments
- [https://github.com/akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim). More prettiness I don't understand.

For file trees browsing like nerdtree:

- [https://github.com/kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [https://github.com/tamago324/lir.nvim](https://github.com/tamago324/lir.nvim)
- [https://github.com/lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim). Like gitgutter in vim

For help

- [https://github.com/folke/which-key.nvim](https://github.com/folke/which-key.nvim). Which key are you does this command work on.



New files vs lazyvim starter that I probably need to look at but not install at first

- tamago324/nlsp-settings.nvim. Sets the JSON/YAML LSP
- https://github.com/folke/tokyonight.nvim. A pretty theme
- https://github.com/lunarvim/lunar.nvim. A color schcme
- https://github.com/Tastyep/structlog.nvim. A better logging output for lua.
- https://github.com/nvim-lua/popup.nvim. Popup manager
- https://github.com/nvim-lua/plenary.nvim. library for lunarvim
- [https://github.com/goolord/alpha-nvim](https://github.com/goolord/alpha-nvim). I think greeter screens are pretty ugly
- [https://github.com/akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim). Change your workflow so you live inside vi and run shell. I normally do it the other way around.
- [https://github.com/RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate). Highlight an entire word not just the character. Sounds distracting
- [https://github.com/lunarvim/onedarker.nvim](https://github.com/lunarvim/onedarker.nvim) colorscheme

## Comparison with .vimrc as of August 2024

There are two different installations in the `.vimrc`:

Things to merge in:

- I truly hate the space as the LEADER key, so change back to the Backslash
- [vim-colors-solarized](altercation/vim-colors-solarized). Gruvbox is kind of ugly
- [machakann/vim-sandwich](https://github.com/machakann/vim-sandwicht). I use this an incredible about like saW to add quotes around a word
- iamcco/markddown-preview.nvim. I do a lot of markdown and this is useful
- airblade/vim-gitgutter - this is actually very useful
- pdrohdz/vim-yaml-folds - use za and zR to open and close vim-yaml-folds
- ygddroot/indentline - shows small vertical for tabs, great for python and yaml

Things I'm not sure about:

- preservim/nerdcommenter - Note says this is for mypy. Note sure
- preservim/nerdtree - the tree view at the starter
- preservim/nerdtree-git-plugin

The duplicates that I don't need:

- [Vim-airline](https://github.com/vim-airline). I as using powerline, but this broke, so returned

Things that are rarely used and I can drop:

- [preservim/vim-solarized8](https://preservim/vim-solarized8). 24-bit true color got graphical interface versions of vim
- tpope/vim-git-plugin - Let's you do :G commit, but I don't use much
- madox2/vim-ai - :AI gives you chatgpt, use ai plugin instead

### neovim

This is the later installation that uses CoC for the LSP

- exafunction/codeium.vim. Should use this more C-[ and M=] for next suggestion


Thing I don't need which is COC since we are using the native LSP:

- neoclide/coc.nvim
- neclide/coc-ruff


### vim

This uses syntastsic since vim is single threaded and does not allow async. I haven't used this in a while

- vim-syntastic/syntastic
