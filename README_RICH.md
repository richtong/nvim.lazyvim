# Rich's Nvim

This NVIM is inspired by LazyVIM, but built by hand to remove some of the
things in it. You can always access LunarVim which is quite close by running
`lvim`. Overally, it is very hard to make this all work, so instead, I'm going
to try to just get the LazyVim Starter working

## 💤 LazyVim Starter

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get
started. This is forked at
[nvim.lazyvim](https://github.com/richtong/nvim.lazyvim)

## Decomposing the LazyVim Starter

This uses Lazy.nvim to install components

- [LazyVim](https://www.lazyvim.org/configuration/examples):
- [Gruvbox](ellisonleao/gruvbox.nvim) - Theme
- [Trouble](https://github.com/folke/trouble.nvim) - pretty list for all the
  trouble in your code
- [Nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) - Like airline,
  this is for status

Major components for an IDE so Mason > Nvim-lspconfig, nvim-telescope, nvim-treesitter

- [Mason](https://github.com/williamboman/mason.nvim) - Manager for LSP, DAP
  (Debug Adapter Protocol), linters, formatters, it needs plugins to add LSPs,
  DSPs, Linters and Formatters. so it need Nvim-lspconfig, nvim-dap. In the old
  days CoC grew into this by adding an LSP plugin system since code completion,
  linting and formatting are highly related.
- [Nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - configuration
  helper for the native Language Server Protocol. It adds some standard
  keystrokes like \-] to goto definition and C-X, C-O to do manual completion.
  YOu need an autocompletion plugin to do this automatically. [d and ]d is go to
  previous and next. Use `:LspInfo` to control it. With opts.servers, you can add
  things like pyright or typescript etc. LSPs provide syntax, they provide
  linting and other things.
- [Nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) - A fuzzy
  finder like fzf and has modular components and can use fzf underneath. \fp
  finds telescope plugins
- [Nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - much
  smarter highlighting as it understands the abstract symbol tree for code and so
  coloring works well.

Note sure why this is needed above what mason adds

- [Nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Code completion manager can
  use LSPs, needs a snippet engine like vsnip, luasnip, ultisnips or snippy and
  use [cmp-emoji](https://github.com/hrsh7th/cmp-emoji) to add Emoji completions.
  Source downstream components. This is like CoC in the vim days.

Here are some optional things that are not in LazyVim

- [nvim-lint](https://github.com/mfussenegger/nvim-lint) to add dedicated
  linters if the ones in LSPs aren't good enough. This is alot like ALE in the
  old vim days.
- [formatter.nvim](https://github.com/mhartington/formatter.nvim) - not sure
  whey this is needed with both treesitter and nvim-lspconfig
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Set breakpoints with
  [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - Adds pretty UI

## Things that are still missing

- [Codeium](https://github.com/Exafunction/codeium.vim) or other ai thingies
  which act like big code adders so can conflict with mason tools.
- [Avante](https://github.com/yetone/avante.nvim) - attempts to emulate VS Code
  cursor

## LunarVim

This is another opiniated versino so goo to analyze it
[LunarVim](https://lunarvim.org) and not surprisingly it uses the same base
components

Base components that are the same as LazyVim

- [Lazy.nvim](https://github.com/folke/lazy.nvim). Sames as Lazyvim
- [https://github.com/williamboman/mason.nvim](https://github.com/williamboman/mason.nvim).
  Same as Lazyvim to install LSP, DAP, linters, and formatters
- [NVim-lspconfig](https://github.com/neovim/nvim-lspconfig). Same as Lazyvim.
  To ease LSP configuration
- <https://github.com/nvim-telescope/telescope.nvim>. Same as Lazyvim
- <https://github.com/folke/lazydev.nvim> has replaced neodev.nvim for
  configuring the Lua LSP
- <https://github.com/mfussenegger/nvim-dap>. Debugger
- [https://github.com/rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
  Debugger UI
- [https://github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
  The Treesitter for parsing things. In Lazyvim too.
- [https://github.com/JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring).
  Treesitter plugin for comments
- [https://github.com/nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
  Same as Lazyvim
- [https://github.com/SmiteshP/nvim-navic](https://github.com/SmiteshP/nvim-navic).
  Adds code location to lualine
- [https://github.com/b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim).
  Really useful, a place on the internet that validates YAML and JSON. I've been
  using this with comment lines in CoC
- [https://github.com/lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
  Figures out where to indent sounds like a smart autoindent.

There are things for completions:

- <https://github.com/hrsh7th/nvim-cmp>. The completion tool
- <https://github.com/rafamadriz/friendly-snippets> preconfigured snipets
- <https://github.com/L3MON4D3/LuaSnip> - snips are needef ro the completion stuff
- <https://github.com/saadparwaiz1/cmp_luasnip>. completions for lua source
- <https://github.com/hrsh7th/cmp-buffer>. For buffers
- <https://github.com/hrsh7th/cmp-path>. for paths

Additional components it has:

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim).
  Some glue logic I don't understand really important for Windows users
  apparently and adds LspInstall.
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim/). So that you can
  use LSPs that are not pure lua. Coc.nvim allows this natively, but this needs a
  plugin.
- [https://github.com/nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim).
  Recommended to run FZF
- [https://github.com/windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs).
  The highlighting or matching parenthesis. Useful!
- [https://github.com/numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim).
  Handles comments
- [https://github.com/akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim).
  More prettiness I don't understand.

For file trees browsing like nerdtree:

- [https://github.com/kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)
- [https://github.com/tamago324/lir.nvim](https://github.com/tamago324/lir.nvim)
- [https://github.com/lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
  Like gitgutter in vim

For help

- [https://github.com/folke/which-key.nvim](https://github.com/folke/which-key.nvim).
  Which key are you does this command work on.

New files vs lazyvim starter that I probably need to look at but not install at first

- tamago324/nlsp-settings.nvim. Sets the JSON/YAML LSP
- <https://github.com/folke/tokyonight.nvim>. A pretty theme
- <https://github.com/lunarvim/lunar.nvim>. A color schcme
- <https://github.com/Tastyep/structlog.nvim>. A better logging output for lua.
- <https://github.com/nvim-lua/popup.nvim>. Popup manager
- <https://github.com/nvim-lua/plenary.nvim>. library for lunarvim
- [https://github.com/goolord/alpha-nvim](https://github.com/goolord/alpha-nvim).
  I think greeter screens are pretty ugly
- [https://github.com/akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim).
  Change your workflow so you live inside vi and run shell. I normally do it the
  other way around.
- [https://github.com/RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate).
  Highlight an entire word not just the character. Sounds distracting
- [https://github.com/lunarvim/onedarker.nvim](https://github.com/lunarvim/onedarker.nvim)
  colorscheme

## Comparison with .vimrc as of August 2024

There are two different installations in the `.vimrc`:

Things to merge in:

- I truly hate the space as the LEADER key, so change back to the Backslash
- [vim-colors-solarized](altercation/vim-colors-solarized). Gruvbox is kind of ugly
- [machakann/vim-sandwich](https://github.com/machakann/vim-sandwicht). I use
  this an incredible about like saW to add quotes around a word
- iamcco/markddown-preview.nvim. I do a lot of markdown and this is useful
- airblade/vim-gitgutter - this is actually very useful
- pdrohdz/vim-yaml-folds - use za and zR to open and close vim-yaml-folds
- ygddroot/indentline - shows small vertical for tabs, great for python and yaml

Things I'm not sure about:

- preservim/nerdcommenter - Note says this is for mypy. Note sure
- preservim/nerdtree - the tree view at the starter
- preservim/nerdtree-git-plugin

The duplicates that I don't need:

- [Vim-airline](https://github.com/vim-airline). I as using powerline, but this
  broke, so returned

Things that are rarely used and I can drop:

- [preservim/vim-solarized8](https://preservim/vim-solarized8). 24-bit true
  color got graphical interface versions of vim
- tpope/vim-git-plugin - Let's you do :G commit, but I don't use much
- madox2/vim-ai - :AI gives you chatgpt, use ai plugin instead

### neovim

This is the later installation that uses CoC for the LSP

- exafunction/codeium.vim. Should use this more C-[ and M=] for next suggestion

Thing I don't need which is COC since we are using the native LSP:

- neoclide/coc.nvim
- neclide/coc-ruff

### vim

This uses syntastsic since vim is single threaded and does not allow async. I
haven't used this in a while

- vim-syntastic/syntastic

Note that you do want to install Lazy Extras with :LazyExtras first

This has most of the features I need, so most of the other things are manual configurations
that you can do if you need more than LazyExtras:

- lang.json: Json
- lang.markdown: enables markdown.nvim
- lang.python
- lang.helm
- coding.mini.surround: gives me the sandwich back!

However this doesn't include things like bashls so you still need some of this

## Notes on customizing the LazyVim Starter

- [ ] Ruff vs pyright for python to get completions, pydocstyles force and
      black or just use pyright
- [ ] Even with auto wordwrap it does not use gww or gw} for now
- [x] Spell checking can be done with the base spelling and ]s, [s, z= and zg
      or or you can use ltex for more advanced stuff and is way busier
- [x] shell script using bashls instead for shellcheck but shfmt does not seem
      to work
- [x] Font does not show correct glyphs looks like this is the lsp. Need to
      brew install the font and then make sure that iterm2 profile uses it in `iTerm2
| Settings | Profiles | _Your Profile_ | Text | Font`. Note that 3270 Nerd Font
      You should load nerd fonts as these have all the glyphs you need. The Usable
      fonts are Fira Code, Hack, Ubuntu and JetBrains Mono
- [x] Automatic word wrapping is \uw or in options.lua put in vim.opt.wrap=true
      this is set but doesn't seem to work but gw is the old gcc, so gw} word wraps
      to the next empty space
- [x] Change vim.g.mapleader = "\\" in ./lua/config/options.lua
- [x] Change to solarized, edit ./lua/plugins/base.lua add the .nvim file,
      options does not want the .nvim suffix
- [x] :colorscheme still changes this dynamically
      [colorscheme](https://www.lazyvim.org/plugins/colorscheme)
- [x] Word wrap with gww, but autoformat is off in options.lua put in
      vim.g.autoformat (g means global)

## The new Git workflow

Ok there is lazygit inside this thing so you don't have to leave neovim to
commit, just run \gg and then a 'c' commits and a 'P' pushes. Kind of nice
although I'm used to being in the shell doing this

## Dealing with Spelling

I was using coc-spell but LazyVim just uses the standard vim
[spelling](https://stackoverflow.com/questions/27680639/vim-automatically-advance-to-next-misspelled-word-after-taking-action-on-curren)
keys, so instead of saw too
add a word, it is the usual ]s and [s to find misspells and z= for spelling proposal
and zg to add it to the dictionary

## LazyVim customization

Note that LazyVim has it's own customization system. Instead of calling things
directly, you
return these massive JSON lists that LazyVim deals with them.

The general form is:

1. An array with the name of the plugin, so if you `return
{"crafxdong/solarized-osaka.nvim"}` in any .lua file in
   ./lua/plugins, it will just load \*
2. If you want to set options, then add into that array an opts
   and then a `opts` array with the options so return {"LazyVim/LazyVim", opts
   = { colorscheme = "solarized",}}"
3. Note that with Lua, you can just keep adding commas, to return an entire
   gigantic structure
4. One important thing that you can add is a dependencies tag with a list of
   plugins that are required, there is a
   of these [options](https://www.lazyvim.org/configuration/plugins), but they
   are mainly opts and dependences and ft for filetypes that should activate the
   plugins

## Customizing LSP for things not in LazyExtras

The more complex plugins like "neovim/lsconfig" will have a huge list of things
that can go into opts. The most important is `servers` which list the LSPs to
add. When you get the right name, then mason will automatically install them
But you can look into eash function like
[LSP](https://www.lazyvim.org/plugins/lsp) to see what they are.

By default, lazyvim does not support bash, it has pyright, lua_ls, vtsls and
jsonls and you get more with LazyExt- [ ]
ras, here are the things that you can't get

The configuration is pretty mysterious, but basically go to the [server
Configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls)
in nvim-lspconfig and look for the actual string that is the server and
then go to the ./lua/config and put this into a lua file, I use `base.lua` because
I saw this was the name in the full lazyvim configuration, then if you just put this
name in, then Mason will install what it needs. Note these names are not
necessarily the which is

You need to look for the string in the middle of the
`require'lspconfig'.jedi_language_server.setup()` in
each of the entries in the server configuration. But basically after you list
the servers, you can put in the
{} brackets the setup options for each

So in the example below the jsonls requires things, if you look into the normal
code, the stuff after the require setup is what you need

And at the end there is a setup which has other things you can run for custom setups

Note that for things like schemes, you can always add them directly into your
YAML file with a [comment](https://github.com/LazyVim/LazyVim/discussions/1905)
but it looks like this is already laoded by
[default](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/yaml.lua)
so not needed.

This is for the things that you can't get which are:

1. bashls and shfmt. bashls replaces shellcheck but LSP don't typically provide
   formatting or debugging
   for that matter so you need to add [shfmt](https://github.com/LazyVim/LazyVim/discussions/315)
1. Autoformat on save, is a life saver

```lua
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},  ## bash
        -- override the defaults
        settings = {
          -- what every you like
        },
      },
    autoformat = true,
  },
},
```

### Language specific LSP plugins

Each language may have additional configuration beyond the current one, so you
also need to load [language
specific](https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins).
You stick these into the additional dependencies.

Note that if you delete the installation then Mason does not remove them so you
either have to manually not autostart them or do a `MasonUninstallAll` to get rid of
all the plugins and then on next start of neovim, it will install just the ones
in your configuration. The `Mason` is also convenient. There is no uninstall but you
can see where the items are coming from by what's calling them.

- jsonls. Needs schemastore
- ltex-ls. grammard-guard.nvim and ltex_extra.nvim

## The confusiong which is Python and JSON LSPs

As usual Python has an amazing host of overlapping LSPs and tools:

The default ones already installed but you can add parameters and override
configurations in ./lua/plugins:

- pyright. This is the Microsoft default [server](https://www.andersevenrud.net/neovim.github.io/lsp/configurations/pyright/)
- lua_ls. For lua
- vtsls.
- jsonls. The JSON one is already installed

Note that you can see everything loaded with `:Mason`

Competing ones:

- jedi. This is the original LSP that I've used before, you get this as a full
  LSP `jedi_lanaguage_server` but ruff seems better
- ltex vs markman. These support both markdown (and ltex does Latex too and is very
wordy with spell check
- russ vs pyright. Ruff is faster as it is written in rust and is a superset of pyright. Since
pyright is native to LazyVim, you have to explicitly disable it

```lua
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = { mason = false, autostart = false},
      ruff = {}
    },
  }
}
```

These could compete with vtsls:

- stylelint. for css
- eslint. The typescript vs. vtsls
- superhtml - html linting, does vtsls have this?
- yamlls - does jsonls competed, you can tell by opening a .yaml file and then
  :LspInfo to see what is attached

The many python ones

- pylsp - Another python LSP
- pylizer - Code analyzer
- pyre - static type checker
- pyright - the default in lazyvim, have to decide if we should convert to it
  or to ruff

## Configuring Russ

Russ is so powerful, but you have to set the flags right. you probably don't
want "ALL", but this is a good list. You should also put this into your
pyproject.toml and then turn on pre-commit so that you have the same test.

```lua
        ruff = {
          settings = {
            lineLength = 80, -- black replacement
            organizeImports = true, -- isort replacement
            lint = {
              select = {
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
```

## Completions vs LSP vs Linting vs Formatting

Confusingly the LSP can do many things but sometimes not others. For instance,
bash-ls does linting but not formatting, so you need shfmt for this.

Generally through, completions of what you type are handled by nvim-cmp and
nvim-lsp-config handles the LSPs which general do syntax checking. formatting and
linting I've not quite figured out yet. But ruff for instance does linting too.

If you look at LazyExtras and LazyVim it's hard to tell.

## Recipes

This is a very useful of
[recipes](https://www.lazyvim.org/configuration/recipes) for the neovim
community. Here are some of the most useful ones.

Supertab let's you use the Tabl key for  completions and snippets with a pretty
big [snippet](https://www.lazyvim.org/configuration/recipes#supertab) to
enable it that I put in [supertab.lua](plugins/supertab.lua)

## New keymaps to learn

1. Changed key maps ]g and [g are now ]d and [d for going to next error and
   fixes are [g and [g
1. Adding a comment is now gco and gcO, toggle comment is gcc from the old \cc
1. Buffer command :bd are now \bd and moving is S-h, l and ]b and [b from
   bufferline.nvim and \be turns on and off the buffer explorer
1. Location and Quickfix lists at \xl and \xq
1. set relnumber is now \uL, Autoformat is \uf, Spelling is \us and Wrap is \uw
   but you should turn these on in base.lua
1. starting lazygit is \gg at root dir or \gG for in current directly \gb is
   blame
1. \uI inspect syntax tree of current file
1. Finding files with \ff for files, \fb for buffer, type \f for help
1. Manual word wrap gww and gw} for next blank space

### Sandwich and surround

I use these alot with vim-sandwich before, but the new LazyVim version is [mini-surround](https://github.com/echasnovski/mini.surround)

- Actions are similar, `sa` means add, `sd` delete, `sr` replace, `sf` find,
`sh` highlight
- The next character tells you what to do
  - `f` function call
  - `()`, `[]`, `{}` get you to to those special characters

And note that which-key gives you instructions which is nice!

```vim
gsaiw"  -  Go Surround Around Insert Word a quotes
gsd"    -  Go Surround Delete Quotes
gsr"[   -  Go Surround Replace " with [
```

```
```

This does not seem to work though which you can debug with `:map` and it looks like .
`s` is used by flash in Treesitter and some work leads you to the `gsa` keys

### The LSP commands

1. \cl LSP LspInfo
1. gd, gr, gI, gy, gD goto Definition, References, Implementation, Type and
   Declaration
1. K Hover
1. gK Signature help or c-k
1. \ca code action, \cc run codelens
1. \cR rename file, \cr rename, \cA Source action
1. ]] next reference, [[ previous or a-n and a-p works (Option N and P)

### NeoTree (like NerdTree)

1. \be Buffer Explore
1. \e NeoTree at root, \E NeoTree at cwd

Telescope.nvim and fzf:

1. \<space> Find files at root
1. \, switch buffers
1. \/ grep at root
1. \f find things

nvim-dap, nvim-dap-python

1. \d Debug
1. \da run w ith args
1. \db breakpoints
1. \dc continue
1. \dPc debug class
1. \dPt debug method

1. \cp markdown markddown-preview
