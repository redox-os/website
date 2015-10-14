+++
author = "Redox Developers"
date = "2015-10-14T19:30:51+02:00"
title = "this week in redox 2"

+++

# Whats new in Redox?

# redox-os/redox closed issues

- &str == redox String cleanup
- Add Bresenham's line drawing algorithm
- Add `box_write` command in `filesystem/apps/test/test.rs`
- Add `wget` command
- Add `write` trait
- Add leak test for test.rs
- Add second wallpaper/bootscreen image
- Add temporary rsa implementation
- Add user scheme example
- Added Fedora build instructions.
- Added dnode, object set, and zil header
- Changed Fedora setup instructions to use dnf instead of yum
- Document the rest of `libredox`
- Documentation of the schemes module
- Dup fork clone exec
- Formatize more `&str.to_string` concats
- Got NvPairs XDR decoding working
- Hacky way to read ZFS files
- Indexize Memory and use Memory in uhci and Cleanup
- Initial ion commit
- LZJB compression for ZFS
- Manual `Debug` workaround for `NvList` and `NvValue`
- More `Memory`ifying and import cleanup
- More progress toward reading a file
- Move kvec.rs to vec.rs and use `Memory` where possible
- NvList Serialization
- Opening Programs from the UI Bar Change
- Playing with the test app
- Progress on nvpairs and XDR
- Remove `Option::` namespacing and remove some leftover whitespace
- Removed debug prints in NvPairs decoding in ZFS
- Rename `BMP` to `BMPFile`
- Start Neon, a permission model.
- Starting to read ZAP objects
- Undo `format!`ing and borrow slices instead of Vecs
- Use lzjb compression to read the MOS meta_dnode
- Userspace networking
- ls command for ZFS

# What does it look like?

The desktop.
![Redox](https://raw.githubusercontent.com/redox-os/redox/e3a2abf42dfad8875642156fee476351153e7ce8/img/screenshots/Desktop.png)
Yay! Fancy opacity.
![Redox](https://raw.githubusercontent.com/redox-os/redox/e3a2abf42dfad8875642156fee476351153e7ce8/img/screenshots/Fancy_opacity.png)
We have a file manager!
![Redox](https://raw.githubusercontent.com/redox-os/redox/e3a2abf42dfad8875642156fee476351153e7ce8/img/screenshots/File_manager.png)
The boot screen.
![Redox](https://raw.githubusercontent.com/redox-os/redox/e3a2abf42dfad8875642156fee476351153e7ce8/img/screenshots/Boot.png)

# What next?

- Continue on `x86_64` support
- Create design documents for Ion
- Create design documents for Oxide
- Discuss development infrastructure
- Move things out of the kernel
- Link a userspace allocator to libredox
- Get kernel strings to support UTF-8 with `Vec<u8>` instead of `Vec<char>`

# Contributors

- Abhishek Chanda <abhishek.chanda@emc.com>
- Adam Baxter <ambaxter@users.noreply.github.com>
- Ben Elliott <belliott@schemagames.com>
- Jeremy Soller <jackpot51@gmail.com>
- Liam Wigney <ShadowCreator@users.noreply.github.com>
- Remi Rampin <remirampin@gmail.com>
- stratact <stratact1@gmail.com>
- Theodore DeRego <tderego94@gmail.com>
- Ticki <Ticki@users.noreply.github.com>
- Titouan Vervack <tivervac@gmail.com>
