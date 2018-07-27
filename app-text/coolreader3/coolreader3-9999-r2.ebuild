# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

EGIT_REPO_URI="git://crengine.git.sourceforge.net/gitroot/crengine/crengine"

HYP_ARCH="AlReader2.Hyphen.zip"

DESCRIPTION="CoolReader - reader of eBook files (fb2, epub, htm, rtf, txt)"
HOMEPAGE="http://www.coolreader.org/"
SRC_URI="hyphen? ( http://www.alreader.com/downloads/${HYP_ARCH} )"

inherit git-2
inherit cmake-utils
inherit flag-o-matic
inherit qmake-utils
inherit xdg-utils

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+qt5 wxwidgets hyphen"

DEPEND="sys-libs/zlib
	media-libs/libpng
	virtual/jpeg
	media-libs/freetype
	wxwidgets? ( app-eselect/eselect-wxwidgets
		>=x11-libs/wxGTK-2.8 )
	qt5? ( dev-qt/qtcore:5
		dev-qt/qtgui:5 )
	hyphen? ( app-arch/unzip )"
RDEPEND="${DEPEND}
	media-fonts/corefonts"

REQUIRED_USE=" ^^ ( qt5 wxwidgets )"

src_unpack() {
	git-2_src_unpack
	if 	use hyphen; then
		unpack ${HYP_ARCH}
	fi
}

src_prepare() {
	# fix for amd64
	if use amd64; then
		sed -e 's/unsigned int/unsigned long/g' -i "${WORKDIR}/${P}/crengine/src/lvdocview.cpp" \
		|| die "patching lvdocview.cpp for amd64 failed"
	fi
}

src_configure() {
	CMAKE_USE_DIR="${WORKDIR}"/"${SRC_UNPACK}"/"${P}"
	CMAKE_BUILD_TYPE="Release"

	if use qt5 && ! use wxwidgets; then
		mycmakeargs="-D GUI=QT5"
	elif use wxwidgets && ! use qt5; then
		. "${ROOT}/var/lib/wxwidgets/current"
		if [[ "${WXCONFIG}" -eq "none" ]]; then
			die "The wxGTK profile should be selected!"
		fi
		mycmakeargs="-D GUI=WX"
	else
		die "Only one GUI must be selected"
	fi

	append-cxxflags $(test-flags-CXX -bbdb3 -fPIC)
	append-cxxflags -std=gnu++11
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use hyphen; then
		cd "${WORKDIR}"
		insinto /usr/share/crengine
		find . -name "*hyphen*pdb" -exec \
			doins {} \;
	fi
	dosym ../fonts/corefonts /usr/share/crengine/fonts
}

pkg_postinst() {
	xdg_desktop_database_update
}
