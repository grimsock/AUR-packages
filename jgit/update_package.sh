#!/usr/bin/env sh

if [[ $# == 0 ]] || [[ $# > 1 ]]
then
  echo "invalid numer of args, pass just package version" && exit 1
fi

# pkgver can't have whitespaces, colons, dashes
new_version=${1//-/_}

current_version=`grep 'pkgver=' PKGBUILD | grep -o '[0-9._]\+r'`

# replace current version with new one
sed -i -e "/pkgver=/ s/$current_version/$new_version/g" PKGBUILD

# update jgit bin
sed -i -e "s/${current_version//_/-}/$1/g" jgit

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
rm -rf *"$1".sh

echo "ready to AUR upload"
