# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_P="sp-auth"

DESCRIPTION="SopCast free P2P Internet TV binary"
LICENSE="SopCast-unknown-license"
HOMEPAGE="http://www.sopcast.com/"
SRC_URI="http://download.sopcast.com/download/${MY_P}.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="
	>=virtual/libstdc++-3.3
	"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	cd ${S}
	exeinto /opt/${PN}
	doexe sp-sc-auth
	dosym /opt/${PN}/sp-sc-auth /usr/bin/sp-sc
	dodoc Readme || die "dodoc failed"
}
