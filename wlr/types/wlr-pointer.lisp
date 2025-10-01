(in-package "WLR")

(define-wlr-events-struct pointer
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
  hold-end)

(defcstruct pointer
  (:base (:struct input-device))
  (:impl :pointer)
  (:output-name :string)
  (:buttons (:array :uint32 16))
  (:button-count :size)
  (:events (:struct pointer-events))
  (:data :pointer))

(defcstruct pointer-motion-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:delta-x :double)
  (:delta-y :double)
  (:unaccel-dx :double)
  (:unaccel-dy :double))

(defcstruct pointer-motion-absolute-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:x :double)
  (:y :double))

(defcstruct pointer-button-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:button :uint32)
  (:state :int))

(defcstruct pointer-axis-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:source :int)
  (:orientation :int)
  (:relative-direction :int)
  (:delta :double)
  (:delta-discrete :int32))

(defcstruct pointer-swipe-begin-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:fingers :uint32))

(defcstruct pointer-swipe-update-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:fingers :uint32)
  (:dx :double)
  (:dy :double))

(defcstruct pointer-swipe-end-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:cancelled :bool))

(defcstruct pointer-pinch-begin-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:fingers :uint32))

(defcstruct pointer-pinch-update-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:fingers :uint32)
  (:dx :double)
  (:dy :double)
  (:scale :double)
  (:rotation :double))

(defcstruct pointer-pinch-end-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:cancelled :bool))

(defcstruct pointer-hold-begin-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:fingers :uint32))

(defcstruct pointer-hold-end-event
  (:pointer :pointer)
  (:time-msec :uint32)
  (:cancelled :bool))

(defcfun ("wlr_pointer_from_input_device" pointer-from-input-device) :pointer
  (input-device :pointer))
(export 'pointer-from-input-device)

(export '(pointer pointer-motion-event pointer-motion-absolute-event pointer-button-event pointer-axis-event pointer-swipe-begin-event pointer-swipe-update-event pointer-swipe-end-event pointer-pinch-begin-event pointer-pinch-update-event pointer-pinch-end-event pointer-hold-begin-event pointer-hold-end-event))
