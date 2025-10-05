(in-package "WLR")

(defcfun ("wlr_wl_backend_create" wl-backend-create) (:pointer (:struct backend))
  (event-loop (:pointer (:struct wl:event-loop)))
  (remote-display (:pointer (:struct wl:display))))

(defcfun ("wlr_wl_backend_get_remote_display" wl-backend-get-remote-display) (:pointer (:struct wl:display))
  (backend (:pointer (:struct backend))))

(defcfun ("wlr_wl_output_create" wl-output-create) (:pointer (:struct output))
  (backend (:pointer (:struct backend))))

(defcfun ("wlr_wl_output_create_from_surface" wl-output-create-from-surface) (:pointer (:struct output))
  (backend (:pointer (:struct backend)))
  (surface (:pointer (:struct wl:surface))))

(export '(wl-backend-create wl-backend-get-remote-display wl-output-create wl-output-create-from-surface))

(define-wlr-func backend is-wl :bool)

(define-wlr-func input-device is-wl :bool)

(define-wlr-func output is-wl :bool)

(define-wlr-func output set-title :void
  (title :string))

(define-wlr-func output set-app-id :void
  (app-id :string))

(define-wlr-func output get-surface (:pointer (:struct wl:surface)))
