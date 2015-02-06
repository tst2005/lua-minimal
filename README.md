# lua-minimal

It's a small set of util to be able to manage lua module easily

Features :
  * allow to use `require("newmodule")` (even the newmodule.lua file is not in the lua path)
  * `require()` will always search about ?/init.lua file (even in local)

The lua-minimal is used inside the [Dragoon Framework](https://github.com/tst2005/dragoon-framework).

# Standalone use

```
$ git clone https://github.com/tst2005/lua-minimal
Cloning into 'lua-minimal'...

$ cd lua-minimal
$ git submodule init
$ git submodule update
Cloning into 'newmodule'...
Cloning into 'provide'...

$ cd ..
$ lua -l lua-minimal.init -l newmodule -l provide -e 'print"ok"'
ok

```

# Path Fix

By default the `package.path` will be fixed

To disable this behavior (do not change the `package.path`) :
```
require("lua-minimal.pathfix").autoinstall = false
```


# TODO

 * change the init.lua to try to load the submodule version and fallback to the local one if fail

