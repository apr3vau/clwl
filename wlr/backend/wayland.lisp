(in-package "WLR")

(defcfun ("wlr_wl_backend_create" wl-backend-create) :pointer
  (event-loop :pointer)
  (remote-display :pointer))

(defcfun ("wlr_wl_backend_get_remote_display" wl-backend-get-remote-display) :pointer
  (backend :pointer))

(defcfun ("wlr_wl_output_create" wl-output-create) :pointer
  (backend :pointer))

(defcfun ("wlr_wl_output_create_from_surface" wl-output-create-from-surface) :pointer
  (backend :pointer)
  (surface :pointer))

(export '(wl-backend-create wl-backend-get-remote-display wl-output-create wl-output-create-from-surface))

(define-wlr-func backend is-wl :bool)

(define-wlr-func input-device is-wl :bool)

(define-wlr-func output is-wl :bool)

(define-wlr-func wl-output set-title :void
  (title :string))

(define-wlr-func wl-output set-app-id :void
  (app-id :string))

(define-wlr-func wl-output get-surface :pointer)
