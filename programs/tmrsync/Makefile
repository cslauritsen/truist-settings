all: install
CURRENT_UID := $(shell id -u)
install: tmrsync tmrsync.sh
	install tmrsync tmrsync.sh /usr/local/libexec/
	install com.planetlauritsen.tmrsync.plist $(HOME)/Library/LaunchAgents
	launchctl enable user/$(CURRENT_UID)/com.planetlauritsen.tmrsync

tmrsync: tmrsync.c
	gcc -Wall -o tmrsync tmrsync.c

clean:
	launchctl disable user/$(CURRENT_UID)/com.planetlauritsen.tmrsync
	rm -f tmrsync *.o ~/Library/LaunchAgents/com.planetlauritsen.tmrsync.plist


