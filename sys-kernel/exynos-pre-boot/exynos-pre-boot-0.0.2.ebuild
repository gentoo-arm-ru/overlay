# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PV="${PV}-r8"

DESCRIPTION="Binary pre-bootloader for ironhide"
HOMEPAGE=""
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${PN}-${MY_PV}.tbz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install()
{
	insinto "/lib/firmware"
	doins "firmware/E5250.nbl1.bin"
}
