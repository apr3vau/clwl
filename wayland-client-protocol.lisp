(cl:in-package "WL")

(cl:defmacro define-wl-interface (name)
  (cl:let ((foreign-name (cl:concatenate
                          'cl:string
                          "wl_" (translate-underscore-separated-name name) "_interface"))
           (lisp-name (cl:intern
                       (cl:concatenate 'cl:string
                                       "*" (cl:symbol-name name) "-INTERFACE*"))))
    `(cl:eval-when (:compile-toplevel :load-toplevel :execute)
       (cl:define-symbol-macro ,lisp-name (foreign-symbol-pointer ,foreign-name))
       (cl:export ',lisp-name))))

(cl:defmacro define-wl-proxy-func (name func-name cl:&body args)
  (cl:let ((proxy-name (cl:intern
                        (cl:concatenate 'cl:string
                                        "PROXY-" (cl:symbol-name func-name))))
           (lisp-name (cl:intern
                       (cl:concatenate
                        'cl:string
                        (cl:symbol-name name) "-" (cl:symbol-name func-name)))))
    `(cl:eval-when (:compile-toplevel :load-toplevel :execute)
       (cl:defun ,lisp-name (,name ,@args)
         (cl:declare (cl:inline ,lisp-name))
         (,proxy-name ,name ,@args)))))

(define-wl-interface display)
(define-wl-interface registry)
(define-wl-interface callback)
(define-wl-interface compositor)
(define-wl-interface shm-pool)
(define-wl-interface shm)
(define-wl-interface buffer)
(define-wl-interface data-offer)
(define-wl-interface data-source)
(define-wl-interface data-device)
(define-wl-interface data-service-manager)
(define-wl-interface shell)
(define-wl-interface shell-surface)
(define-wl-interface surface)
(define-wl-interface seat)
(define-wl-interface pointer)
(define-wl-interface keyboard)
(define-wl-interface touch)
(define-wl-interface output)
(define-wl-interface region)
(define-wl-interface subcompositor)
(define-wl-interface subsurface)

(defcenum display-error
  (:invalid-object 0)
  (:invalid-method 1)
  (:no-memory 2)
  (:implementation 3))
(cl:export 'display-error)

(defcstruct display-listener
  (:error :pointer)
  (:delete-id :pointer))
(cl:export 'display-listener)

(define-wl-proxy-func display add-listener listener data)

(define-wl-proxy-func display set-user-data userdata)

(define-wl-proxy-func display get-user-data)

(define-wl-proxy-func display get-version)

(cl:defvar *display-sync* 0)
(cl:defvar *display-get-registry* 1)

(cl:defun display-sync (display)
  (proxy-marshal-flags display *display-sync* *display-interface*
                       (proxy-get-version display) 0
                       :pointer (null-pointer)))

(cl:defun display-get-registry (display)
  (proxy-marshal-flags display *display-get-registry* *registry-interface*
                       (proxy-get-version display) 0
                       :pointer (null-pointer)))

(defcstruct registry-listener
  (:global :pointer)
  (:global-remove :pointer))

(define-wl-proxy-func registry add-listener listener data)

(cl:defvar *registry-bind* 0)

(define-wl-proxy-func registry set-user-data user-data)

(define-wl-proxy-func registry get-user-data)

(define-wl-proxy-func registry get-version)

(define-wl-proxy-func registry destroy)

(cl:defun registry-bind (registry name interface version)
  (proxy-marshal-flags registry *registry-bind* interface version 0
                       :uint32 name
                       :string (foreign-slot-value interface 'interface :name)
                       :uint32 version
                       :pointer (null-pointer)))

(defcstruct callback-listener
  (:done :pointer))

(define-wl-proxy-func callback add-listener listener data)

(define-wl-proxy-func callback set-user-data user-data)

(define-wl-proxy-func callback get-user-data)

(define-wl-proxy-func callback get-version)

(define-wl-proxy-func callback destroy)

(cl:defvar *compositor-create-surface* 0)
(cl:defvar *compositor-create-region* 1)

(define-wl-proxy-func compositor set-user-data user-data)

(define-wl-proxy-func compositor get-user-data)

(define-wl-proxy-func compositor get-version)

(define-wl-proxy-func compositor destroy)

(cl:defun compositor-create-surface (compositor)
  (proxy-marshal-flags compositor *compositor-create-surface* *surface-interface*
                       (proxy-get-version compositor) 0
                       :pointer (null-pointer)))

(cl:defun compositor-create-region (compositor)
  (proxy-marshal-flags compositor *compositor-create-region* *compositor-interface*
                       (proxy-get-version compositor) 0
                       :pointer (null-pointer)))

(cl:defvar *shm-pool-create-buffer* 0)
(cl:defvar *shm-pool-destroy* 1)
(cl:defvar *shm-pool-resize* 2)

(define-wl-proxy-func shm-pool set-user-data user-data)

(define-wl-proxy-func shm-pool get-user-data)

(define-wl-proxy-func shm-pool get-version)

(cl:defun shm-pool-create-buffer (pool offset width height stride format)
  (proxy-marshal-flags pool *shm-pool-create-buffer* *buffer-interface*
                       (proxy-get-version pool) 0
                       :pointer (null-pointer)
                       :int32 offset
                       :int32 width
                       :int32 height
                       :int32 stride
                       :uint32 format))

(cl:defun shm-pool-destroy (pool)
  (proxy-marshal-flags pool *shm-pool-destroy* (null-pointer)
                       (proxy-get-version pool) *marshal-flag-destroy*))

(cl:defun shm-pool-resize (pool size)
  (proxy-marshal-flags pool *shm-pool-resize* (null-pointer)
                       (proxy-get-version pool) 0
                       :int32 size))

(defcenum shm-error
  (:invalid-format 0)
  (:invalid-stride 1)
  (:invalid-fd 2))

(defcenum shm-format
  (:argb8888 0)
  (:xrgb8888 1)
  )

(defcstruct shm-listener
  (:format :pointer))

(define-wl-proxy-func shm add-listener listener data)

(cl:defvar *shm-create-pool* 0)
(cl:defvar *shm-release* 1)

(define-wl-proxy-func shm set-user-data user-data)

(define-wl-proxy-func shm get-user-data)

(define-wl-proxy-func shm get-version)

(define-wl-proxy-func shm destroy)

(cl:defun shm-create-pool (shm fd size)
  (proxy-marshal-flags shm *shm-create-pool* *shm-pool-interface* (proxy-get-version shm) 0
                       :pointer (null-pointer) :int32 fd :int32 size))

(cl:defun shm-release (shm)
  (proxy-marshal-flags shm *shm-create-pool* *shm-pool-interface*
                       (proxy-get-version shm) *marshal-flag-destroy*))
