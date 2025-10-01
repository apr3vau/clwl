(in-package "WLR")

(defcstruct subsurface-parent-state
  (:x :int32)
  (:y :int32)
  (:link (:struct wl:list))
  (:synced :pointer))

(define-wlr-events-struct subsurface destroy)

(define-wlr-private-listener subsurface surface-client-commit parent-destroy)

(defcstruct subsurface
  (:resource :pointer)
  (:surface :pointer)
  (:parent :pointer)
  (:current (:struct subsurface-parent-state))
  (:pending (:struct subsurface-parent-state))
  (:cached-seq :uint32)
  (:has-cache :bool)
  (:synchronized :bool)
  (:added :bool)
  (:events (:struct subsurface-events))
  (:data :pointer)
  (:private (:struct subsurface-private)))

(define-wlr-events-struct subcompositor destroy)

(define-wlr-private-listener subcompositor display-destroy)

(defcstruct subcompositor
  (:global :pointer)
  (:events (:struct subcompositor-events))
  (:private (:struct subcompositor-private)))

(defcfun ("wlr_subsurface_try_from_wlr_surface" subsurface-try-from-wlr-surface) :pointer
  (surface :pointer))
(export 'subsurface-try-from-wlr-surface)

(defcfun ("wlr_subcompositor_create" subcompositor-create) :pointer
  (display :pointer))
(export 'subcompositor-create)

(export '(subsurface subsurface-parent-state subcompositor))
