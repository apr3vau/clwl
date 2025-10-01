(in-package "WLR")

(defcstruct allocator-interface
  (:create-buffer :pointer)
  (:destroy :pointer))

(define-wlr-func allocator init :void
  (impl (:pointer (:struct allocator-interface)))
  (buffer-caps :uint32))

(define-wlr-events-struct allocator destroy)

(defcstruct allocator
  (:impl (:pointer (:struct allocator-interface)))
  (:buffer-caps :uint32)
  (:events (:struct allocator-events)))

(defcfun ("wlr_allocator_autocreate" allocator-autocreate) :pointer
  (backend :pointer)
  (renderer :pointer))
(export 'allocator-autocreate)

(define-wlr-func allocator destroy :void)

(define-wlr-func allocator create-buffer :pointer
  (width :int)
  (height :int)
  (format :pointer))
