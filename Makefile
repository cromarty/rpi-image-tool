PREFIX        = /usr/local
DESTDIR       =
INSTALL       = /usr/bin/env install
bindir        = $(PREFIX)/bin
localedir     = $(PREFIX)/share/locale
#mandir        = $(PREFIX)/share/man


po :
	$(MAKE) -C i18n


install : sh mo

sh :
	$(INSTALL) -m0755 -t $(DESTDIR)$(bindir) rpi-image-tool
	install -m0644 -t $(DESTDIR)$(bindir) rpi-image-tool.lib


mo : en

en :
	echo "running en"
	$(INSTALL) -m0755 -d $(DESTDIR)$(localedir)/$@/LC_MESSAGES
	$(INSTALL) -m0644 -t $(DESTDIR)$(localedir)/$@/LC_MESSAGES ./locale/$@/LC_MESSAGES/rpi-image-tool.mo




#uninstall :
#	find $(PREFIX) -name "rpi-image-tool*" -exec rm {} \;


