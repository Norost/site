NOROST_DIR := ../b

DRIVERS = isodir/init isodir/static_http_server isodir/driver_fs_fat isodir/driver_virtio_net

site.iso: $(DRIVERS) isodir/noraboot isodir/nora isodir/boot/grub/grub.cfg isodir/site.bin isodir/init.toml
	# Note: make sure grub-pc-bin is installed! Otherwise QEMU may hang on
	# "Booting from disk" or return error code 0009
	grub-mkrescue -o $@ isodir \
		--locales= \
		--fonts= \
		--install-modules="multiboot2 normal" \
		--modules= \
		--compress=xz

site.bin: index.md design.md roadmap.md
	./generate.sh
	rm -f $@
	dd if=/dev/zero of=$@ bs=128k count=1
	/sbin/mkfs.vfat $@
	mcopy -i $@ index.html ::index
	mcopy -i $@ design.html ::design
	mcopy -i $@ roadmap.html ::roadmap

isodir/noraboot: | isodir
	cd $(NOROST_DIR) && ./mkboot.sh
	cp $(NOROST_DIR)/target/i686-unknown-none-norostbkernel/release/$(patsubst isodir/%,%,$@) $@

isodir/nora: | isodir
	cd $(NOROST_DIR) && ./mkkernel.sh
	cp $(NOROST_DIR)/target/x86_64-unknown-none-norostbkernel/release/$(patsubst isodir/%,%,$@) $@

isodir/site.bin isodir/init.toml: isodir/%: %
	cp $< $@

isodir/boot/grub/grub.cfg: grub.cfg
	mkdir -p isodir/boot/grub
	cp $< $@

$(DRIVERS): | isodir
	cd $(NOROST_DIR) && ./mkiso.sh
	cp $(NOROST_DIR)/target/x86_64-unknown-norostb/release/$(patsubst isodir/%,%,$@) $@

isodir:
	mkdir -p $@

clean:
	rm -rf site.bin *.html isodir
