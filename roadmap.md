# Roadmap

## v0.2

*This list is incomplete*

- Finalize OO interface, i.e. add missing methods
- Improve virtio-net
  - Avoid busy-polling, this will require a way to get the kernel's monotonic time
  - Queue multiple packets at once
  - Add a crate that provides a easier & safe wrapper around the raw queue structure
- Implement SSH or similar
- Enable pre-emption
- Port a proper HTTP server, i.e. one that is asynchronous
- Secure kernel against malicious userspace programs
- Move PS/2 keyboard driver and VGA text driver out of the kernel.
  - The PS/2 8042 driver itself will still remain in the kernel as the alternative requires
    exporting the entire I/O space, which gives way too much power to userland.
  - Similarly, a few parts of the VGA text driver will remain in the kernel. A userland driver
    will mainly deal with figuring out where characters should go, scroll etc.

## v0.1

- Make the OS useable for hosting this website :)
