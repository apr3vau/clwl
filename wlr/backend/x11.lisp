(in-package "WLR")

(defcfun ("wlr_x11_backend_create" x11-backend-create) :pointer
  (event-loop :pointer)
  (x11-display :string))

(defcfun ("wlr_x11_output_create" x11-output-create) :pointer
  (backend :pointer))

(define-wlr-func backend is-x11 :bool)

(define-wlr-func input-device is-x11 :bool)

(define-wlr-func output is-x11 :bool)

(defcfun ("wlr_x11_output_set_title" x11-output-set-title) :void
  (output :pointer)
  (title :string))

(export '(x11-backend-create x11-output-create x11-output-set-title))
