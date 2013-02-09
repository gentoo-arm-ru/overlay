# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  Exp $

EAPI=5
inherit git-2 xorg-2

DESCRIPTION="Generic VESA video driver"
KEYWORDS="-*"
IUSE="-vanilla"

RDEPEND=">=x11-base/xorg-server-1.10.99"
DEPEND="${RDEPEND}"

if ! use vanilla; then
	EGIT_REPO_URI="https://git.chromium.org/git/chromiumos/third_party/${PN}.git"
else
	EGIT_REPO_URI="git://git.linaro.org/arm/xorg/driver/${PN}.git"
fi

src_prepare() {
	use vanilla || epatch "${FILESDIR}/0001-copy-paste-from-omap-driver-to-get-it-compiled.patch"

	xorg-2_src_prepare
}
