# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1
inherit gnome2-utils

DESCRIPTION="A GTK+ front-end for the SopCast P2P TV player"
HOMEPAGE="http://code.google.com/p/sopcast-player/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="unstable"
KEYWORDS="~amd64"
IUSE="totem +vlc gnome-mplayer"

DEPEND=">=sys-libs/libstdc++-v3-3.3.6
		>=virtual/libstdc++-3.3
		totem? ( >=media-video/totem-2.32.0-r2  )
		gnome-mplayer? ( >=media-video/gnome-mplayer-1.0.5_beta1 )
		vlc? ( >media-video/vlc-1.10 )
		dev-lang/python[sqlite]
		sys-devel/gettext
		"
RDEPEND="${DEPEND}
	dev-python/pygtk
	dev-python/pygobject
	media-tv/sopcast-bin
	"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install \
	|| die "emake install failed"
}

pkg_postinst() {
	gnome2_icon_cache_update
}
