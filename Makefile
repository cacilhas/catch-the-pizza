VERSION= $(shell awk '$$1 ~ /version/ { gsub(/"/, ""); print $$3; }' conf.moon)
UNAME= $(shell uname | tr A-Z a-z)

CC= moonc
ENGINE= amulet
SRC= $(wildcard *.moon)
TARGET= $(SRC:.moon=.lua)
ZIPFILE= pizza-$(VERSION)-$(UNAME).zip
RM= rm -f

#-------------------------------------------------------------------------------
.PHONY: clean install mrproper test


all: $(TARGET)


install: $(ZIPFILE)


test: $(TARGET)
	@echo -n 'starting '
	$(ENGINE)


clean:
	$(RM) *.lua


mrproper: clean
	$(RM) $(ZIPFILE)


%.lua: %.moon
	$(CC) $<


$(ZIPFILE): $(TARGET)
	$(ENGINE) export -$(UNAME) .
