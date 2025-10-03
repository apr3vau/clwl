(in-package "WLR")

(defcstruct pixman-region32-data
  (size :long)
  (num-rects :long))

(defcstruct pixman-rectangle32
  (x :int32)
  (y :int32)
  (width :uint32)
  (height :uint32))

(defcstruct pixman-box32
  (x1 :int32)
  (y1 :int32)
  (x2 :int32)
  (y2 :int32))

(defcstruct pixman-region32
  (extents (:struct pixman-box32))
  (data (:pointer (:struct pixman-region32-data))))

(export '(pixman-region32-data pixman-rectangle32 pixman-box32 pixman-region32))
