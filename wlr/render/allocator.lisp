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

(export '(allocator-interface allocator))

(defcfun ("wlr_allocator_autocreate" allocator-autocreate) (:pointer (:struct allocator))
  (backend (:pointer (:struct backend)))
  (renderer (:pointer (:struct renderer))))
(export 'allocator-autocreate)

(define-wlr-func allocator destroy :void)

(define-wlr-func allocator create-buffer (:pointer (:struct buffer))
  (width :int)
  (height :int)
  (format :pointer))
