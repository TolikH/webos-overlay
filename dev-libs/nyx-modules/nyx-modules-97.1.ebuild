EAPI="5"
inherit webos-cmake webos-github

DESCRIPTION="Open webOS portability layer - device specific modules"
HOMEPAGE="https://github.com/openwebos/nyx-modules"
SLOT="0"

KEYWORDS="amd64"
LICENSE="LGPL-2.1"
DEPEND="dev-libs/glib
		dev-libs/nyx-lib"

src_install() {
	cmake-utils_src_install

	# dummy path fix
	rm -f "${D}"/etc/udev/rules.d/99-nyx-modules.rules || die "Can't remove udev rule. Check ebuild"
	insinto /lib/udev/rules.d
	newins "${S}/files/conf/99-nyx-modules.rules" 99-nyx-modules.rules

}
