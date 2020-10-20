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

#skip -file std_function.h
#skip -gfile /opt/gcc-7.3.0/include/*

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
sys.path.insert(0, '/home-nfs/ibutt/gdb_printers/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
