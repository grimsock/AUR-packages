#!/usr/bin/env sh

if [[ $# == 0 ]] || [[ $# > 1 ]]
then
  echo "invalid numer of args, pass just package version" && exit 1
fi

new_version=$1
current_version=`grep 'pkgver=' PKGBUILD | grep -o '[0-9.]\+'`

# replace current version with new one
sed -i -e "/pkgver=/ s/$current_version/$new_version/g" PKGBUILD

# update checksums
updpkgsums PKGBUILD

# sed & updpkgsums changes permissions, aur accepts only files with 644 or 755
chmod 644 PKGBUILD

# if namcap installed perform chceck
if (pacman -Q namcap &>/dev/null); then
  echo "==============================="
  echo "performing namcap check"
  namcap -i PKGBUILD
  echo "==============================="
fi

# generate .SRCINFO
mksrcinfo

# cleanup
rm -rf *.zip
rm -rf *.tar.bz2

# commit changes
git add -p
git commit -m "Update to $new_version"

echo "ready to push to AUR"
