(cl:in-package "WL")

(cl:defun container-of (ptr type member)
  (make-pointer (cl:- (pointer-address ptr) (foreign-slot-offset type member))))
(cl:export 'container-of)

(defcstruct message
  (:name :string)
  (:signature :string)
  (:types :pointer))

(defcstruct interface
  (:name :string)
  (:version :int)
  (:method-count :int)
  (:methods (:pointer (:struct message)))
  (:event-count :int)
  (:events (:pointer (:struct message))))

(defcstruct list
  (:prev (:pointer (:struct list)))
  (:next (:pointer (:struct list))))

(cl:export '(message interface list))

(define-wl-func list init :void)

(define-wl-func list insert :void
  (elm (:pointer (:struct list))))

(define-wl-func list remove :void)

(define-wl-func list length :int)

(define-wl-func list empty :int)

(define-wl-func list insert-list :void
  (other (:pointer (:struct list))))

(cl:defmacro list-next (head member item-type)
  `(container-of (foreign-slot-pointer ,head '(struct wl-list) :next)
    ,item-type ,member))
(cl:export 'list-next)

(defcstruct array
  (:size :uint32)
  (:alloc :uint32)
  (:data :pointer))
(cl:export 'array)

(define-wl-func array init :void)

(define-wl-func array release :void)

(define-wl-func array add :pointer
  (size :uint32))

(define-wl-func array copy :int
  (source :pointer))

(defcunion argument
  (:i :int32)
  (:u :uint32)
  (:f :int32)
  (:s :string)
  (:o :pointer)
  (:n :uint32)
  (:a :pointer)
  (:h :int32))

(defcenum iterator-result
  :stop
  :continue)

(cl:export '(argument iterator-result))
