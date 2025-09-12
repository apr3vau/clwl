(cl:defpackage "WL"
  (:use :cffi))
(cl:in-package "WL")

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

(cl:eval-when (:compile-toplevel :load-toplevel :execute)
 (cl:export '(signal listener libwayland-server libwayland-client)))

(cl:defpackage "WLR"
  (:use :cl :cffi :alexandria :anaphora))
(cl:in-package "WLR")

(define-foreign-library libwlroots
  (:unix (:or "libwlroots-0.19.so" "libwlroots-0.20.so" "libwlroots-0.18.so")))

(use-foreign-library wl:libwayland-server)

(defmacro define-wlr-events-struct (name &body signals)
  (let ((struct-name (intern (concatenate 'string (symbol-name name) "-EVENTS") "WLR")))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (defcstruct ,struct-name
         ,@(loop for signal in signals
                 collect `(,signal (:struct wl:signal))))
       (export ',struct-name))))

(defmacro define-wlr-private-listener (name &body listeners)
  (let ((struct-name (intern (concatenate 'string (symbol-name name) "-PRIVATE") "WLR")))
    `(defcstruct ,struct-name
       ,@(loop for listener in listeners
               collect `(,listener (:struct wl:listener))))))

(defmacro define-wlr-func (object suffix ret-type &body args)
  (let* ((object-str (translate-underscore-separated-name object))
         (suffix-str (translate-underscore-separated-name suffix))
         (c-name (concatenate 'string "wlr_" object-str "_" suffix-str))
         (lisp-name (intern (concatenate
                             'string
                             (symbol-name object) "-" (symbol-name suffix))
                            "WLR")))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (defcfun (,c-name ,lisp-name) ,ret-type
         (,object :pointer)
         ,@args)
       (export ',lisp-name))))
