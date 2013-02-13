# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Multi-Format Codec Firmware Binary for Exynos5"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${PF}.tbz2"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /lib/firmware
	doins lib/firmware/mfc_fw.bin
	fperms 0755 /lib/firmware
}

# Hack to fix broken chroots
pkg_postinst() {
	chmod 0755 "${ROOT}/lib/firmware"
}
