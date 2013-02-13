# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Binary OpenMax libraries for ironhide (Chromebook Daisy)"
SLOT="0"
KEYWORDS="~arm"
IUSE=""
LICENSE="eula"
RESTRICT="fetch"
DEPEND=""
RDEPEND="${DEPEND}"

SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${PF/-daisy/}.tbz2"

S="${WORKDIR}/${PN/-daisy/}"

LIBS="usr/lib/libOMX.SEC.M4V.Encoder.so
usr/lib/libOMX.SEC.M4V.Decoder.so
usr/lib/libOMX.SEC.AVC.Decoder.so
usr/lib/libOMX.SEC.VP8.Decoder.so
usr/lib/libOMX.SEC.AVC.Encoder.so
usr/lib/libOMX.SEC.WMV.Decoder.so
usr/lib/secomx/secomxregistry
usr/lib/libSEC_OMX_Core.so
usr/lib/libSEC_OMX_Venc.so
usr/lib/libsecmfcapi.so
usr/lib/libSEC_OMX_Vdec.so
usr/lib/libSEC_Resourcemanager.so
"
src_install()
{
	dobin "usr/bin/utc_secomx"
	for lib in ${LIBS}; do
		dolib "${lib}"
	done
}