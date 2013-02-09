# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit eutils

OPENGL_DIR="mali"

MY_PV="${PV/0./}"
MY_PV_FULL="${MY_PV}-r96"
MY_PN="${PN}-drivers"
MY_P="${MY_PN}-${MY_PV_FULL}"

DESCRIPTION="OpenGL ES libraries for Mali T604 for Linux"
HOMEPAGE="http://arm.com"
LICENSE="Google-TOS"
#RESTRICT="fetch"

SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${MY_P}.run"
SLOT="0"
KEYWORDS="~arm"

VIDEO_CARDS="maliT604"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS}"

S="${WORKDIR}"

MALI_GLES_LIBS_LINKS=" \
	libEGL.so \
	libEGL.so.1 \
	libEGL.so.1.${MY_PV} \
	libGLESv1_CM.so \
	libGLESv1_CM.so.1 \
	libGLESv1_CM.so.1.${MY_PV} \
	libGLESv2.so \
	libGLESv2.so.2 \
	libGLESv2.so.2.${MY_PV} \
	libmali.so \
	libmali.so.0
"

src_unpack() {
	offset=$(head -n 7 "/usr/portage/distfiles/${A}" | tail -n 1 | cut -d= -f 2)
	tail -n +${offset} "/usr/portage/distfiles/${A}" | tar xjv -C ${WORKDIR} || die "Can't unpack sources"
}

src_install() {
	insinto /usr/$(get_libdir)/opengl/mali/lib
	doins usr/lib/libmali.so.${PV}
	for LIB in $MALI_GLES_LIBS_LINKS; do
		dosym "/usr/$(get_libdir)/opengl/mali/lib/libmali.so.${PV}"	"/usr/$(get_libdir)/opengl/mali/lib/${LIB}"
	done
	dosym "/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.so" "/usr/$(get_libdir)/opengl/mali/lib/libGL.so"
	dosym "/usr/$(get_libdir)/opengl/xorg-x11/extensions" "/usr/$(get_libdir)/opengl/mali/extensions"
	dosym "/usr/$(get_libdir)/opengl/xorg-x11/include" "/usr/$(get_libdir)/opengl/mali/include"
}

pkg_postinst() {
	# Switch to the xorg implementation.
	echo
	eselect opengl set --use-old ${OPENGL_DIR}

	# switch to xorg-x11 and back if necessary, bug #374647 comment 11
	OLD_IMPLEM="$(eselect opengl show)"
	if [[ ${OPENGL_DIR}x != ${OLD_IMPLEM}x ]]; then
		eselect opengl set ${OPENGL_DIR}
		eselect opengl set ${OLD_IMPLEM}
	fi
}
