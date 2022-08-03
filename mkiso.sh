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

install () {
	(cd $1/$2 && cargo build $args --target $TARGET_USER)
	cp target/$TARGET_USER/release/$3 $A/$2
}

install drivers virtio_net         driver_virtio_net
install base    init               init
install base    minish             minish
install base    static_http_server static_http_server

popd

./generate.sh
for f in index gallery design roadmap
do
	cp $f.html $A/$f
done
cp init.toml $A/init.toml
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
