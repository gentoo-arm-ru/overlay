# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  Exp $

EAPI=5
inherit git-2 toolchain-funcs multilib

DESCRIPTION="Gestures library"
KEYWORDS="-*"
SLOT=0

EGIT_REPO_URI="https://git.chromium.org/git/chromiumos/platform/${PN}.git"

RDEPEND=">=x11-libs/libchrome-180609
	x11-libs/libevdev
	dev-cpp/gflags
	sys-fs/udev
	x11-libs/pixman"
DEPEND="dev-cpp/gtest
	x11-libs/libXi
	${RDEPEND}"


src_prepare() {
    sed -i "s#-I\.\.#-I${WORKDIR}#g" "${S}"/Makefile
    ln -sf "${S}" "${WORKDIR}/${PN}"
}

LIBCHROME_VERS=180609

src_compile() {
	tc-export CXX
	cros-debug-add-NDEBUG
	export BASE_VER=${LIBCHROME_VERS}

	emake clean  # TODO(adlr): remove when a better solution exists
	emake
}

