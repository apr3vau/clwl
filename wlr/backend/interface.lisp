(in-package "WLR")

(defcstruct backend-impl
  (:start :pointer)
  (:destroy :pointer)
  (:get-drm-fd :pointer)
  (:test :pointer)
  (:commit :pointer))
(export 'backend-impl)

(define-wlr-func backend init :void
  (impl :pointer))

(define-wlr-func backend finish :void)
