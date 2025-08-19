(cl:in-package "WL")

(defcenum event
  (:readable 1)
  (:writable 2)
  (:hangup 4)
  (:error 8))
(cl:export 'event)

(defcfun ("wl_event_loop_create" event-loop-create) :pointer)
(cl:export 'event-loop-create)

(define-wl-func event-loop destroy :void)

(define-wl-func event-loop add-fd :pointer
  (fd :int)
  (mask :uint32)
  (func :pointer)
  (data :pointer))

(define-wl-func event-source fd-update :int
  (mask :uint32))

(define-wl-func event-loop add-timer :pointer
  (func :pointer)
  (data :pointer))

(define-wl-func event-loop add-signal :pointer
  (signal-number :int)
  (func :pointer)
  (data :pointer))

(define-wl-func event-source timer-update :int
  (ms-delay :int))

(define-wl-func event-source remove :int)

(define-wl-func event-source check :void)

(define-wl-func event-loop dispatch :int
  (timeout :int))

(define-wl-func event-loop dispatch-idle :void)

(define-wl-func event-loop add-idle :pointer
  (func :pointer)
  (data :pointer))

(define-wl-func event-loop get-fd :int)

(define-wl-func event-loop add-destroy-listener :void
  (listener :pointer))

(define-wl-func event-loop get-destroy-listener :pointer
  (notify-func :pointer))

(defcfun ("wl_display_create" display-create) :pointer)
(cl:export 'display-create)

(define-wl-func display destroy :void)

(define-wl-func display get-event-loop :pointer)

(define-wl-func display add-socket :int
  (name :string))

(define-wl-func display add-socket-auto :string)

(define-wl-func display add-socket-fd :int
  (socket-fd :int))

(define-wl-func display terminate :void)

(define-wl-func display run :void)

(define-wl-func display flush-clients :void)

(define-wl-func display destroy-clients :void)

(define-wl-func display set-default-max-buffer-size :void
  (max-buffer-size :unsigned-long-long))

(define-wl-func display get-serial :uint32)

(define-wl-func display next-serial :uint32)

(define-wl-func display add-destroy-listener :void
  (listener :pointer))

(defcfun ("wl_global_create" global-create) :pointer
  (display :pointer)
  (interface :pointer)
  (version :int)
  (data :pointer)
  (bind-func :pointer))
(cl:export 'global-create)

(define-wl-func global remove :void)

(define-wl-func global destroy :void)

(define-wl-func display set-global-filter :void
  (filter-func :pointer)
  (data :pointer))

(define-wl-func global get-interface :pointer)

(define-wl-func global get-name :uint32
  (client :pointer))

(define-wl-func global get-version :uint32)

(define-wl-func global get-display :pointer)

(define-wl-func global get-user-data :pointer)

(define-wl-func global set-user-data :void
  (data :pointer))

(defcfun ("wl_client_create" client-create) :pointer
  (display :pointer)
  (fd :int))
(cl:export 'client-create)

(define-wl-func display get-client-list :pointer)

(define-wl-func client get-link :pointer)

(defcfun ("wl_client_from_link" client-from-link) :pointer
  (link :pointer))
(cl:export 'client-from-link)

(define-wl-func client destroy :void)

(define-wl-func client flush :void)

(define-wl-func client get-credentials :void
  (pid (:pointer :int))
  (uid (:pointer :int))
  (gid (:pointer :int)))

(define-wl-func client get-fd :int)

(define-wl-func client add-destroy-listener :void
  (listener :pointer))

(define-wl-func client get-destroy-listener :pointer
  (notify-func :pointer))

(define-wl-func client add-destroy-later-listener :void
  (listener :pointer))

(define-wl-func client get-destroy-later-listener :pointer
  (notify-func :pointer))

(define-wl-func client get-object :pointer
  (id :uint32))

(define-wl-func client post-no-memory :void)

(define-wl-func client post-no-implementation-error :void
  (msg :string)
  cl:&rest)

(define-wl-func client add-resource-created-listener :void
  (listener :pointer))

(define-wl-func client for-each-resource :void
  (iterator-func :pointer)
  (user-data :pointer))

(define-wl-func client set-user-data :void
  (data :pointer)
  (data-destroy-func :pointer))

(define-wl-func client get-user-data :pointer)

(define-wl-func client set-max-buffer-size :void
  (max-buffer-size :unsigned-long-long))

(defcstruct listener
  (:link (:struct list))
  (:notify :pointer))
(cl:export 'listener)

(defcstruct signal
  (:listener-list (:struct list)))
(cl:export 'signal)

(define-wl-func signal init :void)

(define-wl-func signal add :void
  (listener :pointer))

(define-wl-func signal get :pointer
  (notify-func :pointer))

(define-wl-func signal emit :void
  (data :pointer))

(define-wl-func signal emit-mutable :void
  (data :pointer))

(define-wl-func resource post-event :void
  (opcode :uint32)
  cl:&rest)

(define-wl-func resource post-event-array :void
  (opcode :uint32)
  (args :pointer))

(define-wl-func resource queue-event :void
  (opcode :uint32)
  cl:&rest)

(define-wl-func resource queue-event-array :void
  (opcode :uint32)
  cl:&rest)

(define-wl-func resource post-error :void
  (code :uint32)
  (msg :string)
  cl:&rest)

(define-wl-func resource post-no-memory :void)

(define-wl-func client get-display :pointer)

(defcfun ("wl_resource_create" resource-create) :pointer
  (client :pointer)
  (interface :pointer)
  (version :int)
  (id :uint32))
(cl:export 'resource-create)

(define-wl-func resource set-implementation :void
  (implementation :pointer)
  (data :pointer)
  (destroy-func :pointer))

(define-wl-func resource set-dispatcher :void
  (dispatcher-func :pointer)
  (implementation :pointer)
  (data :pointer)
  (destroy-func :pointer))

(define-wl-func resource destroy :void)

(define-wl-func resource get-id :uint32)

(define-wl-func resource get-link :pointer)

(defcfun ("wl_resource_from_link" resource-from-link) :pointer
  (resource-list :pointer))
(cl:export 'resource-from-link)

(defcfun ("wl_resource_find_for_client" resource-find-for-client) :pointer
  (list :pointer)
  (client :pointer))
(cl:export 'resource-find-for-client)

(define-wl-func resource get-client :pointer)

(define-wl-func resouce set-user-data :void
  (data :pointer))

(define-wl-func resource get-user-data :pointer)

(define-wl-func resource get-version :int)

(define-wl-func resource set-destructor :void
  (destroy-func :pointer))

(define-wl-func resource instance-of :int
  (interface :pointer)
  (implementation :pointer))

(define-wl-func resource get-class :string)

(define-wl-func resource add-destroy-listener :void
  (listener :pointer))

(define-wl-func resource get-destroy-listener :pointer
  (notify-func :pointer))

(defcfun ("wl_shm_buffer_get" shm-buffer-get) :pointer
  (resource :pointer))
(cl:export 'shm-buffer-get)

(define-wl-func shm-buffer begin-access :void)

(define-wl-func shm-buffer end-access :void)

(define-wl-func shm-buffer get-data :pointer)

(define-wl-func shm-buffer get-stride :int32)

(define-wl-func shm-buffer get-format :uint32)

(define-wl-func shm-buffer get-width :int32)

(define-wl-func shm-buffer get-height :int32)

(define-wl-func shm-buffer ref-pool :pointer)

(define-wl-func shm-pool unref :void)

(define-wl-func display init-shm :int)

(define-wl-func display add-shm-format (:pointer :uint32)
  (format :uint32))
