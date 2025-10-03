(in-package "WLR")

(defcstruct texture
  (:impl :pointer)
  (:width :uint32)
  (:height :uint32)
  (:renderer :pointer))

(defcstruct texture-read-pixels-options
  (:data :pointer)
  (:format :uint32)
  (:stride :uint32)
  (:dst-x :uint32)
  (:dst-y :uint32)
  (:src-box (:struct box)))

(export '(texture texture-read-pixels-options))

(define-wlr-func texture read-pixels :bool
  (options :pointer))

(define-wlr-func texture preferred-read-format :uint32)

(defcfun ("wlr_texture_from_pixels" texture-from-pixels) :pointer
  (renderer :pointer)
  (fmt :uint32)
  (stride :uint32)
  (width :uint32)
  (height :uint32)
  (data :pointer))

(defcfun ("wlr_texture_from_dmabuf" texture-from-dmabuf) :pointer
  (renderer :pointer)
  (attributes :pointer))

(export '(texture-from-pixels texture-from-dmabuf))

(define-wlr-func texture update-from-buffer :bool
  (buffer :pointer)
  (damage :pointer))

(define-wlr-func texture destroy :void)

(defcfun ("wlr_texture_from_buffer" texture-from-buffer) :pointer
  (renderer :pointer)
  (buffer :pointer))

(export 'texture-from-buffer)
