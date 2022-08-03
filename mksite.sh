#!/usr/bin/sh

./generate.sh

rm -f site.bin

dd if=/dev/zero of=site.bin bs=256k count=1

/sbin/mkfs.vfat site.bin

mcopy -i site.bin index.html ::index
mcopy -i site.bin design.html ::design
mcopy -i site.bin roadmap.html ::roadmap
mcopy -i site.bin gallery.html ::gallery
