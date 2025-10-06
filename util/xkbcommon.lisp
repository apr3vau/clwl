(in-package "WL-UTIL")

(define-foreign-library libxkbcommon
  (:unix (:or "libxkbcommon.so.0" "libxkbcommon.so")))

(use-foreign-library libxkbcommon)

(defctype xkb-keycode-t :uint32)
(defctype xkb-keysym-t :uint32)
(defctype xkb-layout-index-t :uint32)
(defctype xkb-layout-mask-t :uint32)
(defctype xkb-level-index-t :uint32)
(defctype xkb-mod-index-t :uint32)
(defctype xkb-mod-mask-t :uint32)
(defctype xkb-led-index-t :uint32)
(defctype xkb-led-mask-t :uint32)
(defctype xkb-context :pointer)
(defctype xkb-keymap :pointer)
(defctype xkb-state :pointer)
(defctype xkb-keymap-key-iter-t :pointer)

(defconstant +xkb-keycode-invalid+ #xFFFFFFFF)
(defconstant +xkb-layout-invalid+ #xFFFFFFFF)
(defconstant +xkb-level-invalid+ #xFFFFFFFF)
(defconstant +xkb-mod-invalid+ #xFFFFFFFF)
(defconstant +xkb-led-invalid+ #xFFFFFFFF)
(defconstant +xkb-keycode-max+ #xFFFFFFFE)
(defconstant +xkb-keysym-max+ #x1FFFFFFF)
(defconstant +xkb-keymap-use-original-format+ -1)

(defcstruct xkb-rule-names
  (rules :string)
  (model :string)
  (layout :string)
  (variant :string)
  (options :string))

(defcenum xkb-keysym-flags
  (:no-flags 0)
  (:case-insensitive 1))

(defcenum xkb-context-flags
  (:no-flags 0)
  (:no-default-includes 1)
  (:no-environment-names 2)
  (:no-secure-getenv 4))

(defcenum xkb-log-level
  (:critical 10)
  (:error 20)
  (:warning 30)
  (:info 40)
  (:debug 50))

(defcenum xkb-keymap-compile-flags
  (:no-flags 0))

(defcenum xkb-keymap-format
  (:text-v1 1))

(defcenum xkb-key-direction
  (:up 0)
  (:down 1))

(defcenum xkb-state-component
  (:mods-depressed 1)
  (:mods-latched 2)
  (:mods-locked 4)
  (:mods-effective 8)
  (:layout-depressed 16)
  (:layout-latched 32)
  (:layout-locked 64)
  (:layout-effective 128)
  (:leds 256))

(defcenum xkb-state-match
  (:any 1)
  (:all 2)
  (:non-exclusive 65536))

(defcenum xkb-consumed-mode
  (:xkb 0)
  (:gtk 1))

(defcfun ("xkb_keysym_get_name" xkb-keysym-get-name) :int
  (keysym xkb-keysym-t)
  (buffer :pointer)
  (size :size))

(defcfun ("xkb_keysym_from_name" xkb-keysym-from-name) xkb-keysym-t
  (name :string)
  (flags :int))

(defcfun ("xkb_keysym_to_utf8" xkb-keysym-to-utf8) :int
  (keysym xkb-keysym-t)
  (buffer :pointer)
  (size :size))

(defcfun ("xkb_keysym_to_utf32" xkb-keysym-to-utf32) :uint32
  (keysym xkb-keysym-t))

(defcfun ("xkb_utf32_to_keysym" xkb-utf32-to-keysym) xkb-keysym-t
  (ucs :uint32))

(defcfun ("xkb_keysym_to_upper" xkb-keysym-to-upper) xkb-keysym-t
  (keysym xkb-keysym-t))

(defcfun ("xkb_keysym_to_lower" xkb-keysym-to-lower) xkb-keysym-t
  (keysym xkb-keysym-t))

(defcfun ("xkb_context_new" xkb-context-new) xkb-context
  (flags :int))

(defcfun ("xkb_context_ref" xkb-context-ref) xkb-context
  (context xkb-context))

(defcfun ("xkb_context_unref" xkb-context-unref) :void
  (context xkb-context))

(defcfun ("xkb_context_set_user_data" xkb-context-set-user-data) :void
  (context xkb-context)
  (user-data :pointer))

(defcfun ("xkb_context_get_user_data" xkb-context-get-user-data) :pointer
  (context xkb-context))

(defcfun ("xkb_context_include_path_append" xkb-context-include-path-append) :int
  (context xkb-context)
  (path :string))

(defcfun ("xkb_context_include_path_append_default" xkb-context-include-path-append-default) :int
  (context xkb-context))

(defcfun ("xkb_context_include_path_reset_defaults" xkb-context-include-path-reset-defaults) :int
  (context xkb-context))

(defcfun ("xkb_context_include_path_clear" xkb-context-include-path-clear) :void
  (context xkb-context))

(defcfun ("xkb_context_num_include_paths" xkb-context-num-include-paths) :unsigned-int
  (context xkb-context))

(defcfun ("xkb_context_include_path_get" xkb-context-include-path-get) :string
  (context xkb-context)
  (index :unsigned-int))

(defcfun ("xkb_context_set_log_level" xkb-context-set-log-level) :void
  (context xkb-context)
  (level :int))

(defcfun ("xkb_context_get_log_level" xkb-context-get-log-level) :int
  (context xkb-context))

(defcfun ("xkb_context_set_log_verbosity" xkb-context-set-log-verbosity) :void
  (context xkb-context)
  (verbosity :int))

(defcfun ("xkb_context_get_log_verbosity" xkb-context-get-log-verbosity) :int
  (context xkb-context))

(defcfun ("xkb_keymap_new_from_names" xkb-keymap-new-from-names) xkb-keymap
  (context xkb-context)
  (names (:pointer (:struct xkb-rule-names)))
  (flags :int))

(defcfun ("xkb_keymap_new_from_file" xkb-keymap-new-from-file) xkb-keymap
  (context xkb-context)
  (file :pointer)
  (format :int)
  (flags :int))

(defcfun ("xkb_keymap_new_from_string" xkb-keymap-new-from-string) xkb-keymap
  (context xkb-context)
  (string :string)
  (format :int)
  (flags :int))

(defcfun ("xkb_keymap_new_from_buffer" xkb-keymap-new-from-buffer) xkb-keymap
  (context xkb-context)
  (buffer :pointer)
  (length :size)
  (format :int)
  (flags :int))

(defcfun ("xkb_keymap_ref" xkb-keymap-ref) xkb-keymap
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_unref" xkb-keymap-unref) :void
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_get_as_string" xkb-keymap-get-as-string) :pointer
  (keymap xkb-keymap)
  (format :int))

(defcfun ("xkb_keymap_min_keycode" xkb-keymap-min-keycode) xkb-keycode-t
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_max_keycode" xkb-keymap-max-keycode) xkb-keycode-t
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_key_for_each" xkb-keymap-key-for-each) :void
  (keymap xkb-keymap)
  (iter xkb-keymap-key-iter-t)
  (data :pointer))

(defcfun ("xkb_keymap_key_get_name" xkb-keymap-key-get-name) :string
  (keymap xkb-keymap)
  (key xkb-keycode-t))

(defcfun ("xkb_keymap_key_by_name" xkb-keymap-key-by-name) xkb-keycode-t
  (keymap xkb-keymap)
  (name :string))

(defcfun ("xkb_keymap_num_mods" xkb-keymap-num-mods) xkb-mod-index-t
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_mod_get_name" xkb-keymap-mod-get-name) :string
  (keymap xkb-keymap)
  (index xkb-mod-index-t))

(defcfun ("xkb_keymap_mod_get_index" xkb-keymap-mod-get-index) xkb-mod-index-t
  (keymap xkb-keymap)
  (name :string))

(defcfun ("xkb_keymap_num_layouts" xkb-keymap-num-layouts) xkb-layout-index-t
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_layout_get_name" xkb-keymap-layout-get-name) :string
  (keymap xkb-keymap)
  (index xkb-layout-index-t))

(defcfun ("xkb_keymap_layout_get_index" xkb-keymap-layout-get-index) xkb-layout-index-t
  (keymap xkb-keymap)
  (name :string))

(defcfun ("xkb_keymap_num_leds" xkb-keymap-num-leds) xkb-led-index-t
  (keymap xkb-keymap))

(defcfun ("xkb_keymap_led_get_name" xkb-keymap-led-get-name) :string
  (keymap xkb-keymap)
  (index xkb-led-index-t))

(defcfun ("xkb_keymap_led_get_index" xkb-keymap-led-get-index) xkb-led-index-t
  (keymap xkb-keymap)
  (name :string))

(defcfun ("xkb_keymap_num_layouts_for_key" xkb-keymap-num-layouts-for-key) xkb-layout-index-t
  (keymap xkb-keymap)
  (key xkb-keycode-t))

(defcfun ("xkb_keymap_num_levels_for_key" xkb-keymap-num-levels-for-key) xkb-level-index-t
  (keymap xkb-keymap)
  (key xkb-keycode-t)
  (layout xkb-layout-index-t))

(defcfun ("xkb_keymap_key_get_mods_for_level" xkb-keymap-key-get-mods-for-level) :size
  (keymap xkb-keymap)
  (key xkb-keycode-t)
  (layout xkb-layout-index-t)
  (level xkb-level-index-t)
  (masks-out (:pointer xkb-mod-mask-t))
  (masks-size :size))

(defcfun ("xkb_keymap_key_get_syms_by_level" xkb-keymap-key-get-syms-by-level) :int
  (keymap xkb-keymap)
  (key xkb-keycode-t)
  (layout xkb-layout-index-t)
  (level xkb-level-index-t)
  (syms-out (:pointer (:pointer xkb-keysym-t))))

(defcfun ("xkb_keymap_key_repeats" xkb-keymap-key-repeats) :int
  (keymap xkb-keymap)
  (key xkb-keycode-t))

(defcfun ("xkb_state_new" xkb-state-new) xkb-state
  (keymap xkb-keymap))

(defcfun ("xkb_state_ref" xkb-state-ref) xkb-state
  (state xkb-state))

(defcfun ("xkb_state_unref" xkb-state-unref) :void
  (state xkb-state))

(defcfun ("xkb_state_get_keymap" xkb-state-get-keymap) xkb-keymap
  (state xkb-state))

(defcfun ("xkb_state_update_key" xkb-state-update-key) :int
  (state xkb-state)
  (key xkb-keycode-t)
  (direction :int))

(defcfun ("xkb_state_update_mask" xkb-state-update-mask) :int
  (state xkb-state)
  (depressed-mods xkb-mod-mask-t)
  (latched-mods xkb-mod-mask-t)
  (locked-mods xkb-mod-mask-t)
  (depressed-layout xkb-layout-index-t)
  (latched-layout xkb-layout-index-t)
  (locked-layout xkb-layout-index-t))

(defcfun ("xkb_state_key_get_syms" xkb-state-key-get-syms) :int
  (state xkb-state)
  (key xkb-keycode-t)
  (syms-out (:pointer (:pointer xkb-keysym-t))))

(defcfun ("xkb_state_key_get_utf8" xkb-state-key-get-utf8) :int
  (state xkb-state)
  (key xkb-keycode-t)
  (buffer :pointer)
  (size :size))

(defcfun ("xkb_state_key_get_utf32" xkb-state-key-get-utf32) :uint32
  (state xkb-state)
  (key xkb-keycode-t))

(defcfun ("xkb_state_key_get_one_sym" xkb-state-key-get-one-sym) xkb-keysym-t
  (state xkb-state)
  (key xkb-keycode-t))

(defcfun ("xkb_state_key_get_layout" xkb-state-key-get-layout) xkb-layout-index-t
  (state xkb-state)
  (key xkb-keycode-t))

(defcfun ("xkb_state_key_get_level" xkb-state-key-get-level) xkb-level-index-t
  (state xkb-state)
  (key xkb-keycode-t)
  (layout xkb-layout-index-t))

(defcfun ("xkb_state_serialize_mods" xkb-state-serialize-mods) xkb-mod-mask-t
  (state xkb-state)
  (components :int))

(defcfun ("xkb_state_serialize_layout" xkb-state-serialize-layout) xkb-layout-index-t
  (state xkb-state)
  (components :int))

(defcfun ("xkb_state_mod_name_is_active" xkb-state-mod-name-is-active) :int
  (state xkb-state)
  (name :string)
  (type :int))

(defcfun ("xkb_state_mod_index_is_active" xkb-state-mod-index-is-active) :int
  (state xkb-state)
  (index xkb-mod-index-t)
  (type :int))

(defcfun ("xkb_state_key_get_consumed_mods2" xkb-state-key-get-consumed-mods2) xkb-mod-mask-t
  (state xkb-state)
  (key xkb-keycode-t)
  (mode :int))

(defcfun ("xkb_state_key_get_consumed_mods" xkb-state-key-get-consumed-mods) xkb-mod-mask-t
  (state xkb-state)
  (key xkb-keycode-t))

(defcfun ("xkb_state_mod_index_is_consumed2" xkb-state-mod-index-is-consumed2) :int
  (state xkb-state)
  (key xkb-keycode-t)
  (index xkb-mod-index-t)
  (mode :int))

(defcfun ("xkb_state_mod_index_is_consumed" xkb-state-mod-index-is-consumed) :int
  (state xkb-state)
  (key xkb-keycode-t)
  (index xkb-mod-index-t))

(defcfun ("xkb_state_mod_mask_remove_consumed" xkb-state-mod-mask-remove-consumed) xkb-mod-mask-t
  (state xkb-state)
  (key xkb-keycode-t)
  (mask xkb-mod-mask-t))

(defcfun ("xkb_state_layout_name_is_active" xkb-state-layout-name-is-active) :int
  (state xkb-state)
  (name :string)
  (type :int))

(defcfun ("xkb_state_layout_index_is_active" xkb-state-layout-index-is-active) :int
  (state xkb-state)
  (index xkb-layout-index-t)
  (type :int))

(defcfun ("xkb_state_led_name_is_active" xkb-state-led-name-is-active) :int
  (state xkb-state)
  (name :string))

(defcfun ("xkb_state_led_index_is_active" xkb-state-led-index-is-active) :int
  (state xkb-state)
  (index xkb-led-index-t))

(export '(xkb-keycode-t xkb-keysym-t xkb-layout-index-t xkb-layout-mask-t
          xkb-level-index-t xkb-mod-index-t xkb-mod-mask-t xkb-led-index-t
          xkb-led-mask-t xkb-context xkb-keymap xkb-state xkb-keymap-key-iter-t
          +xkb-keycode-invalid+ +xkb-layout-invalid+ +xkb-level-invalid+
          +xkb-mod-invalid+ +xkb-led-invalid+ +xkb-keycode-max+ +xkb-keysym-max+
          +xkb-keymap-use-original-format+ xkb-rule-names xkb-keysym-flags
          xkb-context-flags xkb-log-level xkb-keymap-compile-flags
          xkb-keymap-format xkb-key-direction xkb-state-component
          xkb-state-match xkb-consumed-mode
          xkb-keysym-get-name xkb-keysym-from-name xkb-keysym-to-utf8
          xkb-keysym-to-utf32 xkb-utf32-to-keysym xkb-keysym-to-upper
          xkb-keysym-to-lower xkb-context-new xkb-context-ref xkb-context-unref
          xkb-context-set-user-data xkb-context-get-user-data
          xkb-context-include-path-append xkb-context-include-path-append-default
          xkb-context-include-path-reset-defaults xkb-context-include-path-clear
          xkb-context-num-include-paths xkb-context-include-path-get
          xkb-context-set-log-level xkb-context-get-log-level
          xkb-context-set-log-verbosity xkb-context-get-log-verbosity
          xkb-keymap-new-from-names xkb-keymap-new-from-file
          xkb-keymap-new-from-string xkb-keymap-new-from-buffer xkb-keymap-ref
          xkb-keymap-unref xkb-keymap-get-as-string xkb-keymap-min-keycode
          xkb-keymap-max-keycode xkb-keymap-key-for-each xkb-keymap-key-get-name
          xkb-keymap-key-by-name xkb-keymap-num-mods xkb-keymap-mod-get-name
          xkb-keymap-mod-get-index xkb-keymap-num-layouts xkb-keymap-layout-get-name
          xkb-keymap-layout-get-index xkb-keymap-num-leds xkb-keymap-led-get-name
          xkb-keymap-led-get-index xkb-keymap-num-layouts-for-key
          xkb-keymap-num-levels-for-key xkb-keymap-key-get-mods-for-level
          xkb-keymap-key-get-syms-by-level xkb-keymap-key-repeats
          xkb-state-new xkb-state-ref xkb-state-unref xkb-state-get-keymap
          xkb-state-update-key xkb-state-update-mask xkb-state-key-get-syms
          xkb-state-key-get-utf8 xkb-state-key-get-utf32 xkb-state-key-get-one-sym
          xkb-state-key-get-layout xkb-state-key-get-level xkb-state-serialize-mods
          xkb-state-serialize-layout xkb-state-mod-name-is-active
          xkb-state-mod-index-is-active xkb-state-key-get-consumed-mods2
          xkb-state-key-get-consumed-mods xkb-state-mod-index-is-consumed2
          xkb-state-mod-index-is-consumed xkb-state-mod-mask-remove-consumed
          xkb-state-layout-name-is-active xkb-state-layout-index-is-active
          xkb-state-led-name-is-active xkb-state-led-index-is-active))
