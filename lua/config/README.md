# Configuration

Note that in [./plugins](./plugins) you will find all the plugins you need and
all of these are loaded but here, only the defined plugins are loaded.

autocmds.lua - Just use for changing autocmd
keymaps.lua - The central place for changing keys
lazy.lua - this is the minimum configuratino
options.lua - This is where you put the require('plugin').setup() {}

## Note on options.lua vs ./plugin/foo.lua

You can actually put your require('plugin').setup() in options.lua
Or you can put them in ./plugins but then you don't need the require, because
the whole thing is fed as a string.

So for things that are not going to change much, put them in ./plugins. Things
like API keys for instance.
