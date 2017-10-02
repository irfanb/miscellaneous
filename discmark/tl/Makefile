all: threadtest libtl.a

OBJS=*.o
CC=gcc
INCLUDE=
LIBS=-lpthread -lstdc++
LIB=-L /usr/lib
CFLAGS=
CPPFLAGS=

clean: $(OBJS)
	rm $(OBJS) libtl.a

%.o: %.cpp
	$(CC) -c $(INCLUDE) $(CFLAGS) $(CPPFLAGS) $< -o $@

threadtest: thread.o threadtest.o mutex.o mutexlock.o
	$(CC) -o threadtest -static thread.o threadtest.o mutex.o mutexlock.o \
	$(LIB) $(LIBS)

libtl.a: thread.o threadtest.o mutex.o mutexlock.o
	ar -rv $@ $?


Makefile.files:
	$(CC) -MM *.cpp > Makefile.files

include Makefile.files

############################################################################
#
# $Log: Makefile,v $
# Revision 1.4  2001/11/19 21:24:53  irfan
# changes
#
# Revision 1.3  2001/11/03 16:55:34  irfan
# No longer using STLport because elcel dont use it anymore and it also
# creates a static library too
#
# Revision 1.2  2001/10/01 00:17:20  irfan
# removed the bash thing which wasnt necessary
#
# Revision 1.1  2001/09/30 22:37:39  irfan
# half sensible 1st stab
#
#
############################################################################

