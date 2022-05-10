# Norost B Operating System

Norost B is an object-oriented OS built around a microkernel. It is mainly
focused on isolating processes from the rest of the system to improve security,
portability & scaling.


## Features

- Supports x86-64
- Object-oriented interface
  - Files, network sockets ... are all objects.
  - Any process can create new objects.
  - IPC is performed via tables, which are also objects.
  - Processes can only perform operations on objects they have a handle to.
- Preemtable kernel & userland
- Supported devices:
  - virtio-net
  - virtio-blk
- Supported filesystems:
  - FAT
- Networking (IP, TCP, UDP, DHCP, ICMP)
- Asynchronous I/O
- Rust standard library


## [Design](design)


## [Roadmap](roadmap)


## Source code repositories

- [Source Hut](https://git.sr.ht/~demindiro/norost-b)
- [Github](https://github.com/Demindiro/norost-b)


_This site is proudly hosted on a Norost B instance :)_
