(cl:in-package "WLR")

(defcstruct backend-output-state
  (output :pointer)
  (base (:struct output-state)))

(defcstruct backend-features
  (timeline :bool))

(define-wlr-events-struct backend destroy new-input new-output)

(defcstruct backend
  (impl :pointer)
  (buffer-caps :uint32)
  (features (:struct backend-features))
  (events (:struct backend-events)))

(defcfun ("wlr_backend_autocreate" backend-autocreate) :pointer
  (event-loop :pointer)
  (session-ptr :pointer))
(export 'backend-autocreate)

(define-wlr-func backend start :bool)

(define-wlr-func backend destroy :void)

(define-wlr-func backend get-drm-fd :int)

(define-wlr-func backend test :bool
  (output-states :pointer)
  (states-len :unsigned-long-long))

(define-wlr-func backend commit :bool
  (output-states :pointer)
  (states-len :unsigned-long-long))
