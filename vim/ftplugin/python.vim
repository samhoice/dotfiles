setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
"setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

setlocal number

" blacken
noremap <localleader>b. :!black %<cr>
noremap <localleader>b :!black 
" isort
noremap <localleader>is. :!isort %<cr>

" insert the python debugger line
" nr2char is ascii to character, handy to insert newline
noremap <localleader>db :execute':normal! I'.'import pdb; pdb.set_trace()'.nr2char(10)<cr>
" crude 'what function am I in'
" search backwards for 'def'
noremap <localleader>gd ?^\s*def\s<cr>
