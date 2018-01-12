# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit multilib python-r1 unpacker

DESCRIPTION="ACE Stream Engine"
HOMEPAGE="http://torrentstream.org/"
SRC_URI=" amd64? ( http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gtk"

DEPEND="dev-python/m2crypto[${PYTHON_USEDEP}]
		dev-python/apsw[${PYTHON_USEDEP}]
		gtk? ( dev-libs/acestream-python-appindicator )
		dev-python/python-xlib
		dev-python/setuptools
		net-misc/telnet-bsd"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/acestream_3.1.16_ubuntu_16.04_x86_64

QA_PRESTRIPPED="usr/bin/acestreamengine
usr/share/acestream/lib/acestreamengine/Core.so
usr/share/acestream/lib/acestreamengine/node.so
usr/share/acestream/lib/acestreamengine/pycompat.so
usr/share/acestream/lib/acestreamengine/Transport.so
usr/share/acestream/lib/acestreamengine/CoreApp.so
usr/share/acestream/lib/acestreamengine/streamer.so"

pkg_setup() {
	use amd64 && S="${WORKDIR}"/acestream_3.1.16_ubuntu_16.04_x86_64
}

src_install(){
	dodir /usr/share/acestream
	insinto /usr/share/acestream
	cp -R "${S}"/* "${D}/usr/share/acestream" || die "Install failed!"
	dosym /usr/share/acestream/acestreamengine /usr/bin/acestreamengine
}
