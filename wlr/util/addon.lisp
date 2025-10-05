(in-package "WLR")

(defcstruct addon-set-private
  (:addons (:struct wl:list)))

(defcstruct addon-set
  (:private (:struct addon-set-private)))

(defcstruct addon-interface
  (:name :string)
  (:destroy :pointer))

(defcstruct addon-private
  (:owner :pointer)
  (:link (:struct wl:list)))

(defcstruct addon
  (:impl (:pointer (:struct addon-interface)))
  (:private (:struct addon-private)))

(export '(addon-set-private addon-set addon-interface addon-private addon))

(define-wlr-func addon-set init :void)
(define-wlr-func addon-set finish :void)

(define-wlr-func addon init :void
  (addon-set (:pointer (:struct addon-set)))
  (owner :pointer)
  (impl (:pointer (:struct addon-interface))))
(define-wlr-func addon finish :void)

(defcfun ("wlr_addon_find" addon-find) (:pointer (:struct addon))
  (addon-set (:pointer (:struct addon-set)))
  (owner :pointer)
  (impl (:pointer (:struct addon-interface))))
(export 'addon-find)
