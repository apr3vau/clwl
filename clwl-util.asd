(asdf:defsystem clwl-util
  :author "April & May & June"
  :description "Common Lisp bindings for utilities that may used by wayland, wlroots and their applications"
  :license "0BSD"
  :depends-on (:cffi)
  :components ((:file "util/package")
               (:file "util/pixman")
               (:file "util/xkbcommon")))