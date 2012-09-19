# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
EBZR_REPO_URI="lp:bamf"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+introspection doc static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-util/gdbus-codegen
	dev-libs/glib:2
	dev-libs/libunity-webapps
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libwnck:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16[vapigen]
	dev-util/gtk-doc
	introspection? ( dev-libs/gobject-introspection )
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS COPYING COPYING.LGPL COPYING.LGPL-2.1 ChangeLog NEWS README TODO)
}

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myeconfargs=(
		--disable-gtktest
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
		VALA_API_GEN="$(type -p vapigen-0.16)"
	)

	autotools-utils_src_configure
}

