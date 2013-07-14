# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Daisy public bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm"
IUSE="-snow"

DEPEND=""
RDEPEND="
	sys-kernel/mfc-fw
	media-libs/openmax-daisy
	sys-kernel/exynos-pre-boot
	x11-drivers/xf86-video-armsoc
"

S="${WORKDIR}"

src_install() {
	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/battery_poll_short_interval_ms" || die
	doins "${FILESDIR}/low_battery_shutdown_percent" || die
	doins "${FILESDIR}/low_battery_shutdown_time_s" || die
	doins "${FILESDIR}/wakeup_input_device_names" || die

	# Install platform specific usb device list for laptop mode tools
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/usb-autosuspend.conf" || die "installation failed ($?)"
	doins "${FILESDIR}/cpufreq.conf" || die "installation failed ($?)"

	insinto "/lib/udev/rules.d"
	doins "${FILESDIR}"/50-media.rules

	if use snow; then
		# Install platform specific config file for thermal monitoring
		dosbin "${FILESDIR}/thermal.sh" || die "installation failed ($?)"
		insinto "/etc/init/"
		doins "${FILESDIR}/thermal.conf" || die "installation failed ($?)"
		insinto "/lib/udev/rules.d"
		doins "${FILESDIR}/50-rtc-max77686.rules" || die "installation failed ($?)"
	fi
}
