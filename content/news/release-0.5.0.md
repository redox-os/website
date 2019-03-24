+++
title = "Redox OS 0.5.0"
author = "jackpot51"
date = "2019-03-24"
+++

# We're Back!

It has been one year and four days since the last release of Redox OS! In this
time, we have been hard at work improving the Redox ecosystem. Much of this work
was related to [relibc](https://gitlab.redox-os.org/redox-os/relibc), a new C
library written in Rust and maintained by the Redox OS project, and adding new
packages to the [cookbook](https://gitlab.redox-os.org/redox-os/cookbook). We
are proud to report that we have now far exceeded the capabilities of `newlib`,
which we were using as our system C library before. We have added many important
libraries and programs, which you can see listed below.

## Standard Images

You can download the 0.5.0 images
[here](https://gitlab.redox-os.org/redox-os/redox/-/jobs/10824/artifacts/browse/build/img/).

At first glimpse, the standard ISO does not look much different from 0.3.5, our
last real release. We still have the same login screen, and the same default
background and applications. This, in and of itself, was an accomplishment. Work
on [relibc](https://gitlab.redox-os.org/redox-os/relibc) was intense, and
touched nearly every part of the system.

Once one digs a little deeper, the changes become more obvious. The event system
was redesigned to provide correct support for `select` and `poll`, and complete
memory mapping support was implemented. Pthreads was implemented, and also a
number of signal-related system calls. The whole of these changes provided
better support for LLVM, and from that, `rustc` and `mesa` with `llvmpipe`.

In addition, there are new images based on new bootloaders for both coreboot and
EFI. Significant work has been done to provide libraries for EFI Rust
development, and to develop coreboot payloads in Rust. Either bootloader project
can be forked and repurposed as desired. See the following projects:

- [bootloader-coreboot](https://gitlab.redox-os.org/redox-os/bootloader-coreboot) -
  Coreboot payload that can boot Redox
- [bootloader-efi](https://gitlab.redox-os.org/redox-os/bootloader-efi) - EFI
  bootloader for Redox
- [coreboot-table](https://gitlab.redox-os.org/redox-os/coreboot-table) - A
  parser for the coreboot table.
- [uefi](https://gitlab.redox-os.org/redox-os/uefi) - UEFI protocol definitions
- [uefi_alloc](https://gitlab.redox-os.org/redox-os/uefi_alloc) - UEFI allocator
- [uefi_std](https://gitlab.redox-os.org/redox-os/uefi_std) - UEFI runtime

## New Packages

The result of the [relibc](https://gitlab.redox-os.org/redox-os/relibc) work can
be seen in the massive addition of new packages that can be added to your
`filesystem.toml` when building locally, or installed with `pkg install`. You
can see all available packages and versions
[here](https://static.redox-os.org/pkg/x86_64-unknown-redox/repo.toml).

- [audiod](https://gitlab.redox-os.org/redox-os/audiod) - Daemon for mixing
  audio and delivering it to audio hardware
- [cairo](https://www.cairographics.org) - Vector graphics renderer
- [cairodemo](https://gitlab.redox-os.org/redox-os/cookbook/blob/master/recipes/cairodemo) -
  C example using [cairo](https://www.cairographics.org)
- [cpal](https://github.com/tomaka/cpal) - Rust audio library
- [dosbox](https://www.dosbox.com/) - DOS emulator
- [eduke32](https://www.eduke32.com/) - Duke Nukem 3D Engine
- [ffmpeg](https://ffmpeg.org/) - Multimedia framework
- [freedoom](https://freedoom.github.io/) - Free content Doom-style game
- [gears](https://gitlab.redox-os.org/redox-os/cookbook/blob/master/recipes/gears) -
  Classic OpenGL example
- [gettext](https://www.gnu.org/software/gettext/) - Localization library
- [gigalomania](http://gigalomania.sourceforge.net/) - Real-time strategy game
- [glib](https://gitlab.gnome.org/GNOME/glib) - System libraries for GTK+ and
  GNOME
- [glium](https://github.com/glium/glium) - OpenGL wrapper for Rust
- [glutin](https://github.com/tomaka/glutin) - OpenGL context creation in Rust
- [gstreamer](https://gstreamer.freedesktop.org/) - Multimedia framework
- [harfbuzz](https://www.freedesktop.org/wiki/Software/HarfBuzz/) - Text shaping
  library
- [hematite](http://hematite.piston.rs/) - Minecraft viewer in Rust
- [ipcd](https://gitlab.redox-os.org/redox-os/ipcd) - IPC daemon providing
  shared memory and channels (similar to UNIX sockets)
- [lci](https://github.com/jD91mZM2/rust-lci) - LOLCODE interpreter in Rust
- [libc-bench](https://www.etalabs.net/libc-bench.html) - C library tests
- [libffi](https://sourceware.org/libffi/) - FFI library
- [libiconv](https://www.gnu.org/software/libiconv/) - Implementation of iconv
- [libogg](https://xiph.org/ogg/) - Library for parsing OGG containers
- [liborbital](https://gitlab.redox-os.org/redox-os/liborbital) - C library for
  accessing Orbital window manager
- [libsodium](https://libsodium.gitbook.io/doc/) - Cryptography library
- [libvorbis](https://xiph.org/vorbis/) - Library for decoding and encoding
  Vorbis audio
- [llvm](https://llvm.org/) - Compiler framework
- [mesa](https://www.mesa3d.org/) - 3D graphics library
- [mesa_glu](https://www.mesa3d.org/) - OpenGL utility library
- [mgba](https://mgba.io/) - GBA emulator
- [ncdu](https://dev.yorhel.nl/ncdu) - NCurses disk usage
- [openjazz](http://www.alister.eu/jazz/oj/) - Jazz Jackrabbit engine
- [openttd](https://www.openttd.org/) - Remake of Transport Tycoon Deluxe, a
  business simulation game
- [openttd-opengfx](https://www.openttd.org/) - OpenTTD graphics
- [openttd-openmsx](https://www.openttd.org/) - OpenTTD music
- [openttd-opensfx](https://www.openttd.org/) - OpenTTD sound effects
- [osdemo](https://gitlab.redox-os.org/redox-os/cookbook/tree/master/recipes/osdemo) -
  OSMesa example
- [pcre](https://www.pcre.org/) - Perl compatible regular expressions
- [pixman](http://www.pixman.org/) - Low-level pixel manipulation library
- [powerline](https://github.com/jD91mZM2/powerline-rs) - Rust implementation of
  powerline
- [prboom](http://prboom.sourceforge.net/) - Doom engine
- [relibc](https://gitlab.redox-os.org/redox-os/relibc) - C library in Rust
- [ripgrep](https://github.com/BurntSushi/ripgrep) - extremely fast search tool
- [rodioplay](https://gitlab.redox-os.org/redox-os/rodioplay) - simple sound
  player using [rodio](https://github.com/tomaka/rodio)
- [rust-cairo](https://gitlab.redox-os.org/redox-os/rust-cairo) - Rust library
  for using [cairo](https://www.cairographics.org)
- [rust-cairo-demo](https://gitlab.redox-os.org/redox-os/rust-cairo-demo) -
  Rust example using [rust-cairo](https://gitlab.redox-os.org/redox-os/rust-cairo)
- [schismtracker](http://schismtracker.org/) - Reimplementation of Impulse
  Tracker, a music creation program
- [scummvm](https://www.scummvm.org/) - Interpreter for numerous adventure games
- [sdl2](https://www.libsdl.org/) - Video game abstraction layer
- [sdl2_gears](https://gitlab.redox-os.org/redox-os/cookbook/tree/master/recipes/sdl2_gears) -
  Example of using [SDL2](https://www.libsdl.org/) and associated libraries
- [sdl2_image](https://www.libsdl.org/projects/SDL_image/) - SDL2 image library
- [sdl2_mixer](https://www.libsdl.org/projects/SDL_mixer/) - SDL2 sound mixing
  library
- [sdl2_ttf](https://www.libsdl.org/projects/SDL_ttf/) - SDL2 font library
- [sdl_gfx](https://sourceforge.net/p/sdlgfx/wiki/Home/) - SDL graphics library
- [sdl_image](https://www.libsdl.org/projects/SDL_image/) - SDL image library
- [sdl_mixer](https://www.libsdl.org/projects/SDL_mixer/) - SDL sound mixing
  library
- [sdl_ttf](https://www.libsdl.org/projects/SDL_ttf/) - SDL font library
- [sopwith](http://sdl-sopwith.sourceforge.net/) - Port of Sopwith, a side
  scrolling shooting game, to SDL
- [syobanaction](http://www.gatobros.com/syobon.html) - Cat Mario
- [ttf-hack](https://sourcefoundry.org/hack/) - Hack typeface
- [webrender](https://github.com/servo/webrender) - GPU-based renderer, compiles
  but renders black screens on Redox
- [winit](https://github.com/tomaka/winit) - Window handling library in Rust

## Code Changes

Please use the following links to see all the code changes since 0.3.5:

- [redox](https://gitlab.redox-os.org/redox-os/redox/compare/0.3.5...0.5.0)
- [cookbook](https://gitlab.redox-os.org/redox-os/cookbook/compare/0.3.5...0.5.0)
- [kernel](https://gitlab.redox-os.org/redox-os/cookbook/compare/0.3.5...0.5.0)
- [relibc](https://gitlab.redox-os.org/redox-os/relibc) is completely new
- [orbtk](https://gitlab.redox-os.org/redox-os/orbtk) is going through a
  redesign
- Many other repositories have changed, but are not tracked in the main Redox
  repository. I encourage you to browse through our
  [projects on the Redox OS GitLab](https://gitlab.redox-os.org/redox-os)

## Discussion

Please see the following links for discussion:

- [Discourse](https://discourse.redox-os.org/t/redox-os-0-5-0-is-here/1051)
- [Hacker News](https://news.ycombinator.com/item?id=19478720)
- [Patreon](https://www.patreon.com/posts/25602110)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/b51e40/redox_os_050/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/b51ec3/redox_os_050/)
- [Twitter](https://twitter.com/redox_os/status/1109921288758288384)
