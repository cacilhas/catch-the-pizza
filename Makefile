VERSION= 1.0.0
UNAME= $(shell uname | tr A-Z a-z)

CC= moonc
RUN= amulet
SRC= $(wildcard *.moon)
TARGET= $(SRC:.moon=.lua)
ZIPFILE= pizza-$(VERSION)-$(UNAME).zip
RM= rm -f

#-------------------------------------------------------------------------------
.PHONY: clean export mrproper test


all: $(TARGET)


export: $(ZIPFILE)


test: $(TARGET)
	@echo -n 'starting '
	$(RUN)


clean:
	$(RM) *.lua


mrproper: clean
	$(RM) $(ZIPFILE)


%.lua: %.moon
	$(CC) $<


$(ZIPFILE): $(TARGET)
	$(RUN) export -$(UNAME) .
