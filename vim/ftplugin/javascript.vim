setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal shiftwidth=2

setlocal number

noremap <localleader>b. :!bun run prettier -w %<cr>
