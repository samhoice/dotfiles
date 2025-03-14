setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal shiftwidth=2

setlocal number

"noremap <localleader>b. :!bun run prettier -w %<cr>
noremap <localleader>b. :!prettier -w %<cr>

"let b:compiler = 'eslint'
"let b:dispatch = 'eslint --format compact %'
