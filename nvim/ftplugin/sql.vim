setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
set number

let b:ale_linters = ['sqlfluff']
" let b:ale_linters = ['pgformatter']

let b:ale_fixers = ['pgformatter', 'trim_whitespace']
" let b:ale_fixers = ['sqlfluff', 'trim_whitespace']
