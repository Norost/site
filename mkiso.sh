#!/usr/bin/env bash

TARGET_BOOT=i686-unknown-none-norostbkernel
TARGET_KERNEL=x86_64-unknown-none-norostbkernel
TARGET_USER=x86_64-unknown-norostb

set -e
set -x

pushd ../b

. ./env.sh

./mkkernel.sh --release || exit $?
./mkboot.sh --release || exit $?

O=$(mktemp -d)
A=$(mktemp -d)
trap 'rm -rf "$O" "$A"' EXIT

mkdir -p $O/boot/grub
cp target/$TARGET_KERNEL/release/nora $O/boot/nora
cp target/$TARGET_BOOT/release/noraboot $O/boot/noraboot
cp boot/$ARCH/grub/grub.cfg $O/boot/grub/grub.cfg

./mkiso.sh --release

install () {
	cp target/$TARGET_USER/release/$2 $A/$1
}

install pci                driver_pci
install virtio_net         driver_virtio_net
install init               init
install minish             minish
install static_http_server static_http_server

cp pci.scf $A/pci.scf

popd

cp init.scf $A/init.scf

./generate.sh
for f in index gallery design roadmap
do
	cp $f.html $A/$f
done
mkdir $A/img
cp img/* $A/img/

../b/tools/nrofs.py -rv -C $A $O/boot/norost.nrofs .

# Note: make sure grub-pc-bin is installed! Otherwise QEMU may hang on
# "Booting from disk" or return error code 0009
grub-mkrescue -o site.iso $O \
	--locales= \
	--fonts= \
	--install-modules="multiboot2 normal" \
	--modules= \
	--compress=xz

../b/tools/nrofs.py -lv $O/boot/norost.nrofs
