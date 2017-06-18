# Maintainer: grimsock <lord.grimsock at gmail dot com>
# Contributor: Doug Newgard <scimmia at archlinux dot info>
# Contributor: jfperini <@jfperini>

pkgname=vocal
pkgver=2.0.20
pkgrel=1
pkgdesc='Podcast Client for the Modern Desktop'
arch=('i686' 'x86_64')
url='http://www.vocalproject.net'
license=('GPL3')
depends=('libnotify' 'granite' 'gst-plugins-base-libs' 'clutter-gtk')
makedepends=('vala' 'cmake')
source=("https://github.com/needle-and-thread/vocal/archive/$pkgver.tar.gz")
md5sums=('e831a73435b1c08026ac8063e528b25d')

prepare() {
  [[ -d $pkgname-$pkgver/build/ ]] || mkdir -p $pkgname-$pkgver/build/
}

build() {
  cd $pkgname-$pkgver/build/

  cmake .. -DCMAKE_INSTALL_PREFIX=/usr

  make
}

package() {
  cd $pkgname-$pkgver/build/

  make DESTDIR="$pkgdir" install
}
