# Copyright 2004-2007 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2

EAPI=2
EGIT_TREE="${PV}"
EGIT_REPO_URI="git://sabayon.org/projects/entropy.git"

inherit eutils multilib python git

DESCRIPTION="Official Sabayon Linux Package Manager library"
HOMEPAGE="http://www.sabayonlinux.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/dbus-python
	dev-python/pygobject
	=sys-apps/entropy-${PV}
"
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR=usr/$(get_libdir) updates-daemon-install || die "make install failed"
}

pkg_postrm() {
        python_mod_cleanup ${ROOT}/usr/$(get_libdir)/entropy/services
}

