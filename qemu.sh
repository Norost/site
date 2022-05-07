#!/usr/bin/env bash

exec qemu-system-x86_64 \
	--enable-kvm \
	-m 64M \
    -cpu host \
	-machine q35 \
	-drive format=raw,media=cdrom,file=site.iso \
	-serial mon:stdio \
	-netdev user,id=net0,hostfwd=tcp::8000-:80 \
	-device virtio-net-pci,netdev=net0 \
	-nographic \
	"$@"