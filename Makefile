DESTDIR       =
PREFIX        = /usr/local
bindir        = $(PREFIX)/bin
localedir     = $(PREFIX)/share/locale
#mandir        = $(PREFIX)/share/man

INSTALL       = /usr/bin/env install

po :
	$(MAKE) -C i18n


install : sh mo

sh :
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -m0755 -t $(DESTDIR)$(bindir) rpi-image-tool
	install -m0644 -t $(DESTDIR)$(bindir) rpi-image-tool.lib


mo : en

en :
	$(INSTALL) -d $(DESTDIR)$(localedir)
	$(INSTALL) -m0755 -d $(DESTDIR)$(localedir)/$@/LC_MESSAGES
	$(INSTALL) -m0644 -t $(DESTDIR)$(localedir)/$@/LC_MESSAGES ./locale/$@/LC_MESSAGES/rpi-image-tool.mo




#uninstall :
#	find $(PREFIX) -name "rpi-image-tool*" -exec rm {} \;


