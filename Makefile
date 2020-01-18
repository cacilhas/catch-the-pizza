VERSION= $(shell awk '$$1 ~ /version/ { gsub(/"/, ""); print $$3; }' conf.moon)
UNAME= $(shell uname | tr A-Z a-z)

APPNAME= pizza
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
	$(RM) $(APPNAME)-*.zip $(APPNAME)-*-android


%.lua: %.moon
	$(CC) $<


linux: $(APPNAME)-$(VERSION)-linux.zip

$(APPNAME)-$(VERSION)-linux.zip: $(TARGET)
	$(EXPORT) -linux .


darwin: mac

mac: $(APPNAME)-$(VERSION)-mac.zip

$(APPNAME)-$(VERSION)-mac.zip: $(TARGET)
	$(EXPORT) -mac .


win: windows

windows: $(APPNAME)-$(VERSION)-windows.zip

$(APPNAME)-$(VERSION)-windows.zip: $(TARGET)
	$(EXPORT) -windows .
