# Roadmap

## v0.2

- Finalize OO interface, i.e. add missing methods
- Improve virtio-net
  - Avoid busy-polling, this will require a way to get the kernel's monotonic time
  - Queue multiple packets at once
  - Add a crate that provides a easier & safe wrapper around the raw queue structure
- Implement SSH or similar
- Enable pre-emption
- Port a proper HTTP server, i.e. one that is asynchronous

## v0.1

- Make the OS useable for hosting this website :)
