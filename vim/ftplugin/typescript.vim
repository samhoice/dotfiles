setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal shiftwidth=2

setlocal number

noremap <localleader>b. :!npm run prettier -w %<cr>
