(asdf:defsystem clwl
  :depends-on (:alexandria :anaphora :cffi)
  :components ((:file "package")

               (:file "wayland-util")
               (:file "wayland-server")
               (:file "wayland-client")
               (:file "wayland-client-protocol")

               (:file "pixman")

               (:file "wlr/util/box")
               (:file "wlr/util/log")
               (:file "wlr/util/addon")

               (:file "wlr/render/pass")
               (:file "wlr/render/dmabuf")
               (:file "wlr/render/allocator")
               (:file "wlr/render/wlr-texture")
               (:file "wlr/render/wlr-renderer")

               (:file "wlr/types/wlr-output")
               (:file "wlr/types/wlr-input-device")
               (:file "wlr/types/wlr-cursor")
               (:file "wlr/types/wlr-keyboard")
               (:file "wlr/types/wlr-pointer")
               (:file "wlr/types/wlr-seat")
               (:file "wlr/types/wlr-data-device")
               (:file "wlr/types/wlr-output-layout")
               (:file "wlr/types/wlr-scene")
               (:file "wlr/types/wlr-subcompositor")
               (:file "wlr/types/wlr-xcursor-manager")
               (:file "wlr/types/wlr-xdg-shell")

               (:file "wlr/config")

               (:file "wlr/backend")
               (:file "wlr/backend/drm")
               (:file "wlr/backend/session")
               (:file "wlr/backend/x11")
               (:file "wlr/backend/wayland")
               (:file "wlr/backend/interface")))
