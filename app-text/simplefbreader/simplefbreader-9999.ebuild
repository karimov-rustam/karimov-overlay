# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3
# inherit fdo-mime
inherit xdg-utils
inherit gnome2-utils

DESCRIPTION="Simple tool to read FB2 books. Developed using GTK+3"
HOMEPAGE="https://github.com/Cactus64k/simple-fb2-reader"
EGIT_REPO_URI="https://github.com/Cactus64k/simple-fb2-reader"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-devel/gettext-0.19.3
		>=dev-util/cmake-3.0.2
		>=dev-libs/libxml2-2.9.1
		>=x11-libs/gtk+-3.14.5
		>=dev-libs/libzip-0.2.11
		>=dev-db/sqlite-3.8.7.1"
RDEPEND="${DEPEND}"

src_configure() {
	rm -Rf ./debian
	rm -Rf ./slackbuild
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

pkg_postinst() {
	# use prefix && export XDG_DATA_DIRS="${EPREFIX}"/usr/share
	# fdo-mime_mime_database_update
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
