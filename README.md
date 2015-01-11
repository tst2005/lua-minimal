# lua-minimal

The bootstrap part of Dragoon Framework

# standalone use

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


