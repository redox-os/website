+++
title = "RSoC: virtio drivers - 2"
author = "Andy-Python-Programmer"
date = "2023-09-04"
+++

*This is a continuation of https://redox-os.org/news/rsoc-virtio-1/*

Over the past few weeks, there has been significant progress with the `virtio-gpu` drivers, resulting in working 2D acceleration! 🎉

In addition to writing the driver itself, changes were required on how applications interact with the display device.

## The `inputd` driver. 
This driver is responsible for multiplexing the input from multiple input devices ("producer channel") and provide it to Orbital 
("consumer channel"). This before was done inside of the VESA driver, however with the introduction of other display
drivers, isolating the input handling into a separate driver made the interface much cleaner.

In addition, every display device now opens an "inputd handle" to register the device and a VT# is assigned to each display. When a user 
switches to a different VT, the inputd driver sends an event to the respective device, disabling the current one and enabling the newly 
selected device. Additionally, the inputd driver offers functionality to set the VT mode (text or graphics) using `inputd -G VT#` and 
to switch between VTs using `inputd -A VT#`.

## Asynchronous Virtio Drivers - Experimentation
The virtio drivers are now asynchronous. I've been experimenting with different ways to implement asynchronous schemes. 
However, due to the blocking nature of POSIX syscalls, asynchronous calls are currently converted into synchronous calls. 
Despite this, I believe that having an async driver codebase is better because it enhances code readability.

### Example

```rust
// Synchronous Approach
fn read_at(&self, _: usize, buffer: &mut [u8] -> usize {
    if self.buffer.is_empty() && self.flags & O_NONBLOCK == O_NONBLOCK {
	    return Err(WOULDBLOCK);
    }

    // Wait until there is an item in the buffer. 
    while self.buffer.is_empty() { yield(); }
    buffer[0] = self.buffer.pop();
    return 1;
} 
```

```rust
// Aynchronous Approach
async fn read_at(&self, _: usize, buffer: &mut [u8]) -> usize {
	buffer[0] = self.buffer.pop().await; // Talking advantage of asynchronous rust syntax.
	return 1;
} 
```

## Other changes
* Implementation of a mechanism to reinitialize the queues following a device reset.
* Added support for legacy transport. Wanna try it out, append "disable-modern=on" to the device arguments when running Qemu!

Stay tuned for more exciting updates! 🚀
