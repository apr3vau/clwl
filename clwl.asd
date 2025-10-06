(asdf:defsystem clwl
  :author "April & May & June"
  :description "Common Lisp bindings for libwayland-server and libwayland-client"
  :license "0BSD"
  :depends-on (:cffi)
  :components ((:file "wl/package")
               (:file "wl/wayland-util")
               (:file "wl/wayland-server-core")
               (:file "wl/wayland-client-core")
               (:file "wl/wayland-egl-core")
               (:file "wl/wayland-server-protocol")
               (:file "wl/wayland-client-protocol")))