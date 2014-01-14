EAPI="5"
inherit cmake-utils

DESCRIPTION="Open webOS Luna System Bus library, daemon, and utilities"
HOMEPAGE="https://github.com/openwebos/luna-service2"
SLOT="0"

KEYWORDS="amd64"
LICENSE="LGPL-2.1"
SRC_URI="https://github.com/openwebos/${PN}/archive/submissions/${PV}.zip -> ${P}.zip"
S="${WORKDIR}/${PN}-submissions-${PV}"

DEPEND="dev-util/cmake-modules-webos
		dev-libs/pmloglib"

src_prepare() {
    cmake-utils_src_prepare
    epatch "${FILESDIR}/add_pmloglib_dependency.patch"
}

src_configure() {
 	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX:PATH=/opt/webos"
		"-DWEBOS_INSTALL_ROOT:PATH=/opt/webos"
	)
	cmake-utils_src_configure 
}

src_install() {
	cmake-utils_src_install

	keepdir /opt/webos/usr/share/dbus-1/{system-,}services
	keepdir /opt/webos/var/palm/ls2/{roles,services}/{prv,pub}

	newinitd "${FILESDIR}/ls-hubd-prv" ls-hubd-prv 
	newinitd "${FILESDIR}/ls-hubd-pub" ls-hubd-pub

}

