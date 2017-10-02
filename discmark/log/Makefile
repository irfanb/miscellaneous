LIBDIRS=
INCDIRS=-I /home/irfan/et/et-beta-4/src
CXXDEBUG=-g

all: liblog.a

liblog.a: logsource.o logsink.o
	ar -ruv $@ $?

logsource.o: logsource.cpp logsource.h
	g++ -c $(CXXDEBUG) $(INCDIRS) \
   logsource.cpp

logsink.o: logsink.cpp logsink.h
	g++ -c $(CXXDEBUG) $(INCDIRS) \
   logsink.cpp

TAGS:
	ctags -R -otags --lang=c++ /home/irfan/elcel/src/lib


