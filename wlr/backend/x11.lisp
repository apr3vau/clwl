(in-package "WLR")

(defcfun ("wlr_x11_backend_create" x11-backend-create) (:pointer (:struct backend))
  (event-loop (:pointer (:struct wl:event-loop)))
  (x11-display :string))

(defcfun ("wlr_x11_output_create" x11-output-create) (:pointer (:struct output))
  (backend (:pointer (:struct backend))))

(define-wlr-func backend is-x11 :bool)

(define-wlr-func input-device is-x11 :bool)

(define-wlr-func output is-x11 :bool)

(defcfun ("wlr_x11_output_set_title" x11-output-set-title) :void
  (output (:pointer (:struct output)))
  (title :string))

(export '(x11-backend-create x11-output-create x11-output-set-title))
