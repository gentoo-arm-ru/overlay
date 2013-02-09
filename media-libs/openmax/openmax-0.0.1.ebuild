# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit eutils

DESCRIPTION="OpenMAX video decoder libraries"
HOMEPAGE="http://arm.com"
LICENSE="eula"
#RESTRICT="fetch"

SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}-r5.tbz2"
SLOT="0"
KEYWORDS="~arm"

VIDEO_CARDS="maliT604"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS}"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /usr/$(get_libdir)/
	doins usr/lib/*
}

