(in-package "WLR")

(define-wlr-events-struct device change remove)

(defcstruct device
  (fd :int)
  (device-fd :int)
  (dev :unsigned-long)
  (link (:struct wl:list))
  (events (:struct device-events)))

(define-wlr-events-struct session active add-drm-card destroy)

(define-wlr-private-listener session event-loop-destroy)

(defcstruct session
  (active :bool)
  (seat :string)
  (udev :pointer)
  (udev-monitor :pointer)
  (udev-event :pointer)
  (seat-handle :pointer)
  (devices (:struct wl:list))
  (event-loop :pointer)
  (events (:struct session-events))
  (private (:struct session-private)))

(defcstruct session-add-event
  (path :string))

(defcenum device-change-type
  (:hotplug 1)
  :lease)

(defcstruct device-hotplug-event
  (connector-id :uint32)
  (prop-id :uint32))

(defcunion device-hotplug-union
  (hotplug (:struct device-hotplug-event)))

(defcstruct device-change-event
  (type :int)
  (union (:union device-hotplug-union)))

(defcfun ("wlr_session_create" session-create) :pointer
  (event-loop :pointer))

(define-wlr-func session destroy :void)

(define-wlr-func session open-file :pointer
  (path :string))

(define-wlr-func session close-file :void
  (device :pointer))

(define-wlr-func session change-vt :bool
  (vt :unsigned-int))

(define-wlr-func session find-gpus :long-long
  (return-len :unsigned-long-long)
  (ret :pointer))
