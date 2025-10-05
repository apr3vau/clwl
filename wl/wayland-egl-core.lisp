(in-package "WL")

(cl:defvar *egl-platform* 1)

(defcfun ("wl_egl_window_create" egl-window-create) (:pointer (:struct egl-window))
  (surface (:pointer (:struct surface)))
  (width :int)
  (height :int))

(define-wl-func egl-window destroy :void)

(define-wl-func egl-window resize :void
  (width :int)
  (height :int)
  (dx :int)
  (dy :int))

(define-wl-func egl-window get-attached-size :void
  (width (:pointer :int))
  (height (:pointer :int)))
