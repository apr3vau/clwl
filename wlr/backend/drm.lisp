(in-package "WLR")

(define-wlr-events-struct drm-lease destroy)

(defcstruct drm-lease
  (fd :int)
  (lessee-id :uint32)
  (drm-backend :pointer)
  (events (:struct drm-lease-events))
  (data :pointer))

(defcfun ("wlr_drm_backend_create" drm-backend-create) :pointer
  (session :pointer)
  (device :pointer)
  (parent :pointer))
(export 'drm-backend-create)

(define-wlr-func backend is-drm :bool)
(define-wlr-func output is-drm :bool)

(define-wlr-func drm-backend get-parent :pointer)

(defcfun ("wlr_drm_connector_get_id" drm-connector-get-id) :uint32
  (output :pointer))
(export 'drm-connector-get-id)

(define-wlr-func drm-backend get-non-master-fd :int)

(defcfun ("wlr_drm_create_lease" drm-create-lease) :pointer
  (outputs :pointer)
  (outputs-count :unsigned-long-long)
  (lease-fd (:pointer :int)))
(export 'drm-create-lease)

(define-wlr-func drm-lease terminate :void)

(defcfun ("wlr_drm_connector_add_mode" drm-connector-add-mode) :pointer
  (output :pointer)
  (mode :pointer))

(defcfun ("wlr_drm_mode_get_info" drm-mode-get-info) :pointer
  (output-mode :pointer))

(defcfun ("wlr_drm_connector_get_panel_orientation" drm-connector-get-panel-orientation) :int
  (output :pointer))

(export '(drm-connector-add-mode drm-mode-get-info drm-connector-get-panel-orientation))
