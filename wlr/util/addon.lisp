(in-package "WLR")

(defcstruct addon-set-private
  (addons (:struct wl:list)))

(defcstruct addon-set
  (private (:struct addon-set-private)))

(defcstruct addon-interface
  (name :string)
  (destroy :pointer))

(defcstruct addon-private
  (owner :pointer)
  (link (:struct wl:list)))

(defcstruct addon
  (impl :pointer)
  (private (:struct addon-private)))

(define-wlr-func addon-set init :void)
(define-wlr-func addon-set finish :void)

(define-wlr-func addon init :void
  (addon-set :pointer)
  (owner :pointer)
  (impl :pointer))
(define-wlr-func addon finish :void)

(defcfun ("wlr_addon_find" addon-find) :pointer
  (addon-set :pointer)
  (owner :pointer)
  (impl :pointer))
(export 'addon-find)
