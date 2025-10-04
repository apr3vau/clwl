(asdf:defsystem clwl
  :depends-on (:alexandria :cffi)
  :components ((:file "wl/package")

               (:file "wl/wayland-util")
               (:file "wl/wayland-server")
               (:file "wl/wayland-client")
               (:file "wl/wayland-server-protocol")
               (:file "wl/wayland-client-protocol")))

(asdf:defsystem clwlr
  :depends-on (:clwl)
  :components ((:file "wlr/package")
               ;; Dependencies
               (:file "wlr/pixman")
               ;; Util
               (:file "wlr/util/box")
               (:file "wlr/util/log")
               (:file "wlr/util/addon")
               ;; Render
               (:file "wlr/render/pass")
               (:file "wlr/render/dmabuf")
               (:file "wlr/render/allocator")
               (:file "wlr/render/wlr-texture")
               (:file "wlr/render/wlr-renderer")
               ;; Types
               (:file "wlr/types/wlr-output")
               (:file "wlr/types/wlr-input-device")
               (:file "wlr/types/wlr-cursor")
               (:file "wlr/types/wlr-keyboard")
               (:file "wlr/types/wlr-pointer")
               (:file "wlr/types/wlr-seat")
               (:file "wlr/types/wlr-data-device")
               (:file "wlr/types/wlr-output-layout")
               (:file "wlr/types/wlr-scene")
               (:file "wlr/types/wlr-compositor")
               (:file "wlr/types/wlr-subcompositor")
               (:file "wlr/types/wlr-xcursor-manager")
               (:file "wlr/types/wlr-xdg-shell")
               ;; Config
               (:file "wlr/config")
               ;; Backend
               (:file "wlr/backend")
               (:file "wlr/backend/drm")
               (:file "wlr/backend/session")
               (:file "wlr/backend/x11")
               (:file "wlr/backend/wayland")
               (:file "wlr/backend/interface")))

(asdf:defsystem clwl-tinywl
  :depends-on (:clwlr)
  :components ((:file "tinywl/tinywl")))