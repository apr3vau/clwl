(in-package "WLR")

(defctype scene-buffer-point-accepts-input-func :pointer)
(defctype scene-buffer-iterator-func :pointer)

(defcstruct damage-ring-private
  (:buffers (:struct wl:list)))

(defcstruct damage-ring
  (:current (:struct pixman-region32))
  (:private (:struct damage-ring-private)))

(defcenum scene-node-type
  :tree
  :rect
  :buffer)

(define-wlr-events-struct scene-node destroy)

(defcstruct scene-node
  (:type :int)
  (:parent :pointer)
  (:link (:struct wl:list))
  (:enabled :bool)
  (:x :int)
  (:y :int)
  (:events (:struct scene-node-events))
  (:data :pointer)
  (:addons (:struct addon-set))
  (:private :pointer))

(defcenum scene-debug-damage-option
  :none
  :rerender
  :highlight)

(defcstruct scene-tree
  (:node (:struct scene-node))
  (:children (:struct wl:list)))

(defcstruct scene
  (:tree (:struct scene-tree))
  (:outputs (:struct wl:list))
  (:linux-dmabuf-v1 :pointer)
  (:gamma-control-manager-v1 :pointer)
  (:private :pointer))

(defcstruct scene-surface
  (:buffer :pointer)
  (:surface :pointer)
  (:private :pointer))

(defcstruct scene-rect
  (:node (:struct scene-node))
  (:width :int)
  (:height :int)
  (:color (:array :float 4)))

(defcstruct scene-outputs-update-event
  (:active :pointer)
  (:size :size))

(defcstruct scene-output-sample-event
  (:output :pointer)
  (:direct-scanout :bool))

(define-wlr-events-struct scene-buffer
  outputs-update
  output-enter
  output-leave
  output-sample
  frame-done)

(defcstruct scene-buffer
  (:node (:struct scene-node))
  (:buffer :pointer)
  (:events (:struct scene-buffer-events))
  (:point-accepts-input scene-buffer-point-accepts-input-func)
  (:primary-output :pointer)
  (:opacity :float)
  (:filter-mode :int)
  (:src-box (:struct fbox))
  (:dst-width :int)
  (:dst-height :int)
  (:transform :int)
  (:opaque-region (:struct pixman-region32))
  (:private :pointer))

(define-wlr-events-struct scene-output destroy)

(defcstruct scene-output
  (:output :pointer)
  (:link (:struct wl:list))
  (:scene :pointer)
  (:addon (:struct addon))
  (:damage-ring (:struct damage-ring))
  (:x :int)
  (:y :int)
  (:events (:struct scene-output-events))
  (:private :pointer))

(defcstruct scene-timer
  (:pre-render-duration :int64)
  (:render-timer :pointer))

(defcstruct scene-layer-surface-v1
  (:tree :pointer)
  (:layer-surface :pointer)
  (:private :pointer))

(defcstruct scene-buffer-set-buffer-options
  (:damage (:pointer (:struct pixman-region32)))
  (:wait-timeline :pointer)
  (:wait-point :uint64))

(defcstruct scene-output-state-options
  (:timer :pointer)
  (:color-transform :pointer)
  (:swapchain :pointer))

(define-wlr-func scene-node destroy :void)

(define-wlr-func scene-node set-enabled :void
  (enabled :bool))

(define-wlr-func scene-node set-position :void
  (x :int)
  (y :int))

(define-wlr-func scene-node place-above :void
  (sibling :pointer))

(define-wlr-func scene-node place-below :void
  (sibling :pointer))

(define-wlr-func scene-node raise-to-top :void)

(define-wlr-func scene-node lower-to-bottom :void)

(define-wlr-func scene-node reparent :void
  (new-parent :pointer))

(define-wlr-func scene-node coords :bool
  (lx (:pointer :int))
  (ly (:pointer :int)))

(define-wlr-func scene-node for-each-buffer :void
  (iterator scene-buffer-iterator-func)
  (user-data :pointer))

(define-wlr-func scene-node at :pointer
  (lx :double)
  (ly :double)
  (nx (:pointer :double))
  (ny (:pointer :double)))

(defcfun ("wlr_scene_create" scene-create) :pointer)
(export 'scene-create)

(define-wlr-func scene set-linux-dmabuf-v1 :void
  (linux-dmabuf-v1 :pointer))

(define-wlr-func scene set-gamma-control-manager-v1 :void
  (gamma-control :pointer))

(define-wlr-func scene-tree create :pointer)

(defcfun ("wlr_scene_surface_create" scene-surface-create) :pointer
  (parent :pointer)
  (surface :pointer))
(export 'scene-surface-create)

(defcfun ("wlr_scene_buffer_from_node" scene-buffer-from-node) :pointer
  (node :pointer))
(export 'scene-buffer-from-node)

(defcfun ("wlr_scene_tree_from_node" scene-tree-from-node) :pointer
  (node :pointer))
(export 'scene-tree-from-node)

(defcfun ("wlr_scene_rect_from_node" scene-rect-from-node) :pointer
  (node :pointer))
(export 'scene-rect-from-node)

(defcfun ("wlr_scene_surface_try_from_buffer" scene-surface-try-from-buffer) :pointer
  (scene-buffer :pointer))
(export 'scene-surface-try-from-buffer)

(defcfun ("wlr_scene_rect_create" scene-rect-create) :pointer
  (parent :pointer)
  (width :int)
  (height :int)
  (color :pointer))
(export 'scene-rect-create)

(define-wlr-func scene-rect set-size :void
  (width :int)
  (height :int))

(define-wlr-func scene-rect set-color :void
  (color :pointer))

(defcfun ("wlr_scene_buffer_create" scene-buffer-create) :pointer
  (parent :pointer)
  (buffer :pointer))
(export 'scene-buffer-create)

(define-wlr-func scene-buffer set-buffer :void
  (buffer :pointer))

(define-wlr-func scene-buffer set-buffer-with-damage :void
  (buffer :pointer)
  (region (:pointer (:struct pixman-region32))))

(define-wlr-func scene-buffer set-buffer-with-options :void
  (buffer :pointer)
  (options (:pointer (:struct scene-buffer-set-buffer-options))))

(define-wlr-func scene-buffer set-opaque-region :void
  (region (:pointer (:struct pixman-region32))))

(define-wlr-func scene-buffer set-source-box :void
  (box (:pointer (:struct fbox))))

(define-wlr-func scene-buffer set-dest-size :void
  (width :int)
  (height :int))

(define-wlr-func scene-buffer set-transform :void
  (transform :int))

(define-wlr-func scene-buffer set-opacity :void
  (opacity :float))

(define-wlr-func scene-buffer set-filter-mode :void
  (filter-mode :int))

(define-wlr-func scene-buffer send-frame-done :void
  (now :pointer))

(define-wlr-func scene output-create :pointer
  (output :pointer))

(define-wlr-func scene-output destroy :void)

(define-wlr-func scene-output set-position :void
  (lx :int)
  (ly :int))

(define-wlr-func scene-output needs-frame :bool)

(define-wlr-func scene-output commit :bool
  (options (:pointer (:struct scene-output-state-options))))

(define-wlr-func scene-output build-state :bool
  (state :pointer)
  (options (:pointer (:struct scene-output-state-options))))

(define-wlr-func scene-timer get-duration-ns :int64)

(define-wlr-func scene-timer finish :void)

(define-wlr-func scene-output send-frame-done :void
  (now :pointer))

(define-wlr-func scene-output for-each-buffer :void
  (iterator scene-buffer-iterator-func)
  (user-data :pointer))

(define-wlr-func scene get-scene-output :pointer
  (output :pointer))

(define-wlr-func scene attach-output-layout :pointer
  (output-layout :pointer))

(define-wlr-func scene-output-layout add-output :void
  (layout-output :pointer)
  (scene-output :pointer))

(defcfun ("wlr_scene_subsurface_tree_create" scene-subsurface-tree-create) :pointer
  (parent :pointer)
  (surface :pointer))
(export 'scene-subsurface-tree-create)

(defcfun ("wlr_scene_subsurface_tree_set_clip" scene-subsurface-tree-set-clip) :void
  (node :pointer)
  (clip (:pointer (:struct box))))
(export 'scene-subsurface-tree-set-clip)

(defcfun ("wlr_scene_xdg_surface_create" scene-xdg-surface-create) :pointer
  (parent :pointer)
  (xdg-surface :pointer))
(export 'scene-xdg-surface-create)

(defcfun ("wlr_scene_layer_surface_v1_create" scene-layer-surface-v1-create) :pointer
  (parent :pointer)
  (layer-surface :pointer))
(export 'scene-layer-surface-v1-create)

(define-wlr-func scene-layer-surface-v1 configure :void
  (full-area (:pointer (:struct box)))
  (usable-area (:pointer (:struct box))))

(defcfun ("wlr_scene_drag_icon_create" scene-drag-icon-create) :pointer
  (parent :pointer)
  (drag-icon :pointer))
(export 'scene-drag-icon-create)

(export '(scene scene-node scene-tree scene-surface scene-buffer scene-rect scene-output scene-layer-surface-v1 scene-buffer-set-buffer-options scene-output-state-options scene-timer))
