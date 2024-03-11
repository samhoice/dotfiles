setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal shiftwidth=2

" noremap <localleader>dv :r ~/.vim/snips/django_var<cr>
" noremap <localleader>dt :r ~/.vim/snips/django_tag<cr>

" django snippets
noremap <localleader>dv :execute "normal! i{{  }}"<cr>hh
noremap <localleader>dt :execute "normal! i{%  %}"<cr>hh

# html snippets
noremap <localleader>ha :execute "normal! i<a href=\"\"></a>"<cr>
noremap <localleader>hd :execute "normal! i<div></div>"<cr>hhhhh
