(in-package "WLR")

(define-wlr-events-struct cursor
  motion
  motion-absolute
  button
  axis
  frame
  swipe-begin
  swipe-update
  swipe-end
  pinch-begin
  pinch-update
  pinch-end
  hold-begin
  hold-end

  touch-up
  touch-down
  touch-motion
  touch-cancel
  touch-frame

  tablet-tool-axis
  tablet-tool-proximity
  tablet-tool-tip
  tablet-tool-button)

(defcstruct cursor
  (:state :pointer)
  (:x :double)
  (:y :double)
  (:events (:struct cursor-events))
  (:data :pointer))
(export 'cursor)

(defcfun ("wlr_cursor_create" cursor-create) :pointer)
(export 'cursor-create)

(define-wlr-func cursor destroy :void)

(define-wlr-func cursor warp :bool
  (device :pointer)
  (lx :double)
  (ly :double))

(define-wlr-func cursor absolute-to-layout-coords :void
  (device :pointer)
  (x :double)
  (y :double)
  (lx (:pointer :double))
  (ly (:pointer :double)))

(define-wlr-func cursor warp-closest :void
  (device :pointer)
  (x :double)
  (y :double))

(define-wlr-func cursor warp-absolute :void
  (device :pointer)
  (x :double)
  (y :double))

(define-wlr-func cursor move :void
  (device :pointer)
  (delta-x :double)
  (delta-y :double))

(define-wlr-func cursor set-buffer :void
  (buffer :pointer)
  (hotspot-x :int32)
  (hotspot-y :int32)
  (scale :float))

(define-wlr-func cursor unset-image :void)

(define-wlr-func cursor set-xcursor :void
  (manager :pointer)
  (name :string))

(define-wlr-func cursor set-surface :void
  (surface :pointer)
  (hotspot-x :int32)
  (hotspot-y :int32))

(define-wlr-func cursor attach-input-device :void
  (device :pointer))

(define-wlr-func cursor detach-input-device :void
  (device :pointer))

(define-wlr-func cursor attach-output-layout :void
  (output-layout :pointer))

(define-wlr-func cursor map-to-output :void
  (output :pointer))

(define-wlr-func cursor map-input-to-output :void
  (device :pointer)
  (output :pointer))

(define-wlr-func cursor map-to-region :void
  (box (:pointer (:struct box))))

(define-wlr-func cursor map-input-to-region :void
  (device :pointer)
  (box (:pointer (:struct box))))
