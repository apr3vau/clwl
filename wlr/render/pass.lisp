(in-package "WLR")

(defcstruct buffer-pass-options
  (:timer :pointer)
  (:color-transform :pointer)
  (:signal-timeline :pointer)
  (:signal-point :uint64))

(define-wlr-func renderer begin-buffer-pass :pointer
  (buffer :pointer)
  (options :pointer))

(define-wlr-func render-pass submit :bool)

(defcenum render-blend-mode
  :premultiplied
  :none)

(defcenum scale-filter-mode
  :bilinear
  :nearest)

(defcstruct renderer-texture-options
  (:texture :pointer)
  (:src-box (:struct fbox))
  (:dst-box (:struct box))
  (:alpha :float)
  (:clip :pointer)
  (:transform :int)
  (:filter-mode :int)
  (:blend-mode :int)
  (:wait-timeline :pointer)
  (:wait-point :uint64))

(define-wlr-func render-pass add-texture :void
  (options :pointer))

(defcstruct render-color
  (:r :float)
  (:g :float)
  (:b :float)
  (:a :float))

(defcstruct render-rect-options
  (:box (:struct box))
  (:color (:struct render-color))
  (:cliip :pointer)
  (:blend-mode :int))

(export '(buffer-pass-options renderer-texture-options render-color render-rect-options))

(define-wlr-func render-pass add-rect :void
  (options :pointer))
