(in-package "WLR")

(define-wlr-events-struct output-layout
  add
  change
  destroy)

(define-wlr-private-listener output-layout display-destroy)

(defcstruct output-layout
  (:outputs (:struct wl:list))
  (:display :pointer)
  (:events (:struct output-layout-events))
  (:data :pointer)
  (:private (:struct output-layout-private)))

(define-wlr-events-struct output-layout-output destroy)

(define-wlr-private-listener output-layout-output addon commit)

(defcstruct output-layout-output
  (:layout :pointer)
  (:output :pointer)
  (:x :int)
  (:y :int)
  (:link (:struct wl:list))
  (:auto-configured :bool)
  (:events (:struct output-layout-output-events))
  (:private (:struct output-layout-output-private)))

(defcenum direction
  (:up 1)
  (:down 2)
  (:left 4)
  (:right 8))

(defcfun ("wlr_output_layout_create" output-layout-create) :pointer
  (display :pointer))
(export 'output-layout-create)

(define-wlr-func output-layout destroy :void)

(define-wlr-func output-layout get :pointer
  (reference :pointer))

(define-wlr-func output-layout output-at :pointer
  (lx :double)
  (ly :double))

(define-wlr-func output-layout add :pointer
  (output :pointer)
  (lx :int)
  (ly :int))

(define-wlr-func output-layout add-auto :pointer
  (output :pointer))

(define-wlr-func output-layout remove :void
  (output :pointer))

(define-wlr-func output-layout output-coords :void
  (reference :pointer)
  (lx (:pointer :double))
  (ly (:pointer :double)))

(define-wlr-func output-layout contains-point :bool
  (reference :pointer)
  (lx :int)
  (ly :int))

(define-wlr-func output-layout intersects :bool
  (reference :pointer)
  (target-lbox (:pointer (:struct box))))

(define-wlr-func output-layout closest-point :void
  (reference :pointer)
  (lx :double)
  (ly :double)
  (dest-lx (:pointer :double))
  (dest-ly (:pointer :double)))

(define-wlr-func output-layout get-box :void
  (reference :pointer)
  (dest-box (:pointer (:struct box))))

(define-wlr-func output-layout get-center-output :pointer)

(define-wlr-func output-layout adjacent-output :pointer
  (direction :int)
  (reference :pointer)
  (ref-lx :double)
  (ref-ly :double))

(define-wlr-func output-layout farthest-output :pointer
  (direction :int)
  (reference :pointer)
  (ref-lx :double)
  (ref-ly :double))

(export '(output-layout output-layout-output direction))
