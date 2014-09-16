#!/usr/bin/env sh

if [[ $# == 0 ]] || [[ $# > 1 ]]
then
  echo "invalid numer of args, pass just package version" && exit 1
fi

new_version=$1
current_version=`grep 'pkgver=' PKGBUILD | grep -o '[0-9.]\+'`

# replace current version with new one
sed -i -e "/pkgver=/ s/$current_version/$new_version/g" PKGBUILD

# update crawljax bin
sed -i -e "s/$current_version/$new_version/g" crawljax

# update checksums
updpkgsums PKGBUILD

# if namcap installed perform chceck
if (pacman -Q namcap &>/dev/null); then
  echo "==============================="
  echo "performing namcap check"
  namcap -i PKGBUILD
  echo "==============================="
fi

# generate package
#makepkg --source --force --clean
mkaurball -f

# cleanup
rm -rf *.zip

echo "ready to AUR upload"
