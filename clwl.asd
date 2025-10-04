(asdf:defsystem clwl
  :author "April & May & June"
  :description "Common Lisp bindings for libwayland-server and libwayland-client"
  :license "0BSD"
  :depends-on (:alexandria :cffi)
  :components ((:file "wl/package")
               (:file "wl/wayland-util")
               (:file "wl/wayland-server")
               (:file "wl/wayland-client")
               (:file "wl/wayland-server-protocol")
               (:file "wl/wayland-client-protocol")))