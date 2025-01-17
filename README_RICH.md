# Rich's Nvim

<!-- https://github.com/LazyVim/LazyVim/discussions/4094 -->

<!-- hack until we get conform's pretiier to work with markdownlint-cli2 -->
<!--markdownlint-configure-file { "MD013": { "line_length": 88} } -->

This NVIM is inspired by LazyVIM, but built by hand to remove some of the things
in it. You can always access LunarVim which is quite close by running `lvim`.
Overally, it is very hard to make this all work, so instead, I'm going to try to
just get the LazyVim Starter working

## Current problems

- [ ] It looks like you can use the \_leader_cf to run the conform
      formatters, but none are set by default, so what is happening is that the
      linter is running markdownlint-cli2 which makes sense, what I need to do is
      to configure the conform which is really unclear that
      [conform](https://github.com/LazyVim/LazyVim/discussions/3144). does nothing
      without configuration. I tried to use the fancy prittier picks up everything but
      that didn't quite work. I sent a bug report to them. I think there's a problem
      with the script. Overall the idea of \cf being the super formatter is great, but there
      is a bunch of work you have to do. Also I need to see how prettteer and
      markdownlint-cli2 get along
- [ ] Code companion is [cool](https://github.com/olimorris/codecompanion.nvim) but
      still trying to get mini.diff to work correctly and that is frustrating

## Resolved Problems but good documentation

- [x] Formatting in base neovim. There are three kinds of wrapping: 1) Soft
      wrapping which is visual only and changes as you can the window of the
      terminal display, you use `vim.opt.wrap=true` to turn it on , 2) hard
      wrapping which adds an actual newline that can happen when you are typing and
      and it will type a newline or EOL for you set `vim.opt.wrapmargin=88` to set
      this, but note that this only works when adding text not when editing and 3)
      automatic hard wrapping where a command goes through and fixes and adds EOL
      or newlines you set `vim.opt.textwidth=88` to do this and you can force it
      with gww, but autoformat is off in options.lua put in vim.g.autoformat (g
      means global). is different from hard wrapping which you run with
      gww*motion*. [Soft
      wrapping](https://github.com/LazyVim/LazyVim/discussions/1959) is explained
      here. The confusing thing is what is running `gw` as `:verbose map gw` has
      this just tied to which_key (the key map is very
      [handy](https://www.reddit.com/r/neovim/comments/1bbuxh2/lazyvim_default_keymaps/)
      as is the LazyVim
      [default](https://www.lazyvim.org/configuration/general#keymaps). The second
      thing to understand is that you can use the native vim formatting commands
      which are `gw` and `gq` these run the internal formatter which looks at
      textwidth to do the work. The different is that gw formats and leaves you at
      the top. But gq formats and leaves at the bottom so you can do this
      repetitively. The solution right now is you have to put a hack into the file
      `<!--markdownlint-configure-file { "MD013": { "line_length": 88} } -->` which
      not super bad but painful. The right solution is to fix \cf so that it works
      properly. Usually just doing a `se tw=77` solves this problem.

- [x] MarkdownPreview gives an error message. This is because lazy loading was
      not implemented should be fixed in next release of lazyvim, but this not clear
      how to load LazyVim updates. This magically worked after a while
- [x] shell script using bashls but also need shellcheck for linting and shfmt
      for linting which Mason installs Bashls discovers these.
      [bashls](https://github.com/bash-lsp/bash-language-server)
- [ ] The problem is that conform will also do format checking and you can
      get this conflict specfically, Markdownlint-cli2 wants to see text wrapped at
      80, but I like 88 as this gives a little more space. The gcw commands also
      are at [gq vs.
      gw](https://aijaz.net/2011/12/07/how-to-wrap-text-in-vim/index.html). The
      main issue that because of how word breaks are handled, you can still get
      more than textwidth characters. As an aside, if you want the formatting done
      by Conform using the actual deep formatting programs. The nice ones looks
      like prettier which needs a bunch of configuration [mason, conform, and
      none-ls](https://www.lazyvim.org/extras/formatting/prettier) need
      configurations to use it
- [x] Ruff vs pyright for python to get completions, pydocstyles force and
      black or just use pyright. Ruff with the right setting emulates all
      pydocstyles by enable the 'E' for pycodestyle, 'F' for pyright, 'I' for
      isort. Leaving pyright on for right now.
- [x] Spell checking can be done with the base spelling and ]s, [s, z= and zg
      or or you can use ltex for more advanced stuff and is way busier
- [x] Font does not show correct glyphs looks like this is the lsp. Need to
      brew install the font and then make sure that iterm2 profile uses it in
      `iTerm2 | Settings | Profiles | _Your Profile_ | Text | Font`. Note that 3270
      Nerd Font You should load nerd fonts as these have all the glyphs you need.
      The Usable fonts are Fira Code, Hack, Ubuntu and JetBrains Mono
- [x] Automatic word wrapping is \uw or in options.lua put in
      vim.opt.wrap=true this is set but doesn't seem to work but gw is the old gcc,
      so gw} word wraps to the next empty space
- [x] Change vim.g.mapleader = "\\" in ./lua/config/options.lua
- [x] Change to solarized, edit ./lua/plugins/base.lua add the .nvim file,
      options does not want the .nvim suffix
- [x] :colorscheme still changes this dynamically
      [colorscheme](https://www.lazyvim.org/plugins/colorscheme)

## Finding files with neotree and telescope

Ok, we are way past `:e` and automatic finding, there are two totally
different ways to find things,
[Neotree](https://github.com/nvim-neo-tree/neo-tree.nvim) starts with \e or
\E and you have a pane on the left with bunch of unknown commands, you can
look these up or use `:help neo-tree-mappings` to figure them out.

Some of the important commands are:

- `.` sets the root to the current folder. Note that if you go to the root
  and press `Backspace` it will move up to the parent and set that as the top
  of Neo-tree
- `/` will do a fuzzy search across the whole file tree
- `H` will show you hidden files
- `o` will reorder the tree
- `gA` does a git add!, `gc` does a git commit, `gp` does a git push
- Note that you can move to different windows (they call panes windows) with
  the `Ctrl-w` and you can add a modifier like hjkl to move in different
  windows or q to close a window. and CTRL-w twice switched to the last window.

Telescope is a completely different interface with a modal dialog box you get
with `\f` so you can get to neo-tree with `\fe` but \f gives you fuzzy
finding quickly vs lots of browsing with neo-tree.

This gives you a preview of the file and you can do things like `CTRL-f` to
move the preview forward and to move in the windows you need `CTRL-j` as
movements since typing regular characters does the fuzzy find.

TElescope also works in text, so `gd` means to to definition in text

## 💤 LazyVim Starter

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim). Refer
to the [documentation](https://lazyvim.github.io/installation) to get
started. This is forked at
[nvim.lazyvim](https://github.com/richtong/nvim.lazyvim)

## Decomposing the LazyVim Starter

This uses Lazy.nvim to install components

- [LazyVim](https://www.lazyvim.org/configuration/examples):
- [Gruvbox](ellisonleao/gruvbox.nvim) - Theme
- [Trouble](https://github.com/folke/trouble.nvim) - pretty list for all the
  trouble in your code
- [Nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) - Like
  airline, this is for status

Major components for an IDE so Mason > Nvim-lspconfig, nvim-telescope,
nvim-treesitter

- [Mason](https://github.com/williamboman/mason.nvim) - Manager for LSP, DAP
  (Debug Adapter Protocol), linters, formatters, it needs plugins to add LSPs,
  DSPs, Linters and Formatters. so it need Nvim-lspconfig, nvim-dap. In the old
  days CoC grew into this by adding an LSP plugin system since code completion,
  linting and formatting are highly related.
- [Nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - configuration
  helper for the native Language Server Protocol. It adds some standard
  keystrokes like \-] to goto definition and C-X, C-O to do manual completion.
  YOu need an autocompletion plugin to do this automatically. [d and ]d is go
  to previous and next. Use `:LspInfo` to control it. With opts.servers, you
  can add things like pyright or typescript etc. LSPs provide syntax, they
  provide linting and other things.
- [Nvim-telescope](https://github.com/nvim-telescope/telescope.nvim) - A
  fuzzy finder like fzf and has modular components and can use fzf underneath.
  \fp finds telescope plugins, but not that if you install fzf in LazyExtras,
  you get a conflict with telescope, so only install telescope, it seems fine
  and fast.
- [Nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) -
  much smarter highlighting as it understands the abstract symbol tree for code
  and so coloring works well.

Note sure why this is needed above what mason adds

- [Nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Code completion manager
  can use LSPs, needs a snippet engine like vsnip, luasnip, ultisnips or snippy
  and use [cmp-emoji](https://github.com/hrsh7th/cmp-emoji) to add Emoji
  completions. Source downstream components. This is like CoC in the vim days.

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
- [Avante](https://github.com/yetone/avante.nvim) - attempts to emulate VS
  Code cursor

## LunarVim

This is another opiniated versino so goo to analyze it
[LunarVim](https://lunarvim.org) and not surprisingly it uses the same base
components

Base components that are the same as LazyVim

- [Lazy.nvim](https://github.com/folke/lazy.nvim). Sames as Lazyvim
- [https://github.com/williamboman/mason.nvim](https://github.com/williamboman/mason.nvim).
  Same as Lazyvim to install LSP, DAP, linters, and formatters
- [NVim-lspconfig](https://github.com/neovim/nvim-lspconfig). Same as
  Lazyvim. To ease LSP configuration
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
  Really useful, a place on the internet that validates YAML and JSON. I've
  been using this with comment lines in CoC
- [https://github.com/lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
  Figures out where to indent sounds like a smart autoindent.

There are things for completions:

- <https://github.com/hrsh7th/nvim-cmp>. The completion tool
- <https://github.com/rafamadriz/friendly-snippets> preconfigured snipets
- <https://github.com/L3MON4D3/LuaSnip> - snips are needef ro the completion
  stuff
- <https://github.com/saadparwaiz1/cmp_luasnip>. completions for lua source
- <https://github.com/hrsh7th/cmp-buffer>. For buffers
- <https://github.com/hrsh7th/cmp-path>. for paths

Additional components it has:

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim).
  Some glue logic I don't understand really important for Windows users
  apparently and adds LspInstall.
- [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim/). So that you can
  use LSPs that are not pure lua. Coc.nvim allows this natively, but this needs
  a plugin.
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

New files vs lazyvim starter that I probably need to look at but not install
at first

- tamago324/nlsp-settings.nvim. Sets the JSON/YAML LSP
- <https://github.com/folke/tokyonight.nvim>. A pretty theme
- <https://github.com/lunarvim/lunar.nvim>. A color schcme
- <https://github.com/Tastyep/structlog.nvim>. A better logging output for
  lua.
- <https://github.com/nvim-lua/popup.nvim>. Popup manager
- <https://github.com/nvim-lua/plenary.nvim>. library for lunarvim
- [https://github.com/goolord/alpha-nvim](https://github.com/goolord/alpha-nvim).
  I think greeter screens are pretty ugly
- [https://github.com/akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim).
  Change your workflow so you live inside vi and run shell. I normally do it
  the other way around.
- [https://github.com/RRethy/vim-illuminate](https://github.com/RRethy/vim-illuminate).
  Highlight an entire word not just the character. Sounds distracting
- [https://github.com/lunarvim/onedarker.nvim](https://github.com/lunarvim/onedarker.nvim)
  colorscheme

## Comparison with .vimrc as of August 2024

There are two different installations in the `.vimrc`:

Things to merge in:

- I truly hate the space as the LEADER key, so change back to the Backslash
- [vim-colors-solarized](altercation/vim-colors-solarized). Gruvbox is kind
  of ugly
- [machakann/vim-sandwich](https://github.com/machakann/vim-sandwicht). I use
  this an incredible about like saW to add quotes around a word
- iamcco/markddown-preview.nvim. I do a lot of markdown and this is useful
- airblade/vim-gitgutter - this is actually very useful
- pdrohdz/vim-yaml-folds - use za and zR to open and close vim-yaml-folds
- ygddroot/indentline - shows small vertical for tabs, great for python and
  yaml

Things I'm not sure about:

- preservim/nerdcommenter - Note says this is for mypy. Note sure
- preservim/nerdtree - the tree view at the starter
- preservim/nerdtree-git-plugin

The duplicates that I don't need:

- [Vim-airline](https://github.com/vim-airline). I as using powerline, but
  this broke, so returned

Things that are rarely used and I can drop:

- [preservim/vim-solarized8](https://preservim/vim-solarized8). 24-bit true
  color got graphical interface versions of vim
- tpope/vim-git-plugin - Let's you do :G commit, but I don't use much
- madox2/vim-ai - :AI gives you chatgpt, use ai plugin instead

### neovim

This is the later installation that uses CoC for the LSP

- exafunction/codeium.vim. Should use this more C-[ and M=] for next
  suggestion

Thing I don't need which is COC since we are using the native LSP:

- neoclide/coc.nvim
- neclide/coc-ruff

### vim

This uses syntastsic since vim is single threaded and does not allow async. I
haven't used this in a while

- vim-syntastic/syntastic

Note that you do want to install Lazy Extras with :LazyExtras first

This has most of the features I need, so most of the other things are manual
configurations that you can do if you need more than LazyExtras:

- lang.json: Json
- lang.markdown: enables markdown.nvim
- lang.python
- lang.helm
- coding.mini.surround: gives me the sandwich back!

However this doesn't include things like bashls so you still need some of
this

## The new Git workflow

Ok there is lazygit inside this thing so you don't have to leave neovim to
commit, just run \gg and then a 'c' commits and a 'P' pushes. Kind of nice
although I'm used to being in the shell doing this

## Dealing with Spelling

I was using coc-spell but LazyVim just uses the standard vim
[spelling](https://stackoverflow.com/questions/27680639/vim-automatically-advance-to-next-misspelled-word-after-taking-action-on-curren)
keys, so instead of saw too add a word, it is the usual ]s and [s to find
misspells and z= for spelling proposal and zg to add it to the dictionary

## LazyVim customization

Note that LazyVim has it's own customization system. Instead of calling
things directly, you return these massive JSON lists that LazyVim deals with
them.

The general form is:

1. An array with the name of the plugin, so if you `return
{"crafxdong/solarized-osaka.nvim"}` in any .lua file in ./lua/plugins, it
   will just load \*
2. If you want to set options, then add into that array an opts and then a
   `opts` array with the options so return {"LazyVim/LazyVim", opts = {
   colorscheme = "solarized",}}"
3. Note that with Lua, you can just keep adding commas, to return an entire
   gigantic structure
4. One important thing that you can add is a dependencies tag with a list of
   plugins that are required, there is a of these
   [options](https://www.lazyvim.org/configuration/plugins), but they are mainly
   opts and dependences and ft for filetypes that should activate the plugins

## Customizing LSP for things not in LazyExtras

The more complex plugins like "neovim/lsconfig" will have a huge list of
things that can go into opts. The most important is `servers` which list the
LSPs to add. When you get the right name, then mason will automatically
install them But you can look into eash function like
[LSP](https://www.lazyvim.org/plugins/lsp) to see what they are.

By default, lazyvim does not support bash, it has pyright, lua_ls, vtsls and
jsonls and you get more with LazyExt- [ ] ras, here are the things that you
can't get

The configuration is pretty mysterious, but basically go to the [server
Configuration](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls)
in nvim-lspconfig and look for the actual string that is the server and then
go to the ./lua/config and put this into a lua file, I use `base.lua` because
I saw this was the name in the full lazyvim configuration, then if you just
put this name in, then Mason will install what it needs. Note these names are
not necessarily the which is

You need to look for the string in the middle of the
`require'lspconfig'.jedi_language_server.setup()` in each of the entries in
the server configuration. But basically after you list the servers, you can
put in the {} brackets the setup options for each

So in the example below the jsonls requires things, if you look into the
normal code, the stuff after the require setup is what you need And at the
end there is a setup which has other things you can run for custom setups

Note that for things like schemes, you can always add them directly into your
YAML file with a
[comment](https://github.com/LazyVim/LazyVim/discussions/1905) but it looks
like this is already laoded by
[default](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/yaml.lua)
so not needed.

This is for the things that you can't get which are:

1. Autoformat on save, is a life saver which you can set in options.lua with
   the vim.g.autoformat_on_save or it can be an option for nvim-lspconfig only
1. [format.lua](https://github.com/LazyVim/LazyVim/discussions/141) and you
   can change dynamically with \uf

```````lua { "neovim/nvim-lspconfig", opts = { servers = { bashls = {},  ##
bash -- override the defaults settings = { -- what every you like }, },
autoformat = true, }, }, ```

  ### Markdown support

  This is automatic with configurations setting with LazyVim is very
  confusing, so it uses markdownlint-cli2 and it looks like they are
  configured in
  [nvim-lint](https://github.com/LazyVim/LazyVim/discussions/4094) Overall
  the configurations of this stuff are really confusing, since a tool like
  this since it is not part of a LSP is handled either directly as a plugin
  or with null-ls

  Note that word wrap doesn't appear to work with markdown, so it is not
  clear what is handling that

  ### Bash: Bashls and Shellcheck and conform and shfmt

  Bash is a poor step child in the LSP world. The [Bash
  LSP](https://github.com/bash-lsp/bash-language-server/issues/104) is for a
  relatively initially limited to set of things, specifically symbol
  highlighting ,jump to definition and and autocomplete. This is not like
  other LSPs like ruff which includes linting and formatting. But they did
  add shellcheck integration and now shfmt

  Shellcheck works out of the box if shellcheck is installed with brew
  install shellcheck.

  [shfmt](https://github.com/LazyVim/LazyVim/discussions/315) is also used
  but and it seems to be enabled by default and setting autoformat works Note
  that shfmt options even with autoformat_on_save set does not autoformat

  To see what is going on, you can look at the main
  [LazyVim](https://github.com/LazyVim/LazyVim/tree/main) repo but the
  documentation shows the default configuration in the Plugins and Extras
  section.

  instead LazyVim has LazyFormat which uses
  [conform](https://www.lazyvim.org/plugins/formatting) to do editing

  Setting options is harder and is not part of the neovim installation
  instead, you so you need to set ~/.editorconfig shfmt see
  [discussion](https://github.com/bash-lsp/bash-language-server/pull/1165)

  Also not that autoformat_on_save is not enabled by default with bashls but
  this is not turned on by default in bash-ls.

  ### Language specific LSP plugins

  Each language may have additional configuration beyond the current one, so
  you also need to load [language
  specific](https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins).
  You stick these into the additional dependencies.

  Note that if you delete the installation then Mason does not remove them so
  you either have to manually not autostart them or do a `MasonUninstallAll`
  to get rid of all the plugins and then on next start of neovim, it will
  install just the ones in your configuration. The `Mason` is also
  convenient. There is no uninstall but you can see where the items are
  coming from by what's calling them.

  Note that you can see everything loaded with `:Mason` The default ones
  already installed but you can add parameters and override configurations in
  ./lua/plugins:

  - pyright. This is the Microsoft default
  [server](https://www.andersevenrud.net/neovim.github.io/lsp/configurations/pyright/)
  - vtsls.
  - jsonls. The JSON one is already installed and you get schemastore if you
  use LazyExtras
  - ltex-ls. grammar-guard.nvim and ltex_extra.nvim which can also do
  markdown, but the spell check is just insanely wordy. I use the standard
  spell checker instead
  - ltex vs markman. These support both markdown (and ltex does Latex too and
  is very wordy with spell check

  ## The confusion which is Python and Debugging

  As usual Python has an amazing host of overlapping LSPs and tools but the
  two that are in conflict are pyright the default and ruff which is what I
  want to use. There are two tricks here, first you have to make sure pyright
  doesn't run and then you have to set a million ruff options

  Competing ones which I don't use:

  - jedi. This is the original LSP that I've used before, you get this as a
  full LSP `jedi_lanaguage_server` but ruff seems better
  - russ vs pyright. Ruff is faster as it is written in rust and is a
  superset of pyright. Since pyright is native to LazyVim, you have to
  explicitly disable it. Right now I leave it on.
  - russ configuration. Note that you have this special dictionary called
  settings init_options > setting before you get to the meat. And they you
  have a million lint settings. I have this turned way up including
  documentation checks.

  ```lua { "neovim/nvim-lspconfig", opts = { servers = { pyright = { mason =
  false, autostart = false}, ruff = { init_options = { settings = {
  lineLength = 88, -- black replacement and 88 is now default organizeImports
  = true, -- isort replacement lint = { select = { "F", -- pyright "E", --
  pycodestyle "W", -- pycodestyle warnings "C", -- mccabe code complexity
  "I", -- isort "N", -- PEP8 naming "D", -- pydocstyle docstrings "UP", --
  pyupgrade "YTT", -- flake8-2020 "ANN", -- flake8-annotations "S", --
  flake8-bandit "FBT", -- flake8-boolean-trap "B", -- flake8-bugbear "A", --
  flake8-builtin showing "COM", -- flake8-commas missing "C4", --
  flake8-comprehensions simplification "DTZ", -- flake8-datetimez errors
  "EM", -- flake8-errmsg "EXE", -- flake8-executalbe "PTH", --
  flake8-use-pathlib no os.path "PD", -- pandas-vet "PL", -- pylint refactor,
  warn, errors "NPY", -- numpy "PERF", -- perflint "DOC", -- pydoclint "RUF",
  -- ruff specific rules }, }, }, }, }, }, }, }, ```

  These could compete with vtsls:

  - stylelint. for css
  - eslint. The typescript vs. vtsls
  - superhtml - html linting, does vtsls have this?
  - yamlls - does jsonls competed, you can tell by opening a .yaml file and
  then :LspInfo to see what is attached

  The many python ones

  - pylsp - Another python LSP
  - pylizer - Code analyzer
  - pyre - static type checker
  - pyright - the default in lazyvim, have to decide if we should convert to
  it or to ruff

  ## Configuring Russ

  Russ is so powerful, but you have to set the flags right. you probably
  don't want "ALL", but this is a good list. You should also put this into
  your pyproject.toml and then turn on pre-commit so that you have the same
  test.

  ```lua ruff = { settings = { lineLength = 80, -- black replacement
  organizeImports = true, -- isort replacement lint = { select = { select = {
  "F", -- pyright "E", -- pycodestyle "W", -- pycodestyle warnings "C", --
  mccabe code complexity "I", -- isort "N", -- PEP8 naming "D", -- pydocstyle
  docstrings "UP", -- pyupgrade "YTT", -- flake8-2020 "ANN", --
  flake8-annotations "S", -- flake8-bandit "FBT", -- flake8-boolean-trap "B",
  -- flake8-bugbear "A", -- flake8-builtin showing "COM", -- flake8-commas
  missing "C4", -- flake8-comprehensions simplification "DTZ", --
  flake8-datetimez errors "EM", -- flake8-errmsg "EXE", -- flake8-executalbe
  "PTH", -- flake8-use-pathlib no os.path "PD", -- pandas-vet "PL", -- pylint
  refactor, warn, errors "NPY", -- numpy "PERF", -- perflint "DOC", --
  pydoclint "RUF", -- ruff specific rules }, }, }, }, ```

  ## Python Debugging with nvim-dap

  Wow this is super powerful, but if you start python, then if you <leader>d
  you will get a debugging window and if you do a \dC, it will stop at the
  current Python line. \dr starts a REPL and \da starts with arguments.

  I was getting some type of run time error, but definitely worth figuing
  out.

  ## Completions vs LSP vs Linting vs Formatting

  Confusingly the LSP can do many things but sometimes not others. For
  instance, bash-ls does linting but not formatting, so you need shfmt for
  this and it does not seem to autoformat correctly like :Black used to do.

  Generally through, completions of what you type are handled by nvim-cmp and
  nvim-lsp-config handles the LSPs which general do syntax checking.
  formatting and linting I've not quite figured out yet. But ruff for
  instance does linting too.

  If you look at LazyExtras and LazyVim it's hard to tell.

  ## Recipes

  This is a very useful of
  [recipes](https://www.lazyvim.org/configuration/recipes) for the neovim
  community. Here are some of the most useful ones.

  Supertab let's you use the Tabl key for completions and snippets with a
  pretty big
  [snippet](https://www.lazyvim.org/configuration/recipes#supertab) to enable
  it that I put in [supertab.lua](plugins/supertab.lua)

  ## New keymaps to learn

  1. Diagonostics Changed key maps ]g and [g are now ]d and [d for going to
  next error and fixes are [g and [g and if you want to look at the lists
  then its \x and \xx will give the errors in a windows at the bottom,
  navigate and on a particular error, press enter to get to that line, really
  handy and then to go back with ^W^W. And close with q.
  1. Adding a comment is now gco and gcO, toggle comment is gcc from the old
  \cc
  1. Buffer command :bd are now \bd and moving is S-h, l and ]b and [b from
  bufferline.nvim and \be turns on and off the buffer explorer
  1. Location and Quickfix lists at \xl and \xq
  1. set relnumber is now \uL, Autoformat is \uf, Spelling is \us and Wrap is
  \uw but you should turn these on in base.lua
  1. starting lazygit is \gg at root dir or \gG for in current directly \gb
  is blame
  1. \uI inspect syntax tree of current file
  1. Finding files with \ff for files, \fb for buffer, type \f for help
  1. Manual word wrap gww and gw} for next blank space

  ### Sandwich and surround

  I use these alot with vim-sandwich before, but the new LazyVim version is
  [mini-surround](https://github.com/echasnovski/mini.surround)

  - Actions are similar, `sa` means add, `sd` delete, `sr` replace, `sf`
  find, `sh` highlight
  - The next character tells you what to do
  - `f` function call
  - `()`, `[]`, `{}` get you to to those special characters

  And note that which-key gives you instructions which is nice!

  ```vim gsaiw"  -  Go Surround Around Insert Word a quotes gsd"    -  Go
  Surround Delete Quotes gsr"[   -  Go Surround Replace " with [ ```

  This does not seem to work though which you can debug with `:map` and it
  looks like . `s` is used by flash in Treesitter and some work leads you to
  the `gsa` keys

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

    1. \cp markdown markddown-preview ```` ````` ``````
```````
