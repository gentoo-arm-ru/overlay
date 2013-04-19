# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  Exp $

EAPI=5
inherit git-2

DESCRIPTION="EVDEV Library"
KEYWORDS="-*"

RDEPEND=">=x11-base/xorg-server-1.10.99"
DEPEND="${RDEPEND}"
SLOT=0
EGIT_REPO_URI="https://git.chromium.org/git/chromiumos/platform/${PN}.git"

src_prepare() {
	sed -i 's/-fstack-protector-strong //' "${S}"/common.mk
	sed -i 's/-Werror //' "${S}"/common.mk
}

src_compile() {
	make
}

src_install() {
	make DESTDIR="${D}" install
}

