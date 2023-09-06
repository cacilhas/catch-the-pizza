VERSION= $(shell awk 'BEGIN { FS = "\""; } $$1 ~ /version/ { print $$2; }' conf.moon)
ifeq ($(OS),Windows_NT)
	UNAME= windows
else
	UNAME= $(shell uname | tr A-Z a-z)
endif

APPNAME= pizza
MOONC= moonc
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
	$(RM) $(APPNAME)-*.zip $(APPNAME)-*-android


%.lua: %.moon
	$(MOONC) $<


linux: $(APPNAME)-$(VERSION)-linux.zip

$(APPNAME)-$(VERSION)-linux.zip: $(TARGET)
	$(EXPORT) -linux .


mac: darwin

darwin: $(APPNAME)-$(VERSION)-darwin.zip

$(APPNAME)-$(VERSION)-darwin.zip: $(TARGET)
	$(EXPORT) -mac .


win: windows

windows: $(APPNAME)-$(VERSION)-windows.zip

$(APPNAME)-$(VERSION)-windows.zip: $(TARGET)
	$(EXPORT) -windows .
