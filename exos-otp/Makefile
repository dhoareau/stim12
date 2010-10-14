SOURCES := $(wildcard *.erl)
OBJECTS := $(SOURCES:.erl=.beam)

main:
	make $(OBJECTS)

%.beam:%.erl
	erlc $<

clean : 
	rm *.*~
