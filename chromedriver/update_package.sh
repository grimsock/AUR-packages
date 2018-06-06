#!/usr/bin/env sh

if [[ $# == 0 ]] || [[ $# > 1 ]]
then
  echo "invalid numer of args, pass just package version" && exit 1
fi

new_version=$1
current_version=`grep 'pkgver=' PKGBUILD | grep -o '[0-9.]\+'`

# replace current version with new one
sed -i -e "/pkgver=/ s/$current_version/$new_version/g" PKGBUILD

# generate md5sums

# use predefined makepkg conf file to generate x86_64 arch package checksum
if ! [[ -f /usr/share/devtools/makepkg-x86_64.conf ]]
then
  echo "no makepkg conf file for x86_64 arch, installing devtools"
  sudo pacman -S devtools --noconfirm
fi

arch64_line=`makepkg -g -c --config /usr/share/devtools/makepkg-x86_64.conf`

# replace old checksums with new ones
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

# commit changes
git add -p
git commit -m "Update to $new_version"

echo "ready to push to AUR"
