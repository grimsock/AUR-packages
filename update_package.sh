#!/usr/bin/env sh

if [[ $# < 2 ]] || [[ $# > 2 ]]
then
  echo "invalid numer of args, pass PKGBUILD dir path first and then package version" && exit 1
fi

cd $1

new_version=$2
current_version=`grep 'pkgver=' PKGBUILD | grep -o '[0-9.]\+'`

# replace current version with new one
sed -i -e "/pkgver=/ s/$current_version/$new_version/g" PKGBUILD

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
makepkg --source --force --clean

# cleanup
rm -rf *.zip

echo "ready to AUR upload"
