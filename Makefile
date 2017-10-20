PREFIX = /usr/local

po :
	$(MAKE) -C i18n


install : sh mo

sh :
	install -m0755 -t $(PREFIX)/bin rpi-image-tool
	install -m0644 -t $(PREFIX)/bin rpi-image-tool.lib


mo : en

en :
	install -m0755 -d $(PREFIX)/share/locale/$@/LC_MESSAGES
	install -m0644 -t $(PREFIX)/share/locale/$@/LC_MESSAGES ./locale/$@/LC_MESSAGES/rpi-image-tool.mo




uninstall :
	find $(PREFIX) -name "rpi-image-tool*" -exec rm {} \;


