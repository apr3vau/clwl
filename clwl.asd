(asdf:defsystem clwl
  :depends-on (:alexandria :anaphora :cffi)
  :components ((:file "package")
               (:file "wayland-util")
               (:file "wayland-server")
               (:file "wayland-client")
               (:file "wayland-client-protocol")
               ))
