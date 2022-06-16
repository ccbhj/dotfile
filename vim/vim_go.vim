" vim-go setting
au FileType go nmap gV <Plug>(go-def-vertical)
au FileType go nmap gT <Plug>(go-def-tab)

let g:go_highlight_extra_types = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_debug=1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1

let g:go_test_timeout = '10s'
let g:go_decls_includes = "func"
let g:go_auto_type_info = 1
let g:go_doc_popup_window = 1
let g:go_test_show_name = 1
 
let g:go_debug_mappings = {
  \ '(go-debug-continue)':   {'key': '<F5>'},
  \ '(go-debug-print)':      {'key': '<F6>'},
  \ '(go-debug-breakpoint)': {'key': '<F9>'},
  \ '(go-debug-next)':       {'key': '<F10>'},
  \ '(go-debug-step)':       {'key': '<F11>'},
  \ '(go-debug-halt)':       {'key': '<F12>'},
  \ }

let g:go_def_mapping_enabled = 1
let g:go_diagnostics_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_jump_to_error = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_def_reuse_buffer = 1
let g:go_fmt_autosave = 1
