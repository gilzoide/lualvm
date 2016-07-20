## LuaLVM Makefile ##

export pkgName := lualvm

# LuaRocks stuff
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
LIBDIR = $(PREFIX)/lib/lua/5.3/$(pkgName)
LUADIR = $(PREFIX)/share/lua/5.3
CONFDIR = $(PREFIX)/etc


# My stuff
export buildDir := $(CURDIR)/build
export libDir := $(buildDir)/$(pkgName)
export includeDir := $(CURDIR)/include

srcdir = src
permissions = 644


# now build!
all : buildDir lualvm

buildDir :
	@mkdir -p $(buildDir)
	@mkdir -p $(libDir)

lualvm :
	$(MAKE) -C $(srcdir)


install :
	install -m $(permissions) $(libDir)/*.so $(LIBDIR)
	install -m $(permissions) $(buildDir)/*.lua $(LUADIR)

.PHONY : clean
clean :
	$(MAKE) -C $(srcdir) clean
	$(RM) -r $(buildDir)/*
