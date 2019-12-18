VERSION= $(shell awk '$$1 ~ /version/ { gsub(/"/, ""); print $$3; }' conf.moon)
UNAME= $(shell uname | tr A-Z a-z)

CC= moonc
ENGINE= amulet
EXPORT= $(ENGINE) export -r
SRC= $(wildcard *.moon */*.moon)
TARGET= $(SRC:.moon=.lua)
RM= rm -rf

#-------------------------------------------------------------------------------
.PHONY: clean install mrproper test linux darwin mac win windows


all: $(TARGET)


install: $(UNAME)


test: $(TARGET)
	@echo -n 'starting '
	$(ENGINE)


clean:
	$(RM) $(TARGET)


mrproper: clean
	$(RM) pizza-*.zip pizza-*-android


%.lua: %.moon
	$(CC) $<


linux: pizza-$(VERSION)-linux.zip

pizza-$(VERSION)-linux.zip: $(TARGET)
	$(EXPORT) -linux .


darwin: mac

mac: pizza-$(VERSION)-mac.zip

pizza-$(VERSION)-mac.zip: $(TARGET)
	$(EXPORT) -mac .


win: windows

windows: pizza-$(VERSION)-windows.zip

pizza-$(VERSION)-windows.zip: $(TARGET)
	$(EXPORT) -windows .
