# CLWL - Common Lisp Binding for Wayland & wlroots

Here's the Common Lisp binding for Wayland & wlroots created by April & May & June. It includes:

- Full bindings for `libwayland-server.so` and `libwayland-client.so`
- Bindings for wlroots 0.19 (`libwlroots-0.19.so`) (not complete yet)
- Tinywl written in CL

## Systems Provided and Prerequisite

For `CLWL` ASDF system, you need `libwayland-server.so` and `libwayland-client.so` shared library, and `CFFI` system installed;

For `CLWLR` ASDF system, you need `libwlroots-0.19.so` shared library, and `CLWL` system;

For `CLWL-TINYWL` ASDF system, you need `CLWLR` system.

## Usage

> We don't recommend to use the `WL` package directly, as it will cause symbol conflicts with `CL` package. but you can
  use `WLR` package safely.

### Wayland

For bindings of `wayland-util.h`, `wayland-server-core.h`, `wayland-server-protocol.h`, `wayland-client-core.h` and `wayland-client-protocol.h`, evaluate:

``` common-lisp
(ql:quickload :clwl)
```

The naming convention is `wl_<name>` => `wl:<name>`.

> For `wl_list_for_each`, `wl_list_for_each_safe`, `wl_list_for_each_reverse`, `wl_list_for_each_safe` and
  `wl-array-do-each`, the corresponding macros are `wl:dolist`, `wl:dolist-safe`, `wl:dolist-reverse`,
  `wl:dolist-reverse-safe` and `wl:doarray`.

### wlroots

For bindings of `wlroots`, evaluate:

``` common-lisp
(ql:quickload :clwlr)
```

The naming convention is `wlr_<name>` => `wlr:<name>`.

> To access `wl:signal`s inside `events` structure of wlroots quickly, use `wlr:event-signal` macro.

### tinywl

To try out tinywl, evaluate:

``` common-lisp
(ql:quickload :clwl-tinywl)
(tinywl:main)
```

> You have to start REPL with a real display device, either TTY, X11 or Wayland compositor. Not via SSH!

### Development

We provide some helper macro in `wl/package.lisp` and `wlr/package.lisp`. Check them for details.

> Ask AI agents to generate new bindings efficiently.

---

## Acknowledgements

Thanks my sister Simone and my lover Caroline, who help and support me.

Supporting Neurodiversity & Transgender & Plurality!

🏳️‍🌈🏳️‍⚧️