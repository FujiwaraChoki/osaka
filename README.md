# OsakaOS

This is an Operating System which is currently in development.

Writing in ASM and C.

# Run

Make sure you have the following things already installed:

- qemu (or any other virtualization software, e.g. vbox)
- make
- gcc

Next, run the following commands:

```bash
mkdir build
make
qemu-system-x86_64 build/main_floppy.img
```

If you aren't on Windows, just change the qemu command, as it's name is different on different operating systems.
