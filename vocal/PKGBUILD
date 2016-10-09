# Contributor: Doug Newgard <scimmia at archlinux dot info>
# Contributor: jfperini <@jfperini>

pkgname=vocal
pkgver=1.0
_revision=r284
pkgrel=1
pkgdesc='Podcast Client for the Modern Desktop'
arch=('i686' 'x86_64')
url='http://www.vocalproject.net'
license=('GPL3')
depends=('libnotify' 'granite' 'gst-plugins-base-libs' 'clutter-gtk')
makedepends=('vala' 'cmake')
source=("https://downloads.sourceforge.net/project/vocalpodcast/vocal_$pkgver.tar.gz")
md5sums=('a1addd97e1f79c5fae4ede3661415be0')

prepare() {
  [[ -d $pkgname-$pkgver+$_revision/build/ ]] || mkdir -p $pkgname-$pkgver+$_revision/build/
}

build() {
  cd $pkgname-$pkgver+$_revision/build/

  cmake .. -DCMAKE_INSTALL_PREFIX=/usr

  make
}

package() {
  cd $pkgname-$pkgver+$_revision/build/

  make DESTDIR="$pkgdir" install
}
