# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  Exp $

EAPI=5
inherit git-2 xorg-2

DESCRIPTION="CMT Touchpad driver with gestures"
KEYWORDS="-*"

RDEPEND=">=x11-base/xorg-server-1.10.99
	x11-libs/libevdev
	x11-libs/gestures"
DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://git.chromium.org/git/chromiumos/platform/${PN}.git"

