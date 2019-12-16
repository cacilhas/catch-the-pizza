CC= moonc
RUN= amulet
SRC= $(wildcard *.moon)
TARGET= $(SRC:.moon=.lua)
RM= rm -f

#-------------------------------------------------------------------------------
.PHONY: clean test


all: $(TARGET)


test: $(TARGET)
	@echo -n 'starting '
	$(RUN)


clean:
	$(RM) *.lua


%.lua: %.moon
	$(CC) $<
