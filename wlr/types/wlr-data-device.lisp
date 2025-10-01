(in-package "WLR")

(define-wlr-events-struct data-device-manager destroy)

(define-wlr-private-listener data-device-manager display-destroy)

(defcstruct data-device-manager
  (:global :pointer)
  (:data-sources (:struct wl:list))
  (:events (:struct data-device-manager-events))
  (:data :pointer)
  (:private (:struct data-device-manager-private)))

(defcenum data-offer-type
  :selection
  :drag)

(define-wlr-private-listener data-offer source-destroy)

(defcstruct data-offer
  (:resource :pointer)
  (:source :pointer)
  (:type :int)
  (:link (:struct wl:list))
  (:actions :uint32)
  (:preferred-action :int)
  (:in-ask :bool)
  (:private (:struct data-offer-private)))

(defcstruct data-source-impl
  (:send :pointer)
  (:accept :pointer)
  (:destroy :pointer)
  (:dnd-drop :pointer)
  (:dnd-finish :pointer)
  (:dnd-action :pointer))

(define-wlr-events-struct data-source destroy)

(defcstruct data-source
  (:impl :pointer)
  (:mime-types (:struct wl:array))
  (:actions :int32)
  (:accepted :bool)
  (:current-dnd-action :int)
  (:compositor-action :uint32)
  (:events (:struct data-source-events)))

(define-wlr-events-struct drag-icon destroy)

(define-wlr-private-listener drag-icon surface-destroy)

(defcstruct drag-icon
  (:drag :pointer)
  (:surface :pointer)
  (:events (:struct drag-icon-events))
  (:data :pointer)
  (:private (:struct drag-icon-private)))

(defcenum drag-grab-type
  :keyboard
  :keyboard-pointer
  :keyboard-touch)

(define-wlr-events-struct drag
  focus
  motion
  drop
  destroy)

(define-wlr-private-listener drag source-destroy seat-client-destroy focus-destroy icon-destroy)

(defcstruct drag
  (:grab-type :int)
  (:keyboard-grab (:struct seat-keyboard-grab))
  (:pointer-grab (:struct seat-pointer-grab))
  (:touch-grab (:struct seat-touch-grab))
  (:seat :pointer)
  (:seat-client :pointer)
  (:focus-client :pointer)
  (:icon :pointer)
  (:focus :pointer)
  (:source :pointer)
  (:started :bool)
  (:dropped :bool)
  (:cancelling :bool)
  (:grab-touch-id :int32)
  (:touch-id :int32)
  (:events (:struct drag-events))
  (:data :pointer)
  (:private (:struct drag-private)))

(defcstruct drag-motion-event
  (:drag :pointer)
  (:time :uint32)
  (:sx :double)
  (:sy :double))

(defcstruct drag-drop-event
  (:drag :pointer)
  (:time :uint32))

(defcfun ("wlr_data_device_manager_create" data-device-manager-create) :pointer
  (display :pointer))
(export 'data-device-manager-create)

(define-wlr-func seat request-set-selection :void
  (seat-client :pointer)
  (source :pointer)
  (serial :uint32))

(define-wlr-func seat set-selection :void
  (source :pointer)
  (serial :uint32))

(defcfun ("wlr_drag_create" drag-create) :pointer
  (seat-client :pointer)
  (source :pointer)
  (icon-surface :pointer))
(export 'drag-create)

(define-wlr-func seat request-start-drag :void
  (drag :pointer)
  (origin :pointer)
  (serial :uint32))

(define-wlr-func seat start-drag :void
  (drag :pointer)
  (serial :uint32))

(define-wlr-func seat start-pointer-drag :void
  (drag :pointer)
  (serial :uint32))

(define-wlr-func seat start-touch-drag :void
  (drag :pointer)
  (serial :uint32)
  (point :pointer))

(define-wlr-func data-source init :void
  (impl :pointer))

(define-wlr-func data-source send :void
  (mime-type :string)
  (fd :int32))

(define-wlr-func data-source accept :void
  (serial :uint32)
  (mime-type :string))

(define-wlr-func data-source destroy :void)

(define-wlr-func data-source dnd-drop :void)

(define-wlr-func data-source dnd-finish :void)

(define-wlr-func data-source dnd-action :void
  (action :int))
