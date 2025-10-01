(in-package "WLR")

(define-wlr-events-struct renderer destroy lost)

(defcstruct renderer-features
  (:output-color-transform :bool)
  (:timeline :bool))

(defcstruct renderer-private
  (:impl :pointer))

(defcstruct renderer
  (:render-buffer-caps :uint32)
  (:events (:struct renderer-events))
  (:features (:struct renderer-features))
  (:private (:struct renderer-private)))

(defcfun ("wlr_renderer_autocreate" renderer-autocreate) :pointer
  (backend :pointer))
(export 'renderer-autocreate)

(define-wlr-func renderer get-texture-formats :pointer
  (buffer-caps :uint32))

(define-wlr-func renderer init-wl-display :bool
  (wl-display :pointer))

(define-wlr-func renderer init-wl-shm :bool
  (wl-display :pointer))

(define-wlr-func renderer get-drm-fd :int)

(define-wlr-func renderer destroy :void)

(defcfun ("wlr_render_timer_create" render-timer-create) :pointer
  (renderer :pointer))
(export 'render-timer-create)

(define-wlr-func render-timer get-duration-ns :int)

(define-wlr-func render-timer destroy :void)
