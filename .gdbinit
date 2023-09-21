set print demangle on
set demangle-style auto
set verbose on
set language c++
set print vtbl on
set print object on
set print symbol on
set print pretty on
set history size 500000
set history save on
set history expansion on
set history filename ~/.gdb_history
set logging on
set logging overwrite on
# TODO make a separate directory for this:
#set directories ~/githome/
#set print elements 0
set debug-file-directory .

handle SIGINT stop

# if loading symbols for your shared objects takes a long time, you can disable this by default
# set auto-solib-add off
# then you can load shared libraries by hand like so:
# sharedlibrary libTest

#skip -file std_function.h
skip -gfile /opt/gcc-7.3.0/include/*

tui enable

define bpl
info breakpoints
end
document bpl
List breakpoints
end

define threads
info threads
end
document threads
Print threads in target
end

define qquit
  set confirm off
  quit
end
document qquit
Quit without asking for confirmation.
end

define wc
where
cont
end
document wc
where followed by cont
end


python
import sys
sys.path.insert(0, '/home/ibutt/gdb_printers/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end


# you might need this if you're running gdb on a mac
#set startup-with-shell off

# Notes on remote debugging:
# https://developers.redhat.com/blog/2015/04/28/remote-debugging-with-gdb
# If you want to debug an application running in a kubernetes (k8s) cluster,
# you can try this:
# On the machine which is hosting gdb, run gdb, then run:
# target extended-remote | kubectl exec -n gg -it ubuntu -- gdbserver - /tmp/helloworld
# This will cause the local instance of gdb to run gdbserver on a k8s pod called "ubuntu"
# in a namespace "gg", debugging the executable /tmp/helloworld.
# The "--" seperates the options to kubectl from the command(s) you want kubectl to run
# The "-" causes gdbserver to debug over stdio.  In order to see the sources, they
# will need to be in the same directory as the working directory for gdb

