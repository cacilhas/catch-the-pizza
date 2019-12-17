VERSION= $(shell awk '$$1 ~ /version/ { gsub(/"/, ""); print $$3; }' conf.moon)
UNAME= $(shell uname | tr A-Z a-z)

CC= moonc
ENGINE= amulet
SRC= $(wildcard *.moon)
TARGET= $(SRC:.moon=.lua)
RM= rm -f

#-------------------------------------------------------------------------------
.PHONY: clean install mrproper test linux darwin mac win windows


all: $(TARGET)


install: $(UNAME)


test: $(TARGET)
	@echo -n 'starting '
	$(ENGINE)


clean:
	$(RM) *.lua


mrproper: clean
	$(RM) pizza-*.zip


%.lua: %.moon
	$(CC) $<


linux: pizza-$(VERSION)-linux.zip

pizza-$(VERSION)-linux.zip: $(TARGET)
	$(ENGINE) export -linux .


darwin: mac

mac: pizza-$(VERSION)-mac.zip

pizza-$(VERSION)-mac.zip: $(TARGET)
	$(ENGINE) export -mac .


win: windows

windows: pizza-$(VERSION)-windows.zip

pizza-$(VERSION)-windows.zip: $(TARGET)
	$(ENGINE) export -windows .
