(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (cl:unless (cl:find-package "WL")
    (cl:make-package "WL" :use '("CFFI"))))
(cl:in-package "WL")

(define-foreign-library libwayland-server
  (:unix (:or "libwayland-server.so"))
  (t (:default "libwayland-server")))
(define-foreign-library libwayland-client
  (:unix (:or "libwayland-client.so"))
  (t (:default "libwayland-client")))

(use-foreign-library libwayland-server)
(use-foreign-library libwayland-client)

(cl:defmacro define-wl-func (type suffix ret-type cl:&body args)
  (cl:let* ((object-str (translate-underscore-separated-name type))
            (suffix-str (translate-underscore-separated-name suffix))
            (c-name (cl:concatenate 'cl:string "wl_" object-str "_" suffix-str))
            (lisp-name (cl:intern (cl:concatenate
                                   'cl:string
                                   (cl:symbol-name type) "-" (cl:symbol-name suffix))
                                  "WL")))
    `(cl:eval-when (:compile-toplevel :load-toplevel :execute)
       (defcfun (,c-name ,lisp-name) ,ret-type
         (,type (:pointer (:struct ,type)))
         ,@args)
       (cl:export ',lisp-name))))

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
         (,proxy-name ,name ,@args))
       (cl:export ',lisp-name))))

(defcstruct display)
(defcstruct proxy)
(defcstruct event-queue)
(defcstruct surface)
(defcstruct egl-window)