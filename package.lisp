(defpackage "WL"
  (:use :cffi))

(in-package "WL")

(define-foreign-library libwayland-server
  (:unix (:or "libwayland-server.so"))
  (t (:default "libwayland-server")))
(define-foreign-library libwayland-client
  (:unix (:or "libwayland-client.so"))
  (t (:default "libwayland-client")))

(use-foreign-library libwayland-server)
(use-foreign-library libwayland-client)

(cl:defmacro define-wl-func (object suffix ret-type cl:&body args)
  (cl:let* ((object-str (translate-underscore-separated-name object))
            (suffix-str (translate-underscore-separated-name suffix))
            (c-name (cl:concatenate 'cl:string "wl_" object-str "_" suffix-str))
            (lisp-name (cl:intern (cl:concatenate
                                   'cl:string
                                   (cl:symbol-name object) "-" (cl:symbol-name suffix))
                                  "WL")))
    `(cl:eval-when (:compile-toplevel :load-toplevel :execute)
       (defcfun (,c-name ,lisp-name) ,ret-type
         (,object :pointer)
         ,@args)
       (cl:export ',lisp-name))))

(defpackage "WLR"
  (:use :cl :cffi :alexandria :anaphora))
