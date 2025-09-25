(in-package "WLR")

(defcenum log-importance
  (:silent 0)
  (:error 1)
  (:info 2)
  (:debug 3)
  :last)

(defcfun ("wlr_log_init" log-init) :void
  (verbosity :int)
  (callback :pointer))

(defcfun ("wlr_log_get_verbosity" log-get-verbosity) :int)

(export '(log-init log-get-verbosity))
