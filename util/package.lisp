(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (cl:unless (cl:find-package "WL-UTIL")
    (cl:make-package "WL-UTIL" :use '("CL" "CFFI"))))
(cl:in-package "WL-UTIL")