# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

DESCRIPTION="Multi-Format Codec Firmware Binary for Exynos5"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
MY_PV="v$(get_version_component_range 1)-$(get_version_component_range 2-4)-r$(get_version_component_range 5)"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${PN}-${MY_PV}.tbz2"

S="${WORKDIR}/${PN}-v$(get_version_component_range 1)"

src_unpack() {
	mv ../distdir/"${A}" ../distdir/"${A/bz2/gz}"
	A="${A/bz2/gz}"
	ls
	pwd
	unpack ${A}
}

src_install() {
	insinto /lib/firmware
	doins lib/firmware/s5p-mfc-v$(get_version_component_range 1).fw
	fperms 0755 /lib/firmware
}

# Hack to fix broken chroots
pkg_postinst() {
	chmod 0755 "${ROOT}/lib/firmware"
}
