(cl:in-package "WL")

(cl:defvar *marshal-flag-destroy* 1)

(define-wl-func event-queue destroy :void)

(define-wl-func proxy marshal-flags (:pointer (:struct proxy))
  (opcode :uint32)
  (interface (:pointer (:struct interface)))
  (version :uint32)
  (flags :uint32)
  cl:&rest)

(define-wl-func proxy marshal-array-flags (:pointer (:struct proxy))
  (opcode :uint32)
  (interface (:pointer (:struct interface)))
  (version :uint32)
  (flags :uint32)
  (args (:pointer (:union argument))))

(define-wl-func proxy marshal :void
  (opcode :uint32)
  cl:&rest)

(define-wl-func proxy create (:pointer (:struct proxy))
  (interface (:pointer (:struct interface))))

(define-wl-func proxy create-wrapper :pointer)

(defcfun ("wl_proxy_wrapper_destroy" proxy-wrapper-destroy) :void
  (proxy-wrapper :pointer))

(define-wl-func proxy marshal-constructor (:pointer (:struct proxy))
  (opcode :uint32)
  (interface (:pointer (:struct interface)))
  cl:&rest)

(define-wl-func proxy marshal-constructor-versioned (:pointer (:struct proxy))
  (opcode :uint32)
  (interface (:pointer (:struct interface)))
  (version :uint32)
  cl:&rest)

(define-wl-func proxy marshal-array-constructor (:pointer (:struct proxy))
  (opcode :uint32)
  (args (:pointer (:union argument)))
  (interface (:pointer (:struct interface))))

(define-wl-func proxy marshal-array-constructor-versioned (:pointer (:struct proxy))
  (opcode :uint32)
  (args (:pointer (:union argument)))
  (interface (:pointer (:struct interface)))
  (version :uint32))

(define-wl-func proxy destroy :void)

(define-wl-func proxy add-listener :int
  (implementation :pointer)
  (data :pointer))

(define-wl-func proxy get-listener :pointer)

(define-wl-func proxy add-dispatcher :int
  (dispatcher-func :pointer)
  (dispatcher-data :pointer)
  (data :pointer))

(define-wl-func proxy set-user-data :void
  (user-data :pointer))

(define-wl-func proxy get-user-data :pointer)

(define-wl-func proxy get-version :uint32)

(define-wl-func proxy get-id :uint32)

(define-wl-func proxy set-tag :void
  (tag :string))

(define-wl-func proxy get-tag :string)

(define-wl-func proxy get-class :string)

(define-wl-func proxy set-queue :void
  (queue :pointer))

(define-wl-func proxy get-queue :pointer)

(define-wl-func event-queue get-name :string)

(defcfun ("wl_display_connect" display-connect) :pointer
  (name :string))

(defcfun ("wl_display_connect_to_fd" display-connect-to-fd) :pointer
  (fd :int))

(cl:export '(display-connect display-connect-to-fd))

(define-wl-func display disconnect :void)

(define-wl-func display get-fd :int)

(define-wl-func display dispatch :int)

(define-wl-func display dispatch-queue :int
  (queue :pointer))

(define-wl-func display dispatch-queue-pending :int
  (queue :pointer))

(define-wl-func display dispatch-pending :int)

(define-wl-func display get-error :int)

(define-wl-func display get-protocol-error :uint32
  (interface :pointer)
  (id (:pointer :uint32)))

(define-wl-func display flush :int)

(define-wl-func display roundtrip-queue :int
  (queue :pointer))

(define-wl-func display roundtrip :int)

(define-wl-func display create-queue :pointer)

(define-wl-func display create-queue-with-name :pointer
  (name :string))

(define-wl-func display prepare-read-queue :int
  (queue :pointer))

(define-wl-func display prepare-read :int)

(define-wl-func display cancel-read :void)

(define-wl-func display read-events :int)

(define-wl-func display set-max-buffer-size :void
  (max-buffer-size :unsigned-long-long))
