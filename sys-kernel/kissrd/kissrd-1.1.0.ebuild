# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="A simple initramfs generator"
HOMEPAGE="https://github.com/teqwve/kissrd"
SRC_URI="https://github.com/teqwve/kissrd/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="cryptsetup lvm openrc systemd"
REQUIRED_USE="
	?? ( openrc systemd )
"

RDEPEND="
	app-alternatives/cpio
	app-shells/bash
	sys-apps/busybox
	sys-apps/kmod
	sys-apps/util-linux
	cryptsetup? ( sys-fs/cryptsetup )
	lvm? ( sys-fs/lvm2 )
"

DOCS=( README.md )

src_install() {
	if use openrc; then
		emake DESTDIR="${D}" install-gentoo-openrc
	elif use systemd; then
		emake DESTDIR="${D}" install-gentoo-systemd
	else
		emake DESTDIR="${D}" install
	fi

	einstalldocs
}
