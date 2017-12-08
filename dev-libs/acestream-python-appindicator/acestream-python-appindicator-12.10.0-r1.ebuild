# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
MY_PN="${PN#acestream-}"
SRC_URI="x86? ( https://launchpad.net/ubuntu/+source/libappindicator/12.10.0-0ubuntu1/+build/3649098/+files/python-appindicator_12.10.0-0ubuntu1_i386.deb )
		amd64? ( https://launchpad.net/ubuntu/+source/libappindicator/12.10.0-0ubuntu1/+build/3649098/+files/python-appindicator_12.10.0-0ubuntu1_amd64.deb )"
LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.26
	>=dev-libs/libdbusmenu-12.10.2-r2:0[gtk]
	dev-libs/libappindicator:2
	>=x11-libs/gtk+-2.24.12:2"
DEPEND="${RDEPEND}"

QA_PRESTRIPPED="usr/lib/python2.7/site-packages/appindicator/_appindicator.so"

S="${WORKDIR}"

src_prepare(){
	unpack ${A}
	unpack ./data.tar.gz
	mv usr/lib/python2.7/dist-packages usr/lib/python2.7/site-packages
}

src_install() {
	cp -R usr/ "${D}"
	# remove trash and fix needed link
	rm "${D}/usr/share/doc/python-appindicator/README"
	rm "${D}/usr/share/doc/python-appindicator/AUTHORS"
	rm "${D}/usr/share/doc/python-appindicator/changelog.Debian.gz"
	rm "${D}/usr/lib/pyshared/python2.7/appindicator/_appindicator.so"
	rm "${D}/usr/lib64/pyshared/python2.7/appindicator/_appindicator.so"

	dosym "${D}/usr/lib/python2.7/site-packages/appindicator/_appindicator.so" \
	"/usr/lib/pyshared/python2.7/appindicator/_appindicator.so"

	dosym "${D}/usr/lib64/python2.7/site-packages/appindicator/_appindicator.so" \
	"/usr/lib64/pyshared/python2.7/appindicator/_appindicator.so"
}
